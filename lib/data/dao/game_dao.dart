import 'package:drift/drift.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/db/tables/game_table.dart';
import 'package:game_tracker/data/dto/game.dart';

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

  /// Retrieves a [Game] by its [id].
  Future<Game> getGameById(String id) async {
    final query = select(gameTable)..where((g) => g.id.equals(id));
    final result = await query.getSingle();
    return Game(id: result.id, name: result.name);
  }
}
