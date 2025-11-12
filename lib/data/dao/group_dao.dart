import 'package:drift/drift.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/db/tables/group_table.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/player.dart';

part 'group_dao.g.dart';

@DriftAccessor(tables: [GroupTable])
class GroupDao extends DatabaseAccessor<AppDatabase> with _$GroupDaoMixin {
  GroupDao(super.db);

  /// Retrieves all groups from the database.
  Future<List<Group>> getAllGroups() async {
    final query = select(groupTable);
    final result = await query.get();
    return result
        .map((row) => Group(id: row.id, name: row.name, members: []))
        .toList();
  }

  /// Retrieves a [Group] by its [id], including its members.
  Future<Group> getGroupById(String id) async {
    final query = select(groupTable)..where((g) => g.id.equals(id));
    final result = await query.getSingle();

    List<Player> members = [];

    members = await db.playerGroupDao.getPlayersOfGroupById(id);

    return Group(id: result.id, name: result.name, members: members);
  }

  /// Adds a new group with the given [id] and [name] to the database.
  /// Returns `true` if more than 0 rows were affected, otherwise `false`.
  Future<void> addGroup(String id, String name) async {
    await into(
      groupTable,
    ).insert(GroupTableCompanion.insert(id: id, name: name));
  }

  /// Deletes the group with the given [id] from the database.
  /// Returns `true` if more than 0 rows were affected, otherwise `false`.
  Future<bool> deleteGroup(String id) async {
    final query = (delete(groupTable)..where((g) => g.id.equals(id)));
    final rowsAffected = await query.go();
    return rowsAffected > 0;
  }

  /// Updates the name of the group with the given [id] to [newName].
  /// Returns `true` if more than 0 rows were affected, otherwise `false`.
  Future<bool> updateGroupname(String id, String newName) async {
    final rowsAffected =
        await (update(groupTable)..where((g) => g.id.equals(id))).write(
          GroupTableCompanion(name: Value(newName)),
        );
    return rowsAffected > 0;
  }

  /// Retrieves the number of groups in the database.
  Future<int> getGroupCount() async {
    final count =
        await (selectOnly(groupTable)..addColumns([groupTable.id.count()]))
            .map((row) => row.read(groupTable.id.count()))
            .getSingle();
    return count ?? 0;
  }
}
