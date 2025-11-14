import 'package:drift/drift.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/db/tables/player_game_table.dart';
import 'package:game_tracker/data/dto/player.dart';

part 'player_game_dao.g.dart';

@DriftAccessor(tables: [PlayerGameTable])
class PlayerGameDao extends DatabaseAccessor<AppDatabase>
    with _$PlayerGameDaoMixin {
  PlayerGameDao(super.db);

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

  /// Retrieves a list of [Player]s associated with the given [gameId].
  /// Returns an empty list if no players are found.
  Future<List<Player>> getPlayersByGameId({required String gameId}) async {
    final result = await (select(
      playerGameTable,
    )..where((p) => p.gameId.equals(gameId))).get();

    if (result.isEmpty) return <Player>[];

    final futures = result.map(
      (row) => db.playerDao.getPlayerById(playerId: row.playerId),
    );
    final players = await Future.wait(futures);
    return players.whereType<Player>().toList();
  }

  /// Associates a player with a game by inserting a record into the
  /// [PlayerGameTable].
  Future<void> addPlayerToGame({
    required String gameId,
    required String playerId,
  }) async {
    await into(playerGameTable).insert(
      PlayerGameTableCompanion.insert(playerId: playerId, gameId: gameId),
    );
  }
}
