import 'package:game_tracker/data/database.dart';
import 'package:drift/drift.dart';

extension ResultScoreDao on AppDatabase {
    Future<List<ResultScoreTableData>> getAllResultScores() async {
    return await select(resultScoreTable).get();
  }

  Future<List<ResultScoreTableData>> getAllResultScoresByMatchId(String matchId) async {
    return await (select(
      resultScoreTable,
    )..where((rS) => rS.matchId.equals(matchId))).get();
  }

  Future<List<ResultScoreTableData>> getAllResultScoresByUserId(String userId) async {
    return await (select(
      resultScoreTable,
    )..where((rS) => rS.matchId.equals(userId))).get();
  }

  Future<void> addResultScore(String matchId, String userId, int score) async {
    await into(
      resultScoreTable,
    ).insert(ResultScoreTableCompanion.insert(matchId: matchId, userId: userId, score: score));
  }

  Future<void> deleteResultScoresByMatchId(String matchId) async {
    await (delete(resultScoreTable)..where((rS) => rS.matchId.equals(matchId))).go();
  }

  Future<void> updateResultScore(String matchId, String userId, int score) async {
    await (update(resultScoreTable)..where((rS) => rS.matchId.equals(matchId))..where((rS) => rS.userId.equals(userId))).write(
      ResultScoreTableCompanion(score: Value(score)),
    );
  }
}
