import 'package:drift/drift.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/db/tables/game_table.dart';
import 'package:game_tracker/data/dto/game.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/player.dart';

part 'game_dao.g.dart';

@DriftAccessor(tables: [GameTable])
class GameDao extends DatabaseAccessor<AppDatabase> with _$GameDaoMixin {
  GameDao(super.db);

  /// Retrieves all games from the database.
  Future<List<Game>> getAllGames() async {
    final query = select(gameTable);
    final result = await query.get();

    return Future.wait(
      result.map((row) async {
        final group = await db.groupGameDao.getGroupOfGame(gameId: row.id);
        final players = await db.playerGameDao.getPlayersOfGame(gameId: row.id);
        final winner = row.winnerId != null
            ? await db.playerDao.getPlayerById(playerId: row.winnerId!)
            : null;
        return Game(
          id: row.id,
          name: row.name,
          group: group,
          players: players,
          createdAt: row.createdAt,
          winner: winner,
        );
      }),
    );
  }

  /// Retrieves a [Game] by its [gameId].
  Future<Game> getGameById({required String gameId}) async {
    final query = select(gameTable)..where((g) => g.id.equals(gameId));
    final result = await query.getSingle();

    List<Player>? players;
    if (await db.playerGameDao.gameHasPlayers(gameId: gameId)) {
      players = await db.playerGameDao.getPlayersOfGame(gameId: gameId);
    }
    Group? group;
    if (await db.groupGameDao.gameHasGroup(gameId: gameId)) {
      group = await db.groupGameDao.getGroupOfGame(gameId: gameId);
    }
    Player? winner;
    if (result.winnerId != null) {
      winner = await db.playerDao.getPlayerById(playerId: result.winnerId!);
    }

    return Game(
      id: result.id,
      name: result.name,
      players: players,
      group: group,
      winner: winner,
      createdAt: result.createdAt,
    );
  }

  /// Adds a new [Game] to the database.
  /// Also adds associated players and group if they exist.
  Future<void> addGame({required Game game}) async {
    await db.transaction(() async {
      await into(gameTable).insert(
        GameTableCompanion.insert(
          id: game.id,
          name: game.name,
          winnerId: Value(game.winner?.id),
          createdAt: game.createdAt,
        ),
        mode: InsertMode.insertOrReplace,
      );

      if (game.players != null) {
        await db.playerDao.addPlayersAsList(players: game.players!);
        for (final p in game.players ?? []) {
          await db.playerGameDao.addPlayerToGame(
            gameId: game.id,
            playerId: p.id,
          );
        }
      }

      if (game.group != null) {
        await db.groupDao.addGroup(group: game.group!);
        await db.groupGameDao.addGroupToGame(
          gameId: game.id,
          groupId: game.group!.id,
        );
      }
    });
  }

  /// Adds multiple [Game]s to the database in a batch operation.
  /// Also adds associated players and groups if they exist.
  /// If the [games] list is empty, the method returns immediately.
  Future<void> addGamesAsList({required List<Game> games}) async {
    if (games.isEmpty) return;
    await db.transaction(() async {
      // Add all games in batch
      await db.batch(
        (b) => b.insertAll(
          gameTable,
          games
              .map(
                (game) => GameTableCompanion.insert(
                  id: game.id,
                  name: game.name,
                  createdAt: game.createdAt,
                  winnerId: Value(game.winner?.id),
                ),
              )
              .toList(),
          mode: InsertMode.insertOrReplace,
        ),
      );

      // Add all groups of the games in batch
      await db.batch(
        (b) => b.insertAll(
          db.groupTable,
          games
              .where((game) => game.group != null)
              .map(
                (game) => GroupTableCompanion.insert(
                  id: game.group!.id,
                  name: game.group!.name,
                  createdAt: game.group!.createdAt,
                ),
              )
              .toList(),
          mode: InsertMode.insertOrReplace,
        ),
      );

      // Add all players of the games in batch (unique)
      final uniquePlayers = <String, Player>{};
      for (final game in games) {
        if (game.players != null) {
          for (final p in game.players!) {
            uniquePlayers[p.id] = p;
          }
        }
        // Also include members of groups
        if (game.group != null) {
          for (final m in game.group!.members) {
            uniquePlayers[m.id] = m;
          }
        }
      }

      if (uniquePlayers.isNotEmpty) {
        await db.batch(
          (b) => b.insertAll(
            db.playerTable,
            uniquePlayers.values
                .map(
                  (p) => PlayerTableCompanion.insert(
                    id: p.id,
                    name: p.name,
                    createdAt: p.createdAt,
                  ),
                )
                .toList(),
            mode: InsertMode.insertOrReplace,
          ),
        );
      }

      // Add all player-game associations in batch
      await db.batch((b) {
        for (final game in games) {
          if (game.players != null) {
            for (final p in game.players ?? []) {
              b.insert(
                db.playerGameTable,
                PlayerGameTableCompanion.insert(
                  gameId: game.id,
                  playerId: p.id,
                ),
                mode: InsertMode.insertOrReplace,
              );
            }
          }
        }
      });

      // Add all player-group associations in batch
      await db.batch((b) {
        for (final game in games) {
          if (game.group != null) {
            for (final m in game.group!.members) {
              b.insert(
                db.playerGroupTable,
                PlayerGroupTableCompanion.insert(
                  playerId: m.id,
                  groupId: game.group!.id,
                ),
                mode: InsertMode.insertOrReplace,
              );
            }
          }
        }
      });

      // Add all group-game associations in batch
      await db.batch((b) {
        for (final game in games) {
          if (game.group != null) {
            b.insert(
              db.groupGameTable,
              GroupGameTableCompanion.insert(
                gameId: game.id,
                groupId: game.group!.id,
              ),
              mode: InsertMode.insertOrReplace,
            );
          }
        }
      });
    });
  }

