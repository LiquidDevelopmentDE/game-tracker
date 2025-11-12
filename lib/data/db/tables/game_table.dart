import 'package:drift/drift.dart';

class GameTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  // todo: winner id needs to be deleted when corresponding player gets deleted
  TextColumn get winnerId => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
