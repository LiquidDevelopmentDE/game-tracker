import 'package:drift/drift.dart';
import 'group_table.dart';
import 'user_table.dart';


class UserGroupTable extends Table {
  TextColumn get userId => text().references(UserTable, #id)();
  TextColumn get groupId => text().references(GroupTable, #id)();

  @override
  Set<Column<Object>> get primaryKey => {userId, groupId};
}