import 'package:game_tracker/data/database.dart';
import 'package:drift/drift.dart';

extension UserDao on AppDatabase {
  Future<List<UserTableData>> getAllUsers() async {
    return await select(userTable).get();
  }

  Future<UserTableData> getUserById(String id) async {
    return await (select(userTable)..where((u) => u.id.equals(id))).getSingle();
  }

  Future<void> addUser(String id, String name) async {
    await into(userTable).insert(UserTableCompanion.insert(id: id, name: name));
  }

  Future<void> deleteUserById(String id) async {
    await (delete(userTable)..where((u) => u.id.equals(id))).go();
  }

  Future<void> updateUsername(String id, String newName) async {
    await (update(userTable)..where((u) => u.id.equals(id))).write(
      UserTableCompanion(name: Value(newName)),
    );
  }
}
