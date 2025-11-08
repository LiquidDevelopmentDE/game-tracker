import 'package:drift/drift.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/db/tables/player_group_table.dart';

part 'player_group_dao.g.dart';

@DriftAccessor(tables: [PlayerGroupTable])
class PlayerGroupDao extends DatabaseAccessor<AppDatabase>
    with _$PlayerGroupDaoMixin {
  PlayerGroupDao(super.db);

  Future<List<UserGroupData>> getAllUsersAndGroups() async {
    return await select(userGroup).get();
  }

  Future<List<UserGroupData>> getUsersGroups(String userId) async {
    return await (select(
      userGroup,
    )..where((uG) => uG.userId.equals(userId))).get();
  }

  Future<List<UserGroupData>> getGroupsUsers(String groupId) async {
    return await (select(
      userGroup,
    )..where((uG) => uG.groupId.equals(groupId))).get();
  }

  Future<void> addUserToGroup(String userId, String groupId) async {
    await into(
      userGroup,
    ).insert(UserGroupCompanion.insert(userId: userId, groupId: groupId));
  }

  Future<void> removeUserFromGroup(String userId, String groupId) async {
    await (delete(
          userGroup,
        )..where((uG) => uG.userId.equals(userId) & uG.groupId.equals(groupId)))
        .go();
  }
}
