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
  Future<bool> hasGameGroup(String gameId) async {
    final count =
        await (selectOnly(groupGameTable)
              ..where(groupGameTable.gameId.equals(gameId))
              ..addColumns([groupGameTable.groupId.count()]))
            .map((row) => row.read(groupGameTable.groupId.count()))
            .getSingle();
    return (count ?? 0) > 0;
  }

  Future<Group> getGroupByGameId(String gameId) async {
    final result = await (select(
      groupGameTable,
    )..where((g) => g.gameId.equals(gameId))).getSingle();

    final group = await db.groupDao.getGroupById(result.groupId);
    return group;
  }
}
