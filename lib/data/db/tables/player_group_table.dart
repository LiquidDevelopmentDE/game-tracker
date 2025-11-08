import 'package:drift/drift.dart';
import 'package:game_tracker/data/db/tables/group_table.dart';
import 'package:game_tracker/data/db/tables/player_table.dart';

class PlayerGroupTable extends Table {
  TextColumn get userId => text().references(PlayerTable, #id)();
  TextColumn get groupId => text().references(GroupTable, #id)();

  @override
  Set<Column<Object>> get primaryKey => {userId, groupId};
}
