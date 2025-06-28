import 'package:drift/drift.dart';
import 'match_table.dart';
import 'user_table.dart';

class ResultPlacementTable extends Table {
  TextColumn get matchId => text().references(MatchTable, #id)();
  TextColumn get userId => text().references(UserTable, #id)();
  IntColumn get placement => integer()();

  @override
  Set<Column<Object>> get primaryKey => {matchId, userId};
}