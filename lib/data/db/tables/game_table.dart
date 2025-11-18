import 'package:drift/drift.dart';

class GameTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  late final winnerId = text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
