import 'package:game_tracker/data/database.dart';
import 'package:drift/drift.dart';

extension ResultWinDao on AppDatabase {
    Future<List<ResultWinTableData>> getAllResultWins() async {
    return await select(resultWinTable).get();
  }

  Future<ResultWinTableData> getResultWinByMatchId(String matchId) async {
    return await (select(
      resultWinTable,
    )..where((rW) => rW.matchId.equals(matchId))).getSingle();
  }

  Future<List<ResultWinTableData>> getAllResultWinsByUserId(String userId) async {
    return await (select(
      resultWinTable,
    )..where((rW) => rW.matchId.equals(userId))).get();
  }

  Future<void> addResultWin(String matchId, String winnerId) async {
    await into(
      resultWinTable,
    ).insert(ResultWinTableCompanion.insert(matchId: matchId, winnerId: winnerId));
  }

  Future<void> deleteResultWinByMatchId(String matchId) async {
    await (delete(resultWinTable)..where((rW) => rW.matchId.equals(matchId))).go();
  }

  Future<void> updateResultWin(String matchId, String newWinnerId) async {
    await (update(resultWinTable)..where((rW) => rW.matchId.equals(matchId))).write(
      ResultWinTableCompanion(winnerId: Value(newWinnerId)),
    );
  }
}
