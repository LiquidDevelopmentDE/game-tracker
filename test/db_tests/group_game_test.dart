import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/game.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/player.dart';

void main() {
  late AppDatabase database;
  late Player testPlayer1;
  late Player testPlayer2;
  late Player testPlayer3;
  late Player testPlayer4;
  late Player testPlayer5;
  late Group testGroup1;
  late Group testGroup2;
  late Game testgameWithGroup;
  late Game testgameWithPlayers;
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
      testPlayer5 = Player(name: 'Eve');
      testGroup1 = Group(
        name: 'Test Group',
        members: [testPlayer1, testPlayer2, testPlayer3],
      );
      testGroup2 = Group(
        name: 'Test Group',
        members: [testPlayer3, testPlayer2],
      );
      testgameWithPlayers = Game(
        name: 'Test Game with Players',
        players: [testPlayer4, testPlayer5],
      );
      testgameWithGroup = Game(name: 'Test Game with Group', group: testGroup1);
    });
  });
  tearDown(() async {
    await database.close();
  });
  group('Group-Game Tests', () {
    test('Game has group works correctly', () async {
      await database.gameDao.addGame(game: testgameWithPlayers);
      await database.groupDao.addGroup(group: testGroup1);

      var gameHasGroup = await database.groupGameDao.gameHasGroup(
        gameId: testgameWithPlayers.id,
      );

      expect(gameHasGroup, false);

      await database.groupGameDao.addGroupToGame(
        gameId: testgameWithPlayers.id,
        groupId: testGroup1.id,
      );

      gameHasGroup = await database.groupGameDao.gameHasGroup(
        gameId: testgameWithPlayers.id,
      );

      expect(gameHasGroup, true);
    });

    test('Adding a group to a game works correctly', () async {
      await database.gameDao.addGame(game: testgameWithPlayers);
      await database.groupDao.addGroup(group: testGroup1);
      await database.groupGameDao.addGroupToGame(
        gameId: testgameWithPlayers.id,
        groupId: testGroup1.id,
      );

      var groupAdded = await database.groupGameDao.isGroupInGame(
        gameId: testgameWithPlayers.id,
        groupId: testGroup1.id,
      );
      expect(groupAdded, true);

      groupAdded = await database.groupGameDao.isGroupInGame(
        gameId: testgameWithPlayers.id,
        groupId: '',
      );
      expect(groupAdded, false);
    });

    test('Removing group from game works correctly', () async {
      await database.gameDao.addGame(game: testgameWithGroup);

      final groupToRemove = testgameWithGroup.group!;

      final removed = await database.groupGameDao.removeGroupFromGame(
        groupId: groupToRemove.id,
        gameId: testgameWithGroup.id,
      );
      expect(removed, true);

      final result = await database.gameDao.getGameById(
        gameId: testgameWithGroup.id,
      );
      expect(result.group, null);
    });

    test('Retrieving group of a game works correctly', () async {
      await database.gameDao.addGame(game: testgameWithGroup);
      final group = await database.groupGameDao.getGroupOfGame(
        gameId: testgameWithGroup.id,
      );

      if (group == null) {
        fail('Group should not be null');
      }

      expect(group.id, testGroup1.id);
      expect(group.name, testGroup1.name);
      expect(group.createdAt, testGroup1.createdAt);
      expect(group.members.length, testGroup1.members.length);
      for (int i = 0; i < group.members.length; i++) {
        expect(group.members[i].id, testGroup1.members[i].id);
        expect(group.members[i].name, testGroup1.members[i].name);
        expect(group.members[i].createdAt, testGroup1.members[i].createdAt);
      }
    });

    test('Updating the group of a game works correctly', () async {
      await database.gameDao.addGame(game: testgameWithGroup);

      var group = await database.groupGameDao.getGroupOfGame(
        gameId: testgameWithGroup.id,
      );

      if (group == null) {
        fail('Initial group should not be null');
      } else {
        expect(group.id, testGroup1.id);
        expect(group.name, testGroup1.name);
        expect(group.createdAt, testGroup1.createdAt);
        expect(group.members.length, testGroup1.members.length);
      }

      await database.groupDao.addGroup(group: testGroup2);
      await database.groupGameDao.updateGroupOfGame(
        gameId: testgameWithGroup.id,
        newGroupId: testGroup2.id,
      );

      group = await database.groupGameDao.getGroupOfGame(
        gameId: testgameWithGroup.id,
      );

      if (group == null) {
        fail('Updated group should not be null');
      } else {
        expect(group.id, testGroup2.id);
        expect(group.name, testGroup2.name);
        expect(group.createdAt, testGroup2.createdAt);
        expect(group.members.length, testGroup2.members.length);
        for (int i = 0; i < group.members.length; i++) {
          expect(group.members[i].id, testGroup2.members[i].id);
          expect(group.members[i].name, testGroup2.members[i].name);
          expect(group.members[i].createdAt, testGroup2.members[i].createdAt);
        }
      }
    });
  });
}
