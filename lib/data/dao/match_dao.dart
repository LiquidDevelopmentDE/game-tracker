import 'package:game_tracker/data/database.dart';

extension MatchDao on AppDatabase {
  Future<List<MatchTableData>> getAllMatches() async {
    return await select(matchTable).get();
  }

  Future<MatchTableData> getMatchById(String id) async {
    return await (select(
      matchTable,
    )..where((m) => m.id.equals(id))).getSingle();
  }

  Future<void> addMatch(String matchId, int gameId, String groupId, DateTime createdAt) async {
    await into(
      matchTable,
    ).insert(MatchTableCompanion.insert(id: matchId, gameId: gameId, groupId: groupId, createdAt: createdAt));
  }

  Future<void> deleteMatchById(String id) async {
    await (delete(matchTable)..where((m) => m.id.equals(id))).go();
  }
}