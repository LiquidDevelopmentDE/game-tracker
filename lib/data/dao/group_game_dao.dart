import 'package:drift/drift.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/db/tables/group_game_table.dart';
import 'package:game_tracker/data/dto/group.dart';

part 'group_game_dao.g.dart';

@DriftAccessor(tables: [GroupGameTable])
class GroupGameDao extends DatabaseAccessor<AppDatabase>
    with _$GroupGameDaoMixin {
  GroupGameDao(super.db);

  /// Checks if there is a group associated with the given [gameId].
  /// Returns `true` if there is a group, otherwise `false`.
  Future<bool> hasGameGroup({required String gameId}) async {
    final count =
        await (selectOnly(groupGameTable)
              ..where(groupGameTable.gameId.equals(gameId))
              ..addColumns([groupGameTable.groupId.count()]))
            .map((row) => row.read(groupGameTable.groupId.count()))
            .getSingle();
    return (count ?? 0) > 0;
  }

  /// Retrieves the [Group] associated with the given [gameId].
  /// Returns `null` if no group is found.
  Future<Group?> getGroupByGameId({required String gameId}) async {
    final result = await (select(
      groupGameTable,
    )..where((g) => g.gameId.equals(gameId))).getSingleOrNull();

    if (result == null) {
      return null;
    }

    final group = await db.groupDao.getGroupById(groupId: result.groupId);
    return group;
  }

  /// Associates a group with a game by inserting a record into the
  /// [GroupGameTable].
  Future<void> addGroupToGame(String gameId, String groupId) async {
    await into(
      groupGameTable,
    ).insert(GroupGameTableCompanion.insert(groupId: groupId, gameId: gameId));
  }
}
