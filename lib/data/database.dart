import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:game_tracker/data/tables/user_table.dart';
import 'package:game_tracker/data/tables/group_table.dart';
import 'package:game_tracker/data/tables/user_group_table.dart';
import 'package:game_tracker/data/tables/game_table.dart';
import 'package:game_tracker/data/tables/match_table.dart';
import 'package:game_tracker/data/tables/result_score_table.dart';
import 'package:game_tracker/data/tables/result_win_table.dart';
import 'package:game_tracker/data/tables/result_placement_table.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    UserTable,
    GroupTable,
    UserGroupTable,
    GameTable,
    MatchTable,
    ResultScoreTable,
    ResultWinTable,
    ResultPlacementTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'gametracker_db',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
