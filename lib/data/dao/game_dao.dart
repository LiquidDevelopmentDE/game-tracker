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
    return result.map((row) => Game(id: row.id, name: row.name)).toList();
  }

  /// Retrieves a [Game] by its [gameId].
  Future<Game> getGameById(String gameId) async {
    final query = select(gameTable)..where((g) => g.id.equals(gameId));
    final result = await query.getSingle();

    List<Player>? players;
    if (await db.playerGameDao.hasGamePlayers(gameId)) {
      players = await db.playerGameDao.getPlayersByGameId(gameId);
    }
    Group? group;
    if (await db.groupGameDao.hasGameGroup(gameId)) {
      group = await db.groupGameDao.getGroupByGameId(gameId);
    }

    return Game(
      id: result.id,
      name: result.name,
      players: players,
      group: group,
      winner: result.winnerId,
    );
  }

  Future<void> addGame(Game game) async {
    await db.transaction(() async {
      for (final p in game.players ?? []) {
        await db.playerDao.addPlayer(p);
        await db.playerGameDao.addPlayerToGame(game.id, p.id);
      }
      if (game.group != null) {
        await db.groupDao.addGroup(game.group!);
        await db.groupGameDao.addGroupToGame(game.id, game.group!.id);
      }
      await into(gameTable).insert(
        GameTableCompanion.insert(
          id: game.id,
          name: game.name,
          winnerId: Value(game.winner),
        ),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  /// Retrieves the number of games in the database.
  Future<int> getGameCount() async {
    final count =
        await (selectOnly(gameTable)..addColumns([gameTable.id.count()]))
            .map((row) => row.read(gameTable.id.count()))
            .getSingle();
    return count ?? 0;
  }
}
