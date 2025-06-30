import 'package:drift/drift.dart';

class UserTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get surname => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
