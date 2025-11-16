import 'package:drift/drift.dart';
import 'package:game_tracker/data/db/tables/game_table.dart';
import 'package:game_tracker/data/db/tables/player_table.dart';

class PlayerGameTable extends Table {
  TextColumn get playerId =>
      text().references(PlayerTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get gameId =>
      text().references(GameTable, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column<Object>> get primaryKey => {playerId, gameId};
}
