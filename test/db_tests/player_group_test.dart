import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/player.dart';

void main() {
  late AppDatabase database;
  late Player testPlayer1;
  late Player testPlayer2;
  late Player testPlayer3;
  late Player testPlayer4;
  late Group testGroup;
  final fixedDate = DateTime(2025, 19, 11, 00, 11, 23);
  final fakeClock = Clock(() => fixedDate);

  setUp(() {
    database = AppDatabase(
      DatabaseConnection(
        NativeDatabase.memory(),
        // Recommended for widget tests to avoid test errors.
        closeStreamsSynchronously: true,
      ),
    );

    withClock(fakeClock, () {
      testPlayer1 = Player(name: 'Alice');
      testPlayer2 = Player(name: 'Bob');
      testPlayer3 = Player(name: 'Charlie');
      testPlayer4 = Player(name: 'Diana');
      testGroup = Group(
        name: 'Test Group',
        members: [testPlayer1, testPlayer2, testPlayer3],
      );
    });
  });
  tearDown(() async {
    await database.close();
  });

  group('Player-Group Tests', () {
    /// No need to test if group has players since the members attribute is
    /// not nullable

    test('Adding a player to a group works correctly', () async {
      await database.groupDao.addGroup(group: testGroup);
      await database.playerDao.addPlayer(player: testPlayer4);
      await database.playerGroupDao.addPlayerToGroup(
        groupId: testGroup.id,
        player: testPlayer4,
      );

      var playerAdded = await database.playerGroupDao.isPlayerInGroup(
        groupId: testGroup.id,
        playerId: testPlayer4.id,
      );

      expect(playerAdded, true);

      playerAdded = await database.playerGroupDao.isPlayerInGroup(
        groupId: testGroup.id,
        playerId: '',
      );

      expect(playerAdded, false);
    });

    test('Removing player from group works correctly', () async {
      await database.groupDao.addGroup(group: testGroup);

      final playerToRemove = testGroup.members[0];

      final removed = await database.playerGroupDao.removePlayerFromGroup(
        playerId: playerToRemove.id,
        groupId: testGroup.id,
      );
      expect(removed, true);

      final result = await database.groupDao.getGroupById(
        groupId: testGroup.id,
      );
      expect(result.members.length, testGroup.members.length - 1);

      final playerExists = result.members.any((p) => p.id == playerToRemove.id);
      expect(playerExists, false);
    });

    test('Retrieving players of a group works correctly', () async {
      await database.groupDao.addGroup(group: testGroup);
      final players = await database.playerGroupDao.getPlayersOfGroup(
        groupId: testGroup.id,
      );

      for (int i = 0; i < players.length; i++) {
        expect(players[i].id, testGroup.members[i].id);
        expect(players[i].name, testGroup.members[i].name);
        expect(players[i].createdAt, testGroup.members[i].createdAt);
      }
    });
  });
}
