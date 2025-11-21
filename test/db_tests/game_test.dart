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
  late Game testGame1;
  late Game testGame2;
  late Game testGameOnlyPlayers;
  late Game testGameOnlyGroup;
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
        name: 'Test Group 2',
        members: [testPlayer1, testPlayer2, testPlayer3],
      );
      testGroup2 = Group(
        name: 'Test Group 2',
        members: [testPlayer4, testPlayer5],
      );
      testGame1 = Game(
        name: 'First Test Game',
        group: testGroup1,
        players: [testPlayer4, testPlayer5],
      );
      testGame2 = Game(
        name: 'Second Test Game',
        group: testGroup2,
        players: [testPlayer1, testPlayer2, testPlayer3],
      );
      testGameOnlyPlayers = Game(
        name: 'Test Game with Players',
        players: [testPlayer1, testPlayer2, testPlayer3],
      );
      testGameOnlyGroup = Game(name: 'Test Game with Group', group: testGroup2);
    });
  });
  tearDown(() async {
    await database.close();
  });

  group('Game Tests', () {
    test('Adding and fetching single game works correclty', () async {
      await database.gameDao.addGame(game: testGame1);

      final result = await database.gameDao.getGameById(gameId: testGame1.id);

      expect(result.id, testGame1.id);
      expect(result.name, testGame1.name);
      expect(result.winner, testGame1.winner);
      expect(result.createdAt, testGame1.createdAt);

      if (result.group != null) {
        expect(result.group!.members.length, testGroup1.members.length);

        for (int i = 0; i < testGroup1.members.length; i++) {
          expect(result.group!.members[i].id, testGroup1.members[i].id);
          expect(result.group!.members[i].name, testGroup1.members[i].name);
        }
      } else {
        fail('Group is null');
      }
      if (result.players != null) {
        expect(result.players!.length, testGame1.players!.length);

        for (int i = 0; i < testGame1.players!.length; i++) {
          expect(result.players![i].id, testGame1.players![i].id);
          expect(result.players![i].name, testGame1.players![i].name);
          expect(result.players![i].createdAt, testGame1.players![i].createdAt);
        }
      } else {
        fail('Players is null');
      }
    });

    test('Adding and fetching multiple games works correctly', () async {
      // TODO: Use upcoming addGames() method
      await database.gameDao.addGame(game: testGame1);
      await database.gameDao.addGame(game: testGame2);
      await database.gameDao.addGame(game: testGameOnlyGroup);
      await database.gameDao.addGame(game: testGameOnlyPlayers);

      final allGames = await database.gameDao.getAllGames();
      expect(allGames.length, 4);

      final testGames = {
        testGame1.id: testGame1,
        testGame2.id: testGame2,
        testGameOnlyGroup.id: testGameOnlyGroup,
        testGameOnlyPlayers.id: testGameOnlyPlayers,
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
      await database.gameDao.addGame(game: testGame1);
      await database.gameDao.addGame(game: testGame1);

      final gameCount = await database.gameDao.getGameCount();
      expect(gameCount, 1);
    });

    test('Game existence check works correctly', () async {
      var gameExists = await database.gameDao.gameExists(gameId: testGame1.id);
      expect(gameExists, false);

      await database.gameDao.addGame(game: testGame1);

      gameExists = await database.gameDao.gameExists(gameId: testGame1.id);
      expect(gameExists, true);
    });

    test('Deleting a game works correclty', () async {
      await database.gameDao.addGame(game: testGame1);

      final gameDeleted = await database.gameDao.deleteGame(
        gameId: testGame1.id,
      );
      expect(gameDeleted, true);

      final gameExists = await database.gameDao.gameExists(
        gameId: testGame1.id,
      );
      expect(gameExists, false);
    });

    test('Getting the game count works correctly', () async {
      var gameCount = await database.gameDao.getGameCount();
      expect(gameCount, 0);

      await database.gameDao.addGame(game: testGame1);

      gameCount = await database.gameDao.getGameCount();
      expect(gameCount, 1);

      await database.gameDao.addGame(game: testGame2);

      gameCount = await database.gameDao.getGameCount();
      expect(gameCount, 2);

      await database.gameDao.deleteGame(gameId: testGame1.id);

      gameCount = await database.gameDao.getGameCount();
      expect(gameCount, 1);

      await database.gameDao.deleteGame(gameId: testGame2.id);

      gameCount = await database.gameDao.getGameCount();
      expect(gameCount, 0);
    });
  });
}
