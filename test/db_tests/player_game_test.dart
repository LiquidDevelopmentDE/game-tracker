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
  late Player testPlayer6;
  late Group testgroup;
  late Game testGameOnlyGroup;
  late Game testGameOnlyPlayers;
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
      testPlayer6 = Player(name: 'Frank');
      testgroup = Group(
        name: 'Test Group',
        members: [testPlayer1, testPlayer2, testPlayer3],
      );
      testGameOnlyGroup = Game(name: 'Test Game with Group', group: testgroup);
      testGameOnlyPlayers = Game(
        name: 'Test Game with Players',
        players: [testPlayer4, testPlayer5, testPlayer6],
      );
    });
  });
  tearDown(() async {
    await database.close();
  });

  group('Player-Game Tests', () {
    test('Game has player works correctly', () async {
      await database.gameDao.addGame(game: testGameOnlyGroup);
      await database.playerDao.addPlayer(player: testPlayer1);

      var gameHasPlayers = await database.playerGameDao.gameHasPlayers(
        gameId: testGameOnlyGroup.id,
      );

      expect(gameHasPlayers, false);

      await database.playerGameDao.addPlayerToGame(
        gameId: testGameOnlyGroup.id,
        playerId: testPlayer1.id,
      );

      gameHasPlayers = await database.playerGameDao.gameHasPlayers(
        gameId: testGameOnlyGroup.id,
      );

      expect(gameHasPlayers, true);
    });

    test('Adding a player to a game works correctly', () async {
      await database.gameDao.addGame(game: testGameOnlyGroup);
      await database.playerDao.addPlayer(player: testPlayer5);
      await database.playerGameDao.addPlayerToGame(
        gameId: testGameOnlyGroup.id,
        playerId: testPlayer5.id,
      );

      var playerAdded = await database.playerGameDao.isPlayerInGame(
        gameId: testGameOnlyGroup.id,
        playerId: testPlayer5.id,
      );

      expect(playerAdded, true);

      playerAdded = await database.playerGameDao.isPlayerInGame(
        gameId: testGameOnlyGroup.id,
        playerId: '',
      );

      expect(playerAdded, false);
    });

    test('Removing player from game works correctly', () async {
      await database.gameDao.addGame(game: testGameOnlyPlayers);

      final playerToRemove = testGameOnlyPlayers.players![0];

      final removed = await database.playerGameDao.removePlayerFromGame(
        playerId: playerToRemove.id,
        gameId: testGameOnlyPlayers.id,
      );
      expect(removed, true);

      final result = await database.gameDao.getGameById(
        gameId: testGameOnlyPlayers.id,
      );
      expect(result.players!.length, testGameOnlyPlayers.players!.length - 1);

      final playerExists = result.players!.any(
        (p) => p.id == playerToRemove.id,
      );
      expect(playerExists, false);
    });

    test('Retrieving players of a game works correctly', () async {
      await database.gameDao.addGame(game: testGameOnlyPlayers);
      final players = await database.playerGameDao.getPlayersOfGame(
        gameId: testGameOnlyPlayers.id,
      );

      if (players == null) {
        fail('Players should not be null');
      }

      for (int i = 0; i < players.length; i++) {
        expect(players[i].id, testGameOnlyPlayers.players![i].id);
        expect(players[i].name, testGameOnlyPlayers.players![i].name);
        expect(players[i].createdAt, testGameOnlyPlayers.players![i].createdAt);
      }
    });

    test('Updating the games players works coreclty', () async {
      await database.gameDao.addGame(game: testGameOnlyPlayers);

      final newPlayers = [testPlayer1, testPlayer2, testPlayer4];
      await database.playerDao.addPlayersAsList(players: newPlayers);

      // First, remove all existing players
      final existingPlayers = await database.playerGameDao.getPlayersOfGame(
        gameId: testGameOnlyPlayers.id,
      );

      print('existingPlayers: $existingPlayers');
      if (existingPlayers == null || existingPlayers.isEmpty) {
        fail('Existing players should not be null or empty');
      }

      await database.playerGameDao.updatePlayersFromGame(
        gameId: testGameOnlyPlayers.id,
        newPlayer: newPlayers,
      );

      final updatedPlayers = await database.playerGameDao.getPlayersOfGame(
        gameId: testGameOnlyPlayers.id,
      );

      if (updatedPlayers == null) {
        fail('Updated players should not be null');
      }

      expect(updatedPlayers.length, newPlayers.length);

      /// Create a map of new players for easy lookup
      final testPlayers = {for (var p in newPlayers) p.id: p};

      /// Verify each updated player matches the new players
      for (final player in updatedPlayers) {
        final testPlayer = testPlayers[player.id]!;

        expect(player.id, testPlayer.id);
        expect(player.name, testPlayer.name);
        expect(player.createdAt, testPlayer.createdAt);
      }
    });
  });
}
