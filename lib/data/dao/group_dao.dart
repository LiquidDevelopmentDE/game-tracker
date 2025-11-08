import 'package:drift/drift.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/db/tables/group_table.dart';
import 'package:game_tracker/data/dto/group.dart';

part 'group_dao.g.dart';

@DriftAccessor(tables: [GroupTable])
class GroupDao extends DatabaseAccessor<AppDatabase> with _$GroupDaoMixin {
  GroupDao(super.db);

  Future<List<Group>> getAllGroups() async {
    final query = select(groupTable);
    final result = await query.get();
    return result
        .map((row) => Group(id: row.id, name: row.name, members: []))
        .toList();
  }

  Future<Group> getGroupById(String id) async {
    final query = select(groupTable)..where((g) => g.id.equals(id));
    final result = await query.getSingle();

    // todo: Get group members

    return Group(id: result.id, name: result.name, members: []);
  }

  Future<void> addGroup(String id, String name) async {
    await into(group).insert(GroupCompanion.insert(id: id, name: name));
  }

  Future<void> deleteGroup(String id) async {
    await (delete(group)..where((g) => g.id.equals(id))).go();
  }

  Future<void> updateGroupname(String id, String newName) async {
    await (update(group)..where((g) => g.id.equals(id))).write(
      GroupCompanion(name: Value(newName)),
    );
  }
}
