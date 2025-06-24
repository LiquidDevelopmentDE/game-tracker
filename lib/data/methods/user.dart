import 'package:game_tracker/data/database.dart';
import 'package:drift/drift.dart';

extension UserMethods on AppDatabase {
  Future<List<UserData>> getAllUsers() async {
    return await select(user).get();
  }

  Future<List<UserData>> getUserById(String id) async {
    return await (select(user)..where((u) => u.id.equals(id))).get();
  }

  Future<void> addUser(String id, String name) async {
    await into(user).insert(
      UserCompanion.insert(id: id, name: name),
    );
  }

  Future<void> deleteUser(String id) async {
    await (delete(user)..where((u) => u.id.equals(id))).go();
  }

  Future<void> updateUsername(String id, String newName) async {
    await (update(user)..where((u) => u.id.equals(id))).write(
      UserCompanion(name: Value(newName)),
    );
  }
}