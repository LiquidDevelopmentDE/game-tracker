import 'package:drift/drift.dart';

class GameTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get ruleset => text()();
  TextColumn get description => text().nullable()();
  TextColumn get color => text().nullable()();
  TextColumn get icon => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
