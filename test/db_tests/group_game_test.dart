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
  late Group testgroup;
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
      testgroup = Group(
        name: 'Test Group',
        members: [testPlayer1, testPlayer2, testPlayer3],
      );
      testgameWithPlayers = Game(
        name: 'Test Game with Players',
        players: [testPlayer4, testPlayer5],
      );
      testgameWithGroup = Game(name: 'Test Game with Group', group: testgroup);
    });
  });
  tearDown(() async {
    await database.close();
  });
  group('Group-Game Tests', () {
    test('Game has group works correctly', () async {
      await database.gameDao.addGame(game: testgameWithPlayers);
      await database.groupDao.addGroup(group: testgroup);

      var gameHasGroup = await database.groupGameDao.gameHasGroup(
        gameId: testgameWithPlayers.id,
      );

      expect(gameHasGroup, false);

      await database.groupGameDao.addGroupToGame(
        testgameWithPlayers.id,
        testgroup.id,
      );

      gameHasGroup = await database.groupGameDao.gameHasGroup(
        gameId: testgameWithPlayers.id,
      );

      expect(gameHasGroup, true);
    });

    test('Adding a group to a game works correctly', () async {
      await database.gameDao.addGame(game: testgameWithPlayers);
      await database.groupDao.addGroup(group: testgroup);
      await database.groupGameDao.addGroupToGame(
        testgameWithPlayers.id,
        testgroup.id,
      );

      var groupAdded = await database.groupGameDao.isGroupInGame(
        gameId: testgameWithPlayers.id,
        groupId: testgroup.id,
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

      expect(group.id, testgroup.id);
      expect(group.name, testgroup.name);
      expect(group.createdAt, testgroup.createdAt);
      expect(group.members.length, testgroup.members.length);
      for (int i = 0; i < group.members.length; i++) {
        expect(group.members[i].id, testgroup.members[i].id);
        expect(group.members[i].name, testgroup.members[i].name);
        expect(group.members[i].createdAt, testgroup.members[i].createdAt);
      }
    });
  });
}
