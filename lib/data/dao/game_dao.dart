import 'package:game_tracker/data/database.dart';
import 'package:drift/drift.dart';

extension GameDao on AppDatabase {
  Future<List<GameTableData>> getAllGames() async {
    return await select(gameTable).get();
  }

  Future<GameTableData> getGameById(int id) async {
    return await (select(
      gameTable,
    )..where((ga) => ga.id.equals(id))).getSingle();
  }

  Future<void> addGame(int id, String name) async {
    await into(
      gameTable,
    ).insert(GameTableCompanion.insert(name: name));
  }

  Future<void> deleteGameById(int id) async {
    await (delete(gameTable)..where((ga) => ga.id.equals(id))).go();
  }

  Future<void> updateGameName(int id, String newName) async {
    await (update(gameTable)..where((ga) => ga.id.equals(id))).write(
      GameTableCompanion(name: Value(newName)),
    );
  }
}
