import 'package:drift/drift.dart';
import 'package:game_tracker/data/db/tables/player_table.dart';

class GameTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get winnerId =>
      text().references(PlayerTable, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
