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
    return Future.wait(
      result.map((groupData) async {
        final members = await db.playerGroupDao.getPlayersOfGroupById(
          groupId: groupData.id,
        );
        return Group(id: groupData.id, name: groupData.name, members: members);
      }),
    );
  }

  /// Retrieves a [Group] by its [groupId], including its members.
  Future<Group> getGroupById({required String groupId}) async {
    final query = select(groupTable)..where((g) => g.id.equals(groupId));
    final result = await query.getSingle();

    List<Player> members = await db.playerGroupDao.getPlayersOfGroupById(
      groupId: groupId,
    );

    return Group(id: result.id, name: result.name, members: members);
  }

  /// Adds a new group with the given [id] and [name] to the database.
  /// This method also adds the group's members to the [PlayerGroupTable].
  Future<bool> addGroup({required Group group}) async {
    if (!await groupExists(groupId: group.id)) {
      await db.transaction(() async {
        await into(
          groupTable,
        ).insert(GroupTableCompanion.insert(id: group.id, name: group.name));
        await db.batch(
          (b) => b.insertAll(
            db.playerGroupTable,
            group.members
                .map(
                  (member) => PlayerGroupTableCompanion.insert(
                    playerId: member.id,
                    groupId: group.id,
                  ),
                )
                .toList(),
          ),
        );
        await Future.wait(
          group.members.map((player) => db.playerDao.addPlayer(player: player)),
        );
        return true;
      });
    }
    return false;
  }

  /// Deletes the group with the given [id] from the database.
  /// Returns `true` if more than 0 rows were affected, otherwise `false`.
  Future<bool> deleteGroup({required String groupId}) async {
    final query = (delete(groupTable)..where((g) => g.id.equals(groupId)));
    final rowsAffected = await query.go();
    return rowsAffected > 0;
  }

  /// Updates the name of the group with the given [id] to [newName].
  /// Returns `true` if more than 0 rows were affected, otherwise `false`.
  Future<bool> updateGroupname({
    required String groupId,
    required String newName,
  }) async {
    final rowsAffected =
        await (update(groupTable)..where((g) => g.id.equals(groupId))).write(
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

  /// Checks if a group with the given [groupId] exists in the database.
  /// Returns `true` if the group exists, `false` otherwise.
  Future<bool> groupExists({required String groupId}) async {
    final query = select(groupTable)..where((g) => g.id.equals(groupId));
    final result = await query.getSingleOrNull();
    return result != null;
  }
}
