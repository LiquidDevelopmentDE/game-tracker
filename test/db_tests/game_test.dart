import 'package:clock/clock.dart';
import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/game.dart';

void main() {
  late AppDatabase database;
  late Game testGame1;
  late Game testGame2;
  late Game testGame3;
  final fixedDate = DateTime(2025, 11, 19, 00, 11, 23);
  final fakeClock = Clock(() => fixedDate);

  setUp(() {
    database = AppDatabase(
      DatabaseConnection(
        NativeDatabase.memory(),
        closeStreamsSynchronously: true,
      ),
    );

    withClock(fakeClock, () {
      testGame1 = Game(
        name: 'Chess',
        ruleset: 'winner.single',
        description: 'A classic strategy game',
        color: 0xFF0000FF,
        icon: 'chess_icon',
      );
      testGame2 = Game(
        id: 'game2',
        name: 'Poker',
        ruleset: 'Texas Hold\'em rules',
        description: 'winner.multiple',
        color: 0xFFFF0000,
        icon: 'poker_icon',
      );
      testGame3 = Game(
        id: 'game3',
        name: 'Monopoly',
        description: 'A board game about real estate',
      );
    });
  });

  tearDown(() async {
    await database.close();
  });

  group('Game Tests', () {
    // ==================== getAllGames ====================
    test('getAllGames returns empty list when no games exist', () async {
      final allGames = await database.gameDao.getAllGames();
      expect(allGames, isEmpty);
    });

    test('Adding and fetching a single game works correctly', () async {
      await database.gameDao.addGame(game: testGame1);

      final allGames = await database.gameDao.getAllGames();
      expect(allGames.length, 1);
      expect(allGames.first.id, testGame1.id);
      expect(allGames.first.name, testGame1.name);
      expect(allGames.first.ruleset, testGame1.ruleset);
      expect(allGames.first.description, testGame1.description);
      expect(allGames.first.color, testGame1.color);
      expect(allGames.first.icon, testGame1.icon);
      expect(allGames.first.createdAt, testGame1.createdAt);
    });

    test('Adding and fetching multiple games works correctly', () async {
      await database.gameDao.addGame(game: testGame1);
      await database.gameDao.addGame(game: testGame2);
      await database.gameDao.addGame(game: testGame3);

      final allGames = await database.gameDao.getAllGames();
      expect(allGames.length, 3);

      final names = allGames.map((g) => g.name).toList();
      expect(names, containsAll(['Chess', 'Poker', 'Monopoly']));
    });

    // ==================== getGameById ====================
    test('getGameById returns correct game', () async {
      await database.gameDao.addGame(game: testGame1);
      await database.gameDao.addGame(game: testGame2);

      final game = await database.gameDao.getGameById(gameId: testGame2.id);
      expect(game.id, testGame2.id);
      expect(game.name, testGame2.name);
      expect(game.ruleset, testGame2.ruleset);
      expect(game.description, testGame2.description);
      expect(game.color, testGame2.color);
      expect(game.icon, testGame2.icon);
    });

    test('getGameById throws exception for non-existent game', () async {
      expect(
        () => database.gameDao.getGameById(gameId: 'non-existent-id'),
        throwsA(isA<StateError>()),
      );
    });

    // ==================== addGame ====================
    test('addGame returns true when game is added successfully', () async {
      final result = await database.gameDao.addGame(game: testGame1);
      expect(result, true);

      final allGames = await database.gameDao.getAllGames();
      expect(allGames.length, 1);
    });

    test('addGame returns false when game already exists', () async {
      final firstAdd = await database.gameDao.addGame(game: testGame1);
      expect(firstAdd, true);

      final secondAdd = await database.gameDao.addGame(game: testGame1);
      expect(secondAdd, false);

      final allGames = await database.gameDao.getAllGames();
      expect(allGames.length, 1);
    });

    test('addGame handles game with null optional fields', () async {
      final gameWithNulls = Game(name: 'Simple Game');
      final result = await database.gameDao.addGame(game: gameWithNulls);
      expect(result, true);

      final fetchedGame = await database.gameDao.getGameById(
        gameId: gameWithNulls.id,
      );
      expect(fetchedGame.name, 'Simple Game');
      expect(fetchedGame.description, isNull);
      expect(fetchedGame.color, isNull);
      expect(fetchedGame.icon, isNull);
    });

    // ==================== addGamesAsList ====================
    test('addGamesAsList adds multiple games correctly', () async {
      final result = await database.gameDao.addGamesAsList(
        games: [testGame1, testGame2, testGame3],
      );
      expect(result, true);

      final allGames = await database.gameDao.getAllGames();
      expect(allGames.length, 3);
    });

    test('addGamesAsList returns false for empty list', () async {
      final result = await database.gameDao.addGamesAsList(games: []);
      expect(result, false);

      final allGames = await database.gameDao.getAllGames();
      expect(allGames.length, 0);
    });

    test('addGamesAsList ignores duplicate games', () async {
      await database.gameDao.addGame(game: testGame1);

      final result = await database.gameDao.addGamesAsList(
        games: [testGame1, testGame2],
      );
      expect(result, true);

      final allGames = await database.gameDao.getAllGames();
      expect(allGames.length, 2);
    });

    // ==================== deleteGame ====================
    test('deleteGame returns true when game is deleted', () async {
      await database.gameDao.addGame(game: testGame1);

      final result = await database.gameDao.deleteGame(gameId: testGame1.id);
      expect(result, true);

      final allGames = await database.gameDao.getAllGames();
      expect(allGames, isEmpty);
    });

    test('deleteGame returns false for non-existent game', () async {
      final result = await database.gameDao.deleteGame(
        gameId: 'non-existent-id',
      );
      expect(result, false);
    });

    test('deleteGame only deletes the specified game', () async {
      await database.gameDao.addGamesAsList(
        games: [testGame1, testGame2, testGame3],
      );

      await database.gameDao.deleteGame(gameId: testGame2.id);

      final allGames = await database.gameDao.getAllGames();
      expect(allGames.length, 2);
      expect(allGames.any((g) => g.id == testGame2.id), false);
      expect(allGames.any((g) => g.id == testGame1.id), true);
      expect(allGames.any((g) => g.id == testGame3.id), true);
    });

    // ==================== gameExists ====================
    test('gameExists returns true for existing game', () async {
      await database.gameDao.addGame(game: testGame1);

      final exists = await database.gameDao.gameExists(gameId: testGame1.id);
      expect(exists, true);
    });

    test('gameExists returns false for non-existent game', () async {
      final exists = await database.gameDao.gameExists(
        gameId: 'non-existent-id',
      );
      expect(exists, false);
    });

    test('gameExists returns false after game is deleted', () async {
      await database.gameDao.addGame(game: testGame1);
      await database.gameDao.deleteGame(gameId: testGame1.id);

      final exists = await database.gameDao.gameExists(gameId: testGame1.id);
      expect(exists, false);
    });

    // ==================== updateGameName ====================
    test('updateGameName updates the name correctly', () async {
      await database.gameDao.addGame(game: testGame1);

      await database.gameDao.updateGameName(
        gameId: testGame1.id,
        newName: 'Updated Chess',
      );

      final updatedGame = await database.gameDao.getGameById(
        gameId: testGame1.id,
      );
      expect(updatedGame.name, 'Updated Chess');
      expect(updatedGame.ruleset, testGame1.ruleset);
    });

    test('updateGameName does nothing for non-existent game', () async {
      await database.gameDao.updateGameName(
        gameId: 'non-existent-id',
        newName: 'New Name',
      );

      final allGames = await database.gameDao.getAllGames();
      expect(allGames, isEmpty);
    });

    // ==================== updateGameRuleset ====================
    test('updateGameRuleset updates the ruleset correctly', () async {
      await database.gameDao.addGame(game: testGame1);

      await database.gameDao.updateGameRuleset(
        gameId: testGame1.id,
        newRuleset: 'New ruleset for chess',
      );

      final updatedGame = await database.gameDao.getGameById(
        gameId: testGame1.id,
      );
      expect(updatedGame.ruleset, 'New ruleset for chess');
      expect(updatedGame.name, testGame1.name);
    });

    test('updateGameRuleset does nothing for non-existent game', () async {
      await database.gameDao.updateGameRuleset(
        gameId: 'non-existent-id',
        newRuleset: 'New Ruleset',
      );

      final allGames = await database.gameDao.getAllGames();
      expect(allGames, isEmpty);
    });

    // ==================== updateGameDescription ====================
    test('updateGameDescription updates the description correctly', () async {
      await database.gameDao.addGame(game: testGame1);

      await database.gameDao.updateGameDescription(
        gameId: testGame1.id,
        newDescription: 'An updated description',
      );

      final updatedGame = await database.gameDao.getGameById(
        gameId: testGame1.id,
      );
      expect(updatedGame.description, 'An updated description');
    });

    test('updateGameDescription can set description to null', () async {
      await database.gameDao.addGame(game: testGame1);

      await database.gameDao.updateGameDescription(
        gameId: testGame1.id,
        newDescription: null,
      );

      final updatedGame = await database.gameDao.getGameById(
        gameId: testGame1.id,
      );
      expect(updatedGame.description, isNull);
    });

    test('updateGameDescription does nothing for non-existent game', () async {
      await database.gameDao.updateGameDescription(
        gameId: 'non-existent-id',
        newDescription: 'New Description',
      );

      final allGames = await database.gameDao.getAllGames();
      expect(allGames, isEmpty);
    });

    // ==================== updateGameColor ====================
    test('updateGameColor updates the color correctly', () async {
      await database.gameDao.addGame(game: testGame1);

      await database.gameDao.updateGameColor(
        gameId: testGame1.id,
        newColor: 0xFF00FF00,
      );

      final updatedGame = await database.gameDao.getGameById(
        gameId: testGame1.id,
      );
      expect(updatedGame.color, 0xFF00FF00);
    });

    test('updateGameColor can set color to null', () async {
      await database.gameDao.addGame(game: testGame1);

      await database.gameDao.updateGameColor(
        gameId: testGame1.id,
        newColor: null,
      );

      final updatedGame = await database.gameDao.getGameById(
        gameId: testGame1.id,
      );
      expect(updatedGame.color, isNull);
    });

    test('updateGameColor does nothing for non-existent game', () async {
      await database.gameDao.updateGameColor(
        gameId: 'non-existent-id',
        newColor: 0xFF00FF00,
      );

      final allGames = await database.gameDao.getAllGames();
      expect(allGames, isEmpty);
    });

    // ==================== updateGameIcon ====================
    test('updateGameIcon updates the icon correctly', () async {
      await database.gameDao.addGame(game: testGame1);

      await database.gameDao.updateGameIcon(
        gameId: testGame1.id,
        newIcon: 'new_chess_icon',
      );

      final updatedGame = await database.gameDao.getGameById(
        gameId: testGame1.id,
      );
      expect(updatedGame.icon, 'new_chess_icon');
    });

    test('updateGameIcon can set icon to null', () async {
      await database.gameDao.addGame(game: testGame1);

      await database.gameDao.updateGameIcon(
        gameId: testGame1.id,
        newIcon: null,
      );

      final updatedGame = await database.gameDao.getGameById(
        gameId: testGame1.id,
      );
      expect(updatedGame.icon, isNull);
    });

    test('updateGameIcon does nothing for non-existent game', () async {
      await database.gameDao.updateGameIcon(
        gameId: 'non-existent-id',
        newIcon: 'some_icon',
      );

      final allGames = await database.gameDao.getAllGames();
      expect(allGames, isEmpty);
    });

    // ==================== getGameCount ====================
    test('getGameCount returns 0 when no games exist', () async {
      final count = await database.gameDao.getGameCount();
      expect(count, 0);
    });

    test('getGameCount returns correct count after adding games', () async {
      await database.gameDao.addGamesAsList(
        games: [testGame1, testGame2, testGame3],
      );

      final count = await database.gameDao.getGameCount();
      expect(count, 3);
    });

    test('getGameCount updates correctly after deletion', () async {
      await database.gameDao.addGamesAsList(
        games: [testGame1, testGame2],
      );

      final countBefore = await database.gameDao.getGameCount();
      expect(countBefore, 2);

      await database.gameDao.deleteGame(gameId: testGame1.id);

      final countAfter = await database.gameDao.getGameCount();
      expect(countAfter, 1);
    });

    // ==================== deleteAllGames ====================
    test('deleteAllGames removes all games', () async {
      await database.gameDao.addGamesAsList(
        games: [testGame1, testGame2, testGame3],
      );

      final countBefore = await database.gameDao.getGameCount();
      expect(countBefore, 3);

      final result = await database.gameDao.deleteAllGames();
      expect(result, true);

      final countAfter = await database.gameDao.getGameCount();
      expect(countAfter, 0);
    });

    test('deleteAllGames returns false when no games exist', () async {
      final result = await database.gameDao.deleteAllGames();
      expect(result, false);
    });

    // ==================== Edge Cases ====================
    test('Game with special characters in name is stored correctly', () async {
      final specialGame = Game(
        name: 'Game\'s & "Special" <Name>',
        description: 'Description with émojis 🎮🎲',
      );
      await database.gameDao.addGame(game: specialGame);

      final fetchedGame = await database.gameDao.getGameById(
        gameId: specialGame.id,
      );
      expect(fetchedGame.name, 'Game\'s & "Special" <Name>');
      expect(fetchedGame.description, 'Description with émojis 🎮🎲');
    });

    test('Game with empty string fields is stored correctly', () async {
      final emptyGame = Game(
        name: '',
        ruleset: '',
        description: '',
        icon: '',
      );
      await database.gameDao.addGame(game: emptyGame);

      final fetchedGame = await database.gameDao.getGameById(
        gameId: emptyGame.id,
      );
      expect(fetchedGame.name, '');
      expect(fetchedGame.ruleset, '');
      expect(fetchedGame.description, '');
      expect(fetchedGame.icon, '');
    });

    test('Game with very long strings is stored correctly', () async {
      final longString = 'A' * 10000;
      final longGame = Game(
        name: longString,
        description: longString,
        ruleset: longString,
      );
      await database.gameDao.addGame(game: longGame);

      final fetchedGame = await database.gameDao.getGameById(
        gameId: longGame.id,
      );
      expect(fetchedGame.name.length, 10000);
      expect(fetchedGame.description?.length, 10000);
      expect(fetchedGame.ruleset?.length, 10000);
    });

    test('Multiple updates to the same game work correctly', () async {
      await database.gameDao.addGame(game: testGame1);

      await database.gameDao.updateGameName(
        gameId: testGame1.id,
        newName: 'Updated Name',
      );
      await database.gameDao.updateGameColor(
        gameId: testGame1.id,
        newColor: 0xFF123456,
      );
      await database.gameDao.updateGameDescription(
        gameId: testGame1.id,
        newDescription: 'Updated Description',
      );

      final updatedGame = await database.gameDao.getGameById(
        gameId: testGame1.id,
      );
      expect(updatedGame.name, 'Updated Name');
      expect(updatedGame.color, 0xFF123456);
      expect(updatedGame.description, 'Updated Description');
      expect(updatedGame.ruleset, testGame1.ruleset);
      expect(updatedGame.icon, testGame1.icon);
    });
  });
}

