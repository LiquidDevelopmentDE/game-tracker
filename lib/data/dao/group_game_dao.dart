import 'package:drift/drift.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/db/tables/group_game_table.dart';
import 'package:game_tracker/data/dto/group.dart';

part 'group_game_dao.g.dart';

@DriftAccessor(tables: [GroupGameTable])
class GroupGameDao extends DatabaseAccessor<AppDatabase>
    with _$GroupGameDaoMixin {
  GroupGameDao(super.db);

  /// Associates a group with a game by inserting a record into the
  /// [GroupGameTable].
  Future<void> addGroupToGame({
    required String gameId,
    required String groupId,
  }) async {
    await into(groupGameTable).insert(
      GroupGameTableCompanion.insert(groupId: groupId, gameId: gameId),
      mode: InsertMode.insertOrReplace,
    );
  }

  /// Retrieves the [Group] associated with the given [gameId].
  /// Returns `null` if no group is found.
  Future<Group?> getGroupOfGame({required String gameId}) async {
    final result = await (select(
      groupGameTable,
    )..where((g) => g.gameId.equals(gameId))).getSingleOrNull();

    if (result == null) {
      return null;
    }

    final group = await db.groupDao.getGroupById(groupId: result.groupId);
    return group;
  }

  /// Checks if there is a group associated with the given [gameId].
  /// Returns `true` if there is a group, otherwise `false`.
  Future<bool> gameHasGroup({required String gameId}) async {
    final count =
        await (selectOnly(groupGameTable)
              ..where(groupGameTable.gameId.equals(gameId))
              ..addColumns([groupGameTable.groupId.count()]))
            .map((row) => row.read(groupGameTable.groupId.count()))
            .getSingle();
    return (count ?? 0) > 0;
  }

  /// Checks if a specific group is associated with a specific game.
  /// Returns `true` if the group is in the game, otherwise `false`.
  Future<bool> isGroupInGame({
    required String gameId,
    required String groupId,
  }) async {
    final count =
        await (selectOnly(groupGameTable)
              ..where(
                groupGameTable.gameId.equals(gameId) &
                    groupGameTable.groupId.equals(groupId),
              )
              ..addColumns([groupGameTable.groupId.count()]))
            .map((row) => row.read(groupGameTable.groupId.count()))
            .getSingle();
    return (count ?? 0) > 0;
  }

  /// Removes the association of a group from a game based on [groupId] and
  /// [gameId].
  /// Returns `true` if more than 0 rows were affected, otherwise `false`.
  Future<bool> removeGroupFromGame({
    required String gameId,
    required String groupId,
  }) async {
    final query = delete(groupGameTable)
      ..where((g) => g.gameId.equals(gameId) & g.groupId.equals(groupId));
    final rowsAffected = await query.go();
    return rowsAffected > 0;
  }

  /// Updates the group associated with a game to [newGroupId] based on
  /// [gameId].
  /// Returns `true` if more than 0 rows were affected, otherwise `false`.
  Future<bool> updateGroupOfGame({
    required String gameId,
    required String newGroupId,
  }) async {
    final updatedRows =
        await (update(groupGameTable)..where((g) => g.gameId.equals(gameId)))
            .write(GroupGameTableCompanion(groupId: Value(newGroupId)));
    return updatedRows > 0;
  }
}
