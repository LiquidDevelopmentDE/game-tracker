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
        final group = await db.groupGameDao.getGroupByGameId(gameId: row.id);
        final player = await db.playerGameDao.getPlayersByGameId(
          gameId: row.id,
        );
        return Game(
          id: row.id,
          name: row.name,
          group: group,
          players: player,
          createdAt: row.createdAt,
          winner: row.winnerId,
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
      players = await db.playerGameDao.getPlayersByGameId(gameId: gameId);
    }
    Group? group;
    if (await db.groupGameDao.hasGameGroup(gameId: gameId)) {
      group = await db.groupGameDao.getGroupByGameId(gameId: gameId);
    }

    return Game(
      id: result.id,
      name: result.name,
      players: players,
      group: group,
      winner: result.winnerId,
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
          winnerId: Value(game.winner),
          createdAt: game.createdAt,
        ),
        mode: InsertMode.insertOrReplace,
      );

      if (game.players != null) {
        await db.playerDao.addPlayers(players: game.players!);
        for (final p in game.players ?? []) {
          await db.playerGameDao.addPlayerToGame(
            gameId: game.id,
            playerId: p.id,
          );
        }
      }

      if (game.group != null) {
        await db.groupDao.addGroup(group: game.group!);
        await db.groupGameDao.addGroupToGame(game.id, game.group!.id);
      }
    });
  }

  Future<void> addGames({required List<Game> games}) async {
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
                  winnerId: Value(game.winner),
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

      // Add all players of the games in batch
      await db.batch((b) async {
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

      // Add all group-game associations in batch
      await db.batch((b) async {
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

      // Add all player-game associations in batch
      await db.batch((b) async {
        for (final game in games) {
          if (game.players != null) {
            for (final p in game.players ?? []) {
              b.insert(
                db.playerTable,
                PlayerTableCompanion.insert(
                  id: p.id,
                  name: p.name,
                  createdAt: p.createdAt,
                ),
                mode: InsertMode.insertOrReplace,
              );
            }
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
}
