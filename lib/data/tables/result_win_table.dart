import 'package:drift/drift.dart';
import 'match_table.dart';
import 'user_table.dart';

class ResultWinTable extends Table {
  TextColumn get matchId => text().references(MatchTable, #id)();
  TextColumn get winnerId => text().references(UserTable, #id)();

  @override
  Set<Column<Object>> get primaryKey => {matchId, winnerId};
}