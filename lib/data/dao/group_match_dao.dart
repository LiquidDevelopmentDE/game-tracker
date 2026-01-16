import 'package:drift/drift.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/db/tables/group_match_table.dart';
import 'package:game_tracker/data/db/tables/group_table.dart';
import 'package:game_tracker/data/dto/group.dart';

part 'group_match_dao.g.dart';

@DriftAccessor(tables: [GroupMatchTable, GroupTable])
class GroupMatchDao extends DatabaseAccessor<AppDatabase>
    with _$GroupMatchDaoMixin {
  GroupMatchDao(super.db);

  /// Adds a group to a match by inserting a record into the [GroupMatchTable].
  Future<void> addGroupToMatch({
    required String matchId,
    required String groupId,
  }) async {
    await into(groupMatchTable).insert(
      GroupMatchTableCompanion.insert(
        matchId: matchId,
        groupId: groupId,
      ),
      mode: InsertMode.insertOrIgnore,
    );
  }

  /// Retrieves the [Group] associated with the given [matchId].
  /// Returns null if no group is found.
  Future<Group?> getGroupOfMatch({required String matchId}) async {
    final query = select(groupMatchTable)
      ..where((gm) => gm.matchId.equals(matchId));
    final result = await query.getSingleOrNull();

    if (result == null) return null;

    return db.groupDao.getGroupById(groupId: result.groupId);
  }

  /// Checks if a match has a group associated with it.
  /// Returns `true` if the match has a group, otherwise `false`.
  Future<bool> matchHasGroup({required String matchId}) async {
    final count = await (selectOnly(groupMatchTable)
          ..where(groupMatchTable.matchId.equals(matchId))
          ..addColumns([groupMatchTable.groupId.count()]))
        .map((row) => row.read(groupMatchTable.groupId.count()))
        .getSingle();
    return (count ?? 0) > 0;
  }

  /// Checks if a specific group is associated with a specific match.
  /// Returns `true` if the group is in the match, otherwise `false`.
  Future<bool> isGroupInMatch({
    required String matchId,
    required String groupId,
  }) async {
    final query = select(groupMatchTable)
      ..where(
        (gm) => gm.matchId.equals(matchId) & gm.groupId.equals(groupId),
      );
    final result = await query.getSingleOrNull();
    return result != null;
  }

  /// Removes the association of a group with a match by deleting the record
  /// from the [GroupMatchTable].
  /// Returns `true` if more than 0 rows were affected, otherwise `false`.
  Future<bool> removeGroupFromMatch({
    required String matchId,
    required String groupId,
  }) async {
    final query = delete(groupMatchTable)
      ..where((gm) => gm.matchId.equals(matchId) & gm.groupId.equals(groupId));
    final rowsAffected = await query.go();
    return rowsAffected > 0;
  }

  /// Updates the group associated with a match.
  /// Removes the existing group association and adds the new one.
  Future<void> updateGroupOfMatch({
    required String matchId,
    required String newGroupId,
  }) async {
    await db.transaction(() async {
      // Remove existing group association
      await (delete(groupMatchTable)
            ..where((gm) => gm.matchId.equals(matchId)))
          .go();

      // Add new group association
      await into(groupMatchTable).insert(
        GroupMatchTableCompanion.insert(
          matchId: matchId,
          groupId: newGroupId,
        ),
      );
    });
  }

  /// Retrieves all matches associated with a specific group.
  Future<List<String>> getMatchIdsForGroup({required String groupId}) async {
    final query = select(groupMatchTable)
      ..where((gm) => gm.groupId.equals(groupId));
    final result = await query.get();
    return result.map((row) => row.matchId).toList();
  }
}

