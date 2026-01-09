import 'package:drift/drift.dart';

class MatchTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  late final winnerId = text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
