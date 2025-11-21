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
  late Game testgame1;
  late Game testgame2;
  late Game testgameWithPlayer;
  late Game testgameWithGroup;
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
        name: 'Test Group 2',
        members: [player1, player2, player3],
      );
      testgroup2 = Group(name: 'Test Group 2', members: [player4, player5]);
      testgame1 = Game(
        name: 'Test Game',
        group: testgroup,
        players: [player4, player5],
      );
      testgame2 = Game(
        name: 'Second Test Game',
        group: testgroup2,
        players: [player1, player2, player3],
      );
      testgameWithPlayer = Game(
        name: 'Second Test Game',
        players: [player1, player2, player3],
      );
      testgameWithGroup = Game(name: 'Second Test Game', group: testgroup2);
    });
  });
  tearDown(() async {
    await database.close();
  });

  group('Game Tests', () {
    test('Adding and fetching single game works correclty', () async {
      await database.gameDao.addGame(game: testgame1);

      final result = await database.gameDao.getGameById(gameId: testgame1.id);

      expect(result.id, testgame1.id);
      expect(result.name, testgame1.name);
      expect(result.winner, testgame1.winner);
      expect(result.createdAt, testgame1.createdAt);

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
        expect(result.players!.length, testgame1.players!.length);

        for (int i = 0; i < testgame1.players!.length; i++) {
          expect(result.players![i].id, testgame1.players![i].id);
          expect(result.players![i].name, testgame1.players![i].name);
          expect(result.players![i].createdAt, testgame1.players![i].createdAt);
        }
      } else {
        fail('Players is null');
      }
    });

    test('Adding and fetching multiple games works correctly', () async {
      // TODO: Use upcoming addGames() method
      await database.gameDao.addGame(game: testgame1);
      await database.gameDao.addGame(game: testgame2);
      await database.gameDao.addGame(game: testgameWithGroup);
      await database.gameDao.addGame(game: testgameWithPlayer);

      final allGames = await database.gameDao.getAllGames();
      expect(allGames.length, 4);

      final testGames = {
        testgame1.id: testgame1,
        testgame2.id: testgame2,
        testgameWithGroup.id: testgameWithGroup,
        testgameWithPlayer.id: testgameWithPlayer,
      };

      for (final game in allGames) {
        final expectedGame = testGames[game.id]!;

        // Game-Checks
        expect(game.id, expectedGame.id);
        expect(game.name, expectedGame.name);
        expect(game.createdAt, expectedGame.createdAt);
        expect(game.winner, expectedGame.winner);

        // Group-Checks
        if (expectedGame.group != null) {
          expect(game.group!.id, expectedGame.group!.id);
          expect(game.group!.name, expectedGame.group!.name);
          expect(game.group!.createdAt, expectedGame.group!.createdAt);

          // Group Members-Checks
          expect(
            game.group!.members.length,
            expectedGame.group!.members.length,
          );
          for (int i = 0; i < expectedGame.group!.members.length; i++) {
            expect(
              game.group!.members[i].id,
              expectedGame.group!.members[i].id,
            );
            expect(
              game.group!.members[i].name,
              expectedGame.group!.members[i].name,
            );
            expect(
              game.group!.members[i].createdAt,
              expectedGame.group!.members[i].createdAt,
            );
          }
        }

        // Players-Checks
        if (expectedGame.players != null) {
          expect(game.players!.length, expectedGame.players!.length);
          for (int i = 0; i < expectedGame.players!.length; i++) {
            expect(game.players![i].id, expectedGame.players![i].id);
            expect(game.players![i].name, expectedGame.players![i].name);
            expect(
              game.players![i].createdAt,
              expectedGame.players![i].createdAt,
            );
          }
        }
      }
    });

    test('Adding the same game twice does not create duplicates', () async {
      await database.gameDao.addGame(game: testgame1);
      await database.gameDao.addGame(game: testgame1);

      final gameCount = await database.gameDao.getGameCount();
      expect(gameCount, 1);
    });

    test('Game existence check works correctly', () async {
      var gameExists = await database.gameDao.gameExists(gameId: testgame1.id);
      expect(gameExists, false);

      await database.gameDao.addGame(game: testgame1);

      gameExists = await database.gameDao.gameExists(gameId: testgame1.id);
      expect(gameExists, true);
    });

    test('Deleting a game works correclty', () async {
      await database.gameDao.addGame(game: testgame1);

      final gameDeleted = await database.gameDao.deleteGame(
        gameId: testgame1.id,
      );
      expect(gameDeleted, true);

      final gameExists = await database.gameDao.gameExists(
        gameId: testgame1.id,
      );
      expect(gameExists, false);
    });

    test('Getting the game count works correctly', () async {
      var gameCount = await database.gameDao.getGameCount();
      expect(gameCount, 0);

      await database.gameDao.addGame(game: testgame1);

      gameCount = await database.gameDao.getGameCount();
      expect(gameCount, 1);

      await database.gameDao.addGame(game: testgame2);

      gameCount = await database.gameDao.getGameCount();
      expect(gameCount, 2);

      await database.gameDao.deleteGame(gameId: testgame1.id);

      gameCount = await database.gameDao.getGameCount();
      expect(gameCount, 1);

      await database.gameDao.deleteGame(gameId: testgame2.id);

      gameCount = await database.gameDao.getGameCount();
      expect(gameCount, 0);
    });
  });
}
