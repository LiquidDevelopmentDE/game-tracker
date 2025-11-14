import 'package:drift/drift.dart';
import 'package:game_tracker/data/db/tables/game_table.dart';
import 'package:game_tracker/data/db/tables/group_table.dart';

class GroupGameTable extends Table {
  TextColumn get groupId =>
      text().references(GroupTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get gameId =>
      text().references(GameTable, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column<Object>> get primaryKey => {groupId, gameId};
}
