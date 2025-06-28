import 'package:game_tracker/data/database.dart';
import 'package:drift/drift.dart';

extension UserGroupDao on AppDatabase {
  Future<List<UserGroupTableData>> getAllUsersAndGroups() async {
    return await select(userGroupTable).get();
  }

  Future<List<UserGroupTableData>> getUsersGroups(String userId) async {
    return await (select(
      userGroupTable,
    )..where((uG) => uG.userId.equals(userId))).get();
  }

  Future<List<UserGroupTableData>> getGroupsUsers(String groupId) async {
    return await (select(
      userGroupTable,
    )..where((uG) => uG.groupId.equals(groupId))).get();
  }

  Future<void> addUserToGroup(String userId, String groupId) async {
    await into(
      userGroupTable,
    ).insert(UserGroupTableCompanion.insert(userId: userId, groupId: groupId));
  }

  Future<void> removeUserFromGroup(String userId, String groupId) async {
    await (delete(
          userGroupTable,
        )..where((uG) => uG.userId.equals(userId) & uG.groupId.equals(groupId)))
        .go();
  }
}
