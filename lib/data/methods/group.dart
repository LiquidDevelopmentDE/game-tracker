import 'package:game_tracker/data/database.dart';
import 'package:drift/drift.dart';

extension Group on AppDatabase {
  Future<List<GroupData>> getAllGroups() async {
    return await select(group).get();
  }

  Future<List<GroupData>> getGroupById(String id) async {
    return await (select(group)..where((g) => g.id.equals(id))).get();
  }

  Future<void> addGroup(String id, String name) async {
    await into(group).insert(
      GroupCompanion.insert(id: id, name: name),
    );
  }

  Future<void> deleteGroup(String id) async {
    await (delete(group)..where((g) => g.id.equals(id))).go();
  }

  Future<void> updateGroupname(String id, String newName) async {
    await (update(group)..where((u) => u.id.equals(id))).write(
      GroupCompanion(name: Value(newName)),
    );
  }
}