import 'package:drift/drift.dart';
import 'package:game_tracker/data/db/tables/group_table.dart';
import 'package:game_tracker/data/db/tables/player_table.dart';

class GroupGameTable extends Table {
  TextColumn get groupId => text().references(PlayerTable, #id)();
  TextColumn get gameId => text().references(GroupTable, #id)();

  @override
  Set<Column<Object>> get primaryKey => {groupId, gameId};
}
