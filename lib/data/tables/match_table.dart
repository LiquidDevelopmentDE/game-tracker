import 'package:drift/drift.dart';
import 'game_table.dart';
import 'group_table.dart';

class MatchTable extends Table {
  TextColumn get id => text()();
  IntColumn get gameId => integer().references(GameTable, #id)();
  TextColumn get groupId => text().nullable().references(GroupTable, #id)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
