import 'package:drift/drift.dart';
import 'package:game_tracker/data/methods/db/tables/group_table.dart';
import 'package:game_tracker/data/methods/db/tables/user_table.dart';

class PlayerGroupTable extends Table {
  TextColumn get userId => text().references(UserTable, #id)();
  TextColumn get groupId => text().references(GroupTable, #id)();

  @override
  Set<Column<Object>> get primaryKey => {userId, groupId};
}
