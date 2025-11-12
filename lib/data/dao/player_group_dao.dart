import 'package:drift/drift.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/db/tables/player_group_table.dart';
import 'package:game_tracker/data/dto/player.dart';

part 'player_group_dao.g.dart';

@DriftAccessor(tables: [PlayerGroupTable])
class PlayerGroupDao extends DatabaseAccessor<AppDatabase>
    with _$PlayerGroupDaoMixin {
  PlayerGroupDao(super.db);

  /// Retrieves all players belonging to a specific group by [groupId].
  Future<List<Player>> getPlayersOfGroupById({required String groupId}) async {
    final query = select(playerGroupTable)
      ..where((pG) => pG.groupId.equals(groupId));
    final result = await query.get();

    List<Player> groupMembers = [];

    for (var entry in result) {
      final player = await db.playerDao.getPlayerById(playerId: entry.playerId);
      groupMembers.add(player);
    }

    return groupMembers;
  }

  /// Removes a player from a group based on [playerId] and [groupId].
  /// Returns `true` if more than 0 rows were affected, otherwise `false`.
  Future<bool> removePlayerFromGroup({
    required String playerId,
    required String groupId,
  }) async {
    final query = delete(playerGroupTable)
      ..where((p) => p.playerId.equals(playerId) & p.groupId.equals(groupId));
    final rowsAffected = await query.go();
    return rowsAffected > 0;
  }

  /// Adds a player to a group with the given [playerId] and [groupId].
  Future<void> addPlayerToGroup({
    required String playerId,
    required String groupId,
  }) async {
    await into(playerGroupTable).insert(
      PlayerGroupTableCompanion.insert(playerId: playerId, groupId: groupId),
    );
  }
}
