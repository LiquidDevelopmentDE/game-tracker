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
  late Player player1;
  late Player player2;
  late Player player3;
  late Player player4;
  late Player player5;
  late Group testgroup;
  late Game gameWithGroup;
  late Game gameWithPlayers;
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
      player1 = Player(name: 'Alice');
      player2 = Player(name: 'Bob');
      player3 = Player(name: 'Charlie');
      player4 = Player(name: 'Diana');
      player5 = Player(name: 'Eve');
      testgroup = Group(
        name: 'Test Group',
        members: [player1, player2, player3],
      );
      gameWithPlayers = Game(
        name: 'Game with Players',
        players: [player4, player5],
      );
      gameWithGroup = Game(name: 'Game with Group', group: testgroup);
    });
  });
  tearDown(() async {
    await database.close();
  });
  group('Group-Game Tests', () {
    test('Game has group works correctly', () async {
      database.gameDao.addGame(game: gameWithPlayers);
      database.groupDao.addGroup(group: testgroup);

      var gameHasGroup = await database.groupGameDao.gameHasGroup(
        gameId: gameWithPlayers.id,
      );

      expect(gameHasGroup, false);

      database.groupGameDao.addGroupToGame(gameWithPlayers.id, testgroup.id);

      gameHasGroup = await database.groupGameDao.gameHasGroup(
        gameId: gameWithPlayers.id,
      );

      expect(gameHasGroup, true);
    });

    test('Adding a group to a game works correctly', () async {
      database.gameDao.addGame(game: gameWithPlayers);
      database.groupDao.addGroup(group: testgroup);
      database.groupGameDao.addGroupToGame(gameWithPlayers.id, testgroup.id);

      var groupAdded = await database.groupGameDao.isGroupInGame(
        gameId: gameWithPlayers.id,
        groupId: testgroup.id,
      );
      expect(groupAdded, true);

      groupAdded = await database.groupGameDao.isGroupInGame(
        gameId: gameWithPlayers.id,
        groupId: '',
      );
      expect(groupAdded, false);
    });

    test('Removing group from game works correctly', () async {
      await database.gameDao.addGame(game: gameWithGroup);

      final groupToRemove = gameWithGroup.group!;

      final removed = await database.groupGameDao.removeGroupFromGame(
        groupId: groupToRemove.id,
        gameId: gameWithGroup.id,
      );
      expect(removed, true);

      final result = await database.gameDao.getGameById(
        gameId: gameWithGroup.id,
      );
      expect(result.group, null);
    });

    test('Retrieving group of a game works correctly', () async {
      await database.gameDao.addGame(game: gameWithGroup);
      final group = await database.groupGameDao.getGroupOfGame(
        gameId: gameWithGroup.id,
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
