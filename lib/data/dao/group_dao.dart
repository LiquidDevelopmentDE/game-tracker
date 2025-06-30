import 'package:game_tracker/data/database.dart';
import 'package:drift/drift.dart';

extension GroupDao on AppDatabase {
  Future<List<GroupTableData>> getAllGroups() async {
    return await select(groupTable).get();
  }

  Future<GroupTableData> getGroupById(String id) async {
    return await (select(
      groupTable,
    )..where((gr) => gr.id.equals(id))).getSingle();
  }

  Future<void> addGroup(String id, String name) async {
    await into(
      groupTable,
    ).insert(GroupTableCompanion.insert(id: id, name: name));
  }

  Future<void> deleteGroupById(String id) async {
    await (delete(groupTable)..where((gr) => gr.id.equals(id))).go();
  }

  Future<void> updateGroupNameById(String id, String newName) async {
    await (update(groupTable)..where((gr) => gr.id.equals(id))).write(
      GroupTableCompanion(name: Value(newName)),
    );
  }
}
