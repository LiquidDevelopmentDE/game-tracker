import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:game_tracker/data/dao/group_dao.dart';
import 'package:game_tracker/data/dao/player_dao.dart';
import 'package:game_tracker/data/dao/player_group_dao.dart';
import 'package:game_tracker/data/db/tables/group_table.dart';
import 'package:game_tracker/data/db/tables/player_group_table.dart';
import 'package:game_tracker/data/db/tables/player_table.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [PlayerTable, GroupTable, PlayerGroupTable],
  daos: [GroupDao, PlayerDao, PlayerGroupDao],
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