  /// Deletes the game with the given [gameId] from the database.
  /// Returns `true` if more than 0 rows were affected, otherwise `false`.
  Future<bool> deleteGame({required String gameId}) async {
    final query = delete(gameTable)..where((g) => g.id.equals(gameId));
    final rowsAffected = await query.go();
    return rowsAffected > 0;
  }

  /// Retrieves the number of games in the database.
  Future<int> getGameCount() async {
    final count =
        await (selectOnly(gameTable)..addColumns([gameTable.id.count()]))
            .map((row) => row.read(gameTable.id.count()))
            .getSingle();
    return count ?? 0;
  }

  /// Checks if a game with the given [gameId] exists in the database.
  /// Returns `true` if the game exists, otherwise `false`.
  Future<bool> gameExists({required String gameId}) async {
    final query = select(gameTable)..where((g) => g.id.equals(gameId));
    final result = await query.getSingleOrNull();
    return result != null;
  }

  /// Deletes all games from the database.
  /// Returns `true` if more than 0 rows were affected, otherwise `false`.
  Future<bool> deleteAllGames() async {
    final query = delete(gameTable);
    final rowsAffected = await query.go();
    return rowsAffected > 0;
  }

  /// Sets the winner of the game with the given [gameId] to the player with
  /// the given [winnerId].
  /// Returns `true` if more than 0 rows were affected, otherwise `false`.
  Future<bool> setWinner({
    required String gameId,
    required String winnerId,
  }) async {
    final query = update(gameTable)..where((g) => g.id.equals(gameId));
    final rowsAffected = await query.write(
      GameTableCompanion(winnerId: Value(winnerId)),
    );
    return rowsAffected > 0;
  }

  /// Retrieves the winner of the game with the given [gameId].
  /// Returns the [Player] who won the game, or `null` if no winner is set.
  Future<Player?> getWinner({required String gameId}) async {
    final query = select(gameTable)..where((g) => g.id.equals(gameId));
    final result = await query.getSingleOrNull();
    if (result == null || result.winnerId == null) {
      return null;
    }
    final winner = await db.playerDao.getPlayerById(playerId: result.winnerId!);
    return winner;
  }

  /// Removes the winner of the game with the given [gameId].
  /// Returns `true` if more than 0 rows were affected, otherwise `false`.
  Future<bool> removeWinner({required String gameId}) async {
    final query = update(gameTable)..where((g) => g.id.equals(gameId));
    final rowsAffected = await query.write(
      const GameTableCompanion(winnerId: Value(null)),
    );
    return rowsAffected > 0;
  }

  /// Checks if the game with the given [gameId] has a winner set.
  /// Returns `true` if a winner is set, otherwise `false`.
  Future<bool> hasWinner({required String gameId}) async {
    final query = select(gameTable)
      ..where((g) => g.id.equals(gameId) & g.winnerId.isNotNull());
    final result = await query.getSingleOrNull();
    return result != null;
  }

  /// Changes the title of the game with the given [gameId] to [newName].
  /// Returns `true` if more than 0 rows were affected, otherwise `false`.
  Future<bool> updateGameName({
    required String gameId,
    required String newName,
  }) async {
    final query = update(gameTable)..where((g) => g.id.equals(gameId));
    final rowsAffected = await query.write(
      GameTableCompanion(name: Value(newName)),
    );
    return rowsAffected > 0;
  }
}
