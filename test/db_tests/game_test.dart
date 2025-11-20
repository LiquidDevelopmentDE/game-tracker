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
  late Group testgroup2;
  late Game testgame;
  late Game testgame2;
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
      testgroup2 = Group(
        name: 'Test Group',
        members: [player1, player2, player3],
      );
      testgame = Game(
        name: 'Test Game',
        group: testgroup,
        players: [player4, player5],
      );
      testgame2 = Game(
        name: 'Second Test Game',
        group: testgroup2,
        players: [player1, player2, player3],
      );
    });
  });
  tearDown(() async {
    await database.close();
  });

  group('Game Tests', () {
    test('Adding and fetching single game works correclty', () async {
      await database.gameDao.addGame(game: testgame);

      final result = await database.gameDao.getGameById(gameId: testgame.id);

      expect(result.id, testgame.id);
      expect(result.name, testgame.name);
      expect(result.winner, testgame.winner);
      expect(result.createdAt, testgame.createdAt);

      if (result.group != null) {
        expect(result.group!.members.length, testgroup.members.length);

        for (int i = 0; i < testgroup.members.length; i++) {
          expect(result.group!.members[i].id, testgroup.members[i].id);
          expect(result.group!.members[i].name, testgroup.members[i].name);
        }
      } else {
        fail('Group is null');
      }
      if (result.players != null) {
        expect(result.players!.length, testgame.players!.length);

        for (int i = 0; i < testgame.players!.length; i++) {
          expect(result.players![i].id, testgame.players![i].id);
          expect(result.players![i].name, testgame.players![i].name);
          expect(result.players![i].createdAt, testgame.players![i].createdAt);
        }
      } else {
        fail('Players is null');
      }
    });

    // TODO: Use upcoming addGames() method
    test('Adding and fetching multiple games works correclty', () async {
      await database.gameDao.addGame(game: testgame);
      await database.gameDao.addGame(game: testgame2);

      final allGames = await database.gameDao.getAllGames();
      expect(allGames.length, 2);

      final fetchedGame1 = allGames.firstWhere((g) => g.id == testgame.id);
      // game checks
      expect(fetchedGame1.id, testgame.id);
      expect(fetchedGame1.name, testgame.name);
      expect(fetchedGame1.createdAt, testgame.createdAt);
      expect(fetchedGame1.winner, testgame.winner);

      // group checks
      expect(fetchedGame1.group!.id, testgame.group!.id);
      expect(fetchedGame1.group!.name, testgame.group!.name);
      expect(fetchedGame1.group!.createdAt, testgame.group!.createdAt);
      // group members checks
      expect(
        fetchedGame1.group!.members.length,
        testgame.group!.members.length,
      );
      for (int i = 0; i < testgame.group!.members.length; i++) {
        expect(
          fetchedGame1.group!.members[i].id,
          testgame.group!.members[i].id,
        );
        expect(
          fetchedGame1.group!.members[i].name,
          testgame.group!.members[i].name,
        );
        expect(
          fetchedGame1.group!.members[i].createdAt,
          testgame.group!.members[i].createdAt,
        );
      }

      // players checks
      for (int i = 0; i < fetchedGame1.players!.length; i++) {
        expect(fetchedGame1.players![i].id, testgame.players![i].id);
        expect(fetchedGame1.players![i].name, testgame.players![i].name);
        expect(
          fetchedGame1.players![i].createdAt,
          testgame.players![i].createdAt,
        );
      }

      final fetchedGame2 = allGames.firstWhere((g) => g.id == testgame2.id);
      // game checks
      expect(fetchedGame2.id, testgame2.id);
      expect(fetchedGame2.name, testgame2.name);
      expect(fetchedGame2.createdAt, testgame2.createdAt);
      expect(fetchedGame2.winner, testgame2.winner);

      // group checks
      expect(fetchedGame2.group!.id, testgame2.group!.id);
      expect(fetchedGame2.group!.name, testgame2.group!.name);
      expect(fetchedGame2.group!.createdAt, testgame2.group!.createdAt);
      // group members checks
      expect(
        fetchedGame2.group!.members.length,
        testgame2.group!.members.length,
      );
      for (int i = 0; i < testgame2.group!.members.length; i++) {
        expect(
          fetchedGame2.group!.members[i].id,
          testgame2.group!.members[i].id,
        );
        expect(
          fetchedGame2.group!.members[i].name,
          testgame2.group!.members[i].name,
        );
        expect(
          fetchedGame2.group!.members[i].createdAt,
          testgame2.group!.members[i].createdAt,
        );
      }

      // players checks
      for (int i = 0; i < fetchedGame2.players!.length; i++) {
        expect(fetchedGame2.players![i].id, testgame2.players![i].id);
        expect(fetchedGame2.players![i].name, testgame2.players![i].name);
        expect(
          fetchedGame2.players![i].createdAt,
          testgame2.players![i].createdAt,
        );
      }
    });

    test('Adding the same game twice does not create duplicates', () async {
      await database.gameDao.addGame(game: testgame);
      await database.gameDao.addGame(game: testgame);

      final gameCount = await database.gameDao.getGameCount();
      expect(gameCount, 1);
    });

    test('Game existence check works correctly', () async {
      var gameExists = await database.gameDao.gameExists(gameId: testgame.id);
      expect(gameExists, false);

      await database.gameDao.addGame(game: testgame);

      gameExists = await database.gameDao.gameExists(gameId: testgame.id);
      expect(gameExists, true);
    });

    test('Deleting a game works correclty', () async {
      await database.gameDao.addGame(game: testgame);

      final gameDeleted = await database.gameDao.deleteGame(
        gameId: testgame.id,
      );
      expect(gameDeleted, true);

      final gameExists = await database.gameDao.gameExists(gameId: testgame.id);
      expect(gameExists, false);
    });

    test('Getting the game count works correctly', () async {
      var gameCount = await database.gameDao.getGameCount();
      expect(gameCount, 0);

      await database.gameDao.addGame(game: testgame);

      gameCount = await database.gameDao.getGameCount();
      expect(gameCount, 1);

      await database.gameDao.addGame(game: testgame2);

      gameCount = await database.gameDao.getGameCount();
      expect(gameCount, 2);

      await database.gameDao.deleteGame(gameId: testgame.id);

      gameCount = await database.gameDao.getGameCount();
      expect(gameCount, 1);

      await database.gameDao.deleteGame(gameId: testgame2.id);

      gameCount = await database.gameDao.getGameCount();
      expect(gameCount, 0);
    });

    // TODO: Implement
    test('Adding a player to a game works correclty', () async {});

    // TODO: Implement
    test('Adding a group to a game works correclty', () async {});
  });
}
