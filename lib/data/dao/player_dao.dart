import 'package:drift/drift.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/db/tables/player_table.dart';
import 'package:game_tracker/data/dto/player.dart';

part 'player_dao.g.dart';

@DriftAccessor(tables: [PlayerTable])
class PlayerDao extends DatabaseAccessor<AppDatabase> with _$PlayerDaoMixin {
  PlayerDao(super.db);

  Future<List<Player>> getAllUsers() async {
    return await select(UserTable).get();
  }

  Future<UserData> getUserById(String id) async {
    return await (select(user)..where((u) => u.id.equals(id))).getSingle();
  }

  Future<void> addUser(String id, String name) async {
    await into(user).insert(UserCompanion.insert(id: id, name: name));
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
