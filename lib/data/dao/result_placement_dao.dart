import 'package:game_tracker/data/database.dart';
import 'package:drift/drift.dart';

extension ResultPlacementDao on AppDatabase {
  Future<List<ResultPlacementTableData>> getAllResultPlacements() async {
    return await select(resultPlacementTable).get();
  }

  Future<List<ResultPlacementTableData>> getAllResultPlacementsByMatchId(String matchId) async {
    return await (select(
      resultPlacementTable,
    )..where((rP) => rP.matchId.equals(matchId))).get();
  }

  Future<List<ResultPlacementTableData>> getAllResultPlacementsByUserId(String userId) async {
    return await (select(
      resultPlacementTable,
    )..where((rP) => rP.matchId.equals(userId))).get();
  }

  Future<void> addResultPlacement(String matchId, String userId, int placement) async {
    await into(
      resultPlacementTable,
    ).insert(ResultPlacementTableCompanion.insert(matchId: matchId, userId: userId, placement: placement));
  }

  Future<void> deleteResultPlacementsByMatchId(String matchId) async {
    await (delete(resultPlacementTable)..where((rP) => rP.matchId.equals(matchId))).go();
  }

  Future<void> updateResultPlacementByMatchIdAndUserId(String matchId, String userId, int placement) async {
    await (update(resultPlacementTable)..where((rP) => rP.matchId.equals(matchId))..where((rP) => rP.userId.equals(userId))).write(
      ResultPlacementTableCompanion(placement: Value(placement)),
    );
  }
}
