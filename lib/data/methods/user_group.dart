import 'package:game_tracker/data/database.dart';
import 'package:drift/drift.dart';

extension UserGroupMethods on AppDatabase {
  Future<List<UserGroupData>> getAllUsersAndGroups() async {
    return await select(userGroup).get();
  }

  Future<List<UserGroupData>> getUsersGroups(String userId) async {
    return await (select(userGroup)..where((uG) => uG.userId.equals(userId))).get();
  }

  Future<List<UserGroupData>> getGroupsUsers(String groupId) async {
    return await (select(userGroup)..where((uG) => uG.groupId.equals(groupId))).get();
  }

  Future<void> addUserToGroup(String userId, String groupId) async {
    await into(userGroup).insert(
      UserGroupCompanion.insert(userId: userId, groupId: groupId),
    );
  }

  Future<void> removeUserFromGroup(String userId, String groupId) async {
    await (delete(userGroup)..where((uG) => uG.userId.equals(userId) & uG.groupId.equals(groupId))).go();
  }
}