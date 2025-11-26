import 'package:drift/drift.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/db/tables/player_game_table.dart';
import 'package:game_tracker/data/dto/player.dart';

part 'player_game_dao.g.dart';

@DriftAccessor(tables: [PlayerGameTable])
class PlayerGameDao extends DatabaseAccessor<AppDatabase>
    with _$PlayerGameDaoMixin {
  PlayerGameDao(super.db);

  /// Associates a player with a game by inserting a record into the
  /// [PlayerGameTable].
  Future<void> addPlayerToGame({
    required String gameId,
    required String playerId,
  }) async {
    await into(playerGameTable).insert(
      PlayerGameTableCompanion.insert(playerId: playerId, gameId: gameId),
      mode: InsertMode.insertOrReplace,
    );
  }

  /// Retrieves a list of [Player]s associated with the given [gameId].
  /// Returns null if no players are found.
  Future<List<Player>?> getPlayersOfGame({required String gameId}) async {
    final result = await (select(
      playerGameTable,
    )..where((p) => p.gameId.equals(gameId))).get();

    if (result.isEmpty) return null;

    final futures = result.map(
      (row) => db.playerDao.getPlayerById(playerId: row.playerId),
    );
    final players = await Future.wait(futures);
    return players;
  }

  /// Checks if there are any players associated with the given [gameId].
  /// Returns `true` if there are players, otherwise `false`.
  Future<bool> gameHasPlayers({required String gameId}) async {
    final count =
        await (selectOnly(playerGameTable)
              ..where(playerGameTable.gameId.equals(gameId))
              ..addColumns([playerGameTable.playerId.count()]))
            .map((row) => row.read(playerGameTable.playerId.count()))
            .getSingle();
    return (count ?? 0) > 0;
  }

  /// Checks if a specific player is associated with a specific game.
  /// Returns `true` if the player is in the game, otherwise `false`.
  Future<bool> isPlayerInGame({
    required String gameId,
    required String playerId,
  }) async {
    final count =
        await (selectOnly(playerGameTable)
              ..where(playerGameTable.gameId.equals(gameId))
              ..where(playerGameTable.playerId.equals(playerId))
              ..addColumns([playerGameTable.playerId.count()]))
            .map((row) => row.read(playerGameTable.playerId.count()))
            .getSingle();
    return (count ?? 0) > 0;
  }

  /// Removes the association of a player with a game by deleting the record
  /// from the [PlayerGameTable].
  /// Returns `true` if more than 0 rows were affected, otherwise `false`.
  Future<bool> removePlayerFromGame({
    required String gameId,
    required String playerId,
  }) async {
    final query = delete(playerGameTable)
      ..where((pg) => pg.gameId.equals(gameId))
      ..where((pg) => pg.playerId.equals(playerId));
    final rowsAffected = await query.go();
    return rowsAffected > 0;
  }

  /// Updates the players associated with a game based on the provided
  /// [newPlayer] list. It adds new players and removes players that are no
  /// longer associated with the game.
  Future<void> updatePlayersFromGame({
    required String gameId,
    required List<Player> newPlayer,
  }) async {
    final currentPlayers = await getPlayersOfGame(gameId: gameId);
    // Create sets of player IDs for easy comparison
    final currentPlayerIds = currentPlayers?.map((p) => p.id).toSet() ?? {};
    final newPlayerIdsSet = newPlayer.map((p) => p.id).toSet();

    // Determine players to add and remove
    final playersToAdd = newPlayerIdsSet.difference(currentPlayerIds);
    final playersToRemove = currentPlayerIds.difference(newPlayerIdsSet);

    db.transaction(() async {
      // Remove old players
      if (playersToRemove.isNotEmpty) {
        await (delete(playerGameTable)..where(
              (pg) =>
                  pg.gameId.equals(gameId) &
                  pg.playerId.isIn(playersToRemove.toList()),
            ))
            .go();
      }

      // Add new players
      if (playersToAdd.isNotEmpty) {
        final inserts = playersToAdd
            .map(
              (id) =>
                  PlayerGameTableCompanion.insert(playerId: id, gameId: gameId),
            )
            .toList();
        await Future.wait(
          inserts.map(
            (c) => into(
              playerGameTable,
            ).insert(c, mode: InsertMode.insertOrReplace),
          ),
        );
      }
    });
  }
}
