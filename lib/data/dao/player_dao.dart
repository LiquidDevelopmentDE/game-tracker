import 'package:drift/drift.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/db/tables/player_table.dart';
import 'package:game_tracker/data/dto/player.dart';

part 'player_dao.g.dart';

@DriftAccessor(tables: [PlayerTable])
class PlayerDao extends DatabaseAccessor<AppDatabase> with _$PlayerDaoMixin {
  PlayerDao(super.db);

  /// Retrieves all players from the database.
  Future<List<Player>> getAllPlayers() async {
    final query = select(playerTable);
    final result = await query.get();
    return result.map((row) => Player(id: row.id, name: row.name)).toList();
  }

  /// Retrieves a [Player] by their [id].
  Future<Player> getPlayerById(String id) async {
    final query = select(playerTable)..where((p) => p.id.equals(id));
    final result = await query.getSingle();
    return Player(id: result.id, name: result.name);
  }

  /// Adds a new [player] to the database.
  Future<void> addPlayer(Player player) async {
    await into(
      playerTable,
    ).insert(PlayerTableCompanion.insert(id: player.id, name: player.name));
  }

  /// Deletes the player with the given [id] from the database.
  /// Returns `true` if the player was deleted, `false` if the player did not exist.
  Future<bool> deletePlayer(String id) async {
    final query = delete(playerTable)..where((p) => p.id.equals(id));
    final rowsAffected = await query.go();
    return rowsAffected > 0;
  }

  /// Checks if a player with the given [id] exists in the database.
  /// Returns `true` if the player exists, `false` otherwise.
  Future<bool> playerExists(String id) async {
    final query = select(playerTable)..where((p) => p.id.equals(id));
    final result = await query.getSingleOrNull();
    return result != null;
  }

  /// Updates the name of the player with the given [id] to [newName].
  Future<void> updatePlayername(String id, String newName) async {
    await (update(playerTable)..where((p) => p.id.equals(id))).write(
      PlayerTableCompanion(name: Value(newName)),
    );
  }
}
