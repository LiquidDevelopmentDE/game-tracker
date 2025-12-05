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
        winner: testPlayer4,
      );
      testGame2 = Game(
        name: 'Second Test Game',
        group: testGroup2,
        players: [testPlayer1, testPlayer2, testPlayer3],
        winner: testPlayer2,
      );
      testGameOnlyPlayers = Game(
        name: 'Test Game with Players',
        players: [testPlayer1, testPlayer2, testPlayer3],
        winner: testPlayer3,
      );
      testGameOnlyGroup = Game(name: 'Test Game with Group', group: testGroup2);
    });
  });
  tearDown(() async {
    await database.close();
  });

  group('Game Tests', () {
    test('Adding and fetching single game works correctly', () async {
      await database.gameDao.addGame(game: testGame1);

      final result = await database.gameDao.getGameById(gameId: testGame1.id);

      expect(result.id, testGame1.id);
      expect(result.name, testGame1.name);
      expect(result.createdAt, testGame1.createdAt);

      if (result.winner != null && testGame1.winner != null) {
        expect(result.winner!.id, testGame1.winner!.id);
        expect(result.winner!.name, testGame1.winner!.name);
        expect(result.winner!.createdAt, testGame1.winner!.createdAt);
      } else {
        expect(result.winner, testGame1.winner);
      }

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
      await database.gameDao.addGamesAsList(
        games: [testGame1, testGame2, testGameOnlyGroup, testGameOnlyPlayers],
      );

      final allGames = await database.gameDao.getAllGames();
      expect(allGames.length, 4);

      final testGames = {
        testGame1.id: testGame1,
        testGame2.id: testGame2,
        testGameOnlyGroup.id: testGameOnlyGroup,
        testGameOnlyPlayers.id: testGameOnlyPlayers,
      };

      for (final game in allGames) {
        final testGame = testGames[game.id]!;

        // Game-Checks
        expect(game.id, testGame.id);
        expect(game.name, testGame.name);
        expect(game.createdAt, testGame.createdAt);
        if (game.winner != null && testGame.winner != null) {
          expect(game.winner!.id, testGame.winner!.id);
          expect(game.winner!.name, testGame.winner!.name);
          expect(game.winner!.createdAt, testGame.winner!.createdAt);
        } else {
          expect(game.winner, testGame.winner);
        }

        // Group-Checks
        if (testGame.group != null) {
          expect(game.group!.id, testGame.group!.id);
          expect(game.group!.name, testGame.group!.name);
          expect(game.group!.createdAt, testGame.group!.createdAt);

          // Group Members-Checks
          expect(game.group!.members.length, testGame.group!.members.length);
          for (int i = 0; i < testGame.group!.members.length; i++) {
            expect(game.group!.members[i].id, testGame.group!.members[i].id);
            expect(
              game.group!.members[i].name,
              testGame.group!.members[i].name,
            );
            expect(
              game.group!.members[i].createdAt,
              testGame.group!.members[i].createdAt,
            );
          }
        } else {
          expect(game.group, null);
        }

        // Players-Checks
        if (testGame.players != null) {
          expect(game.players!.length, testGame.players!.length);
          for (int i = 0; i < testGame.players!.length; i++) {
            expect(game.players![i].id, testGame.players![i].id);
            expect(game.players![i].name, testGame.players![i].name);
            expect(game.players![i].createdAt, testGame.players![i].createdAt);
          }
        } else {
          expect(game.players, null);
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

    test('Deleting a game works correctly', () async {
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

    test('Checking if game has winner works correclty', () async {
      await database.gameDao.addGame(game: testGame1);
      await database.gameDao.addGame(game: testGameOnlyGroup);

      var hasWinner = await database.gameDao.hasWinner(gameId: testGame1.id);
      expect(hasWinner, true);

      hasWinner = await database.gameDao.hasWinner(
        gameId: testGameOnlyGroup.id,
      );
      expect(hasWinner, false);
    });

    test('Fetching the winner of a game works correctly', () async {
      await database.gameDao.addGame(game: testGame1);

      final winner = await database.gameDao.getWinner(gameId: testGame1.id);
      if (winner == null) {
        fail('Winner is null');
      } else {
        expect(winner.id, testGame1.winner!.id);
        expect(winner.name, testGame1.winner!.name);
        expect(winner.createdAt, testGame1.winner!.createdAt);
      }
    });

    test('Updating the winner of a game works correctly', () async {
      await database.gameDao.addGame(game: testGame1);

      final winner = await database.gameDao.getWinner(gameId: testGame1.id);
      if (winner == null) {
        fail('Winner is null');
      } else {
        expect(winner.id, testGame1.winner!.id);
        expect(winner.name, testGame1.winner!.name);
        expect(winner.createdAt, testGame1.winner!.createdAt);
        expect(winner.id, testPlayer4.id);
        expect(winner.id != testPlayer5.id, true);
      }

      await database.gameDao.setWinner(
        gameId: testGame1.id,
        winnerId: testPlayer5.id,
      );

      final newWinner = await database.gameDao.getWinner(gameId: testGame1.id);

      if (newWinner == null) {
        fail('New winner is null');
      } else {
        expect(newWinner.id, testPlayer5.id);
        expect(newWinner.name, testPlayer5.name);
        expect(newWinner.createdAt, testPlayer5.createdAt);
      }
    });

    test('Removing a winner works correctly', () async {
      await database.gameDao.addGame(game: testGame2);

      var hasWinner = await database.gameDao.hasWinner(gameId: testGame2.id);
      expect(hasWinner, true);

      await database.gameDao.removeWinner(gameId: testGame2.id);

      hasWinner = await database.gameDao.hasWinner(gameId: testGame2.id);
      expect(hasWinner, false);

      final removedWinner = await database.gameDao.getWinner(
        gameId: testGame2.id,
      );

      expect(removedWinner, null);
    });

    test('Renaming a game works correctly', () async {
      await database.gameDao.addGame(game: testGame1);

      var fetchedGame = await database.gameDao.getGameById(
        gameId: testGame1.id,
      );
      expect(fetchedGame.name, testGame1.name);

      const newName = 'Updated Game Name';
      await database.gameDao.updateGameName(
        gameId: testGame1.id,
        newName: newName,
      );

      fetchedGame = await database.gameDao.getGameById(gameId: testGame1.id);
      expect(fetchedGame.name, newName);
    });
  });
}
