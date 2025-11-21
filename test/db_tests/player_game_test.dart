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
  late Player player6;
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
      player1 = Player(name: 'Alice');
      player2 = Player(name: 'Bob');
      player3 = Player(name: 'Charlie');
      player4 = Player(name: 'Diana');
      player5 = Player(name: 'Eve');
      player6 = Player(name: 'Frank');
      testgroup = Group(
        name: 'Test Group',
        members: [player1, player2, player3],
      );
      testgameWithGroup = Game(name: 'Test Game', group: testgroup);
      testgameWithPlayers = Game(
        name: 'Test Game with Players',
        players: [player4, player5, player6],
      );
    });
  });
  tearDown(() async {
    await database.close();
  });

  group('Player-Game Tests', () {
    test('Game has player works correctly', () async {
      database.gameDao.addGame(game: testgameWithGroup);
      database.playerDao.addPlayer(player: player1);

      var gameHasPlayers = await database.playerGameDao.gameHasPlayers(
        gameId: testgameWithGroup.id,
      );

      expect(gameHasPlayers, false);

      database.playerGameDao.addPlayerToGame(
        gameId: testgameWithGroup.id,
        playerId: player1.id,
      );

      gameHasPlayers = await database.playerGameDao.gameHasPlayers(
        gameId: testgameWithGroup.id,
      );

      expect(gameHasPlayers, true);
    });

    test('Adding a player to a game works correctly', () async {
      database.gameDao.addGame(game: testgameWithGroup);
      database.playerDao.addPlayer(player: player5);
      database.playerGameDao.addPlayerToGame(
        gameId: testgameWithGroup.id,
        playerId: player5.id,
      );

      var playerAdded = await database.playerGameDao.isPlayerInGame(
        gameId: testgameWithGroup.id,
        playerId: player5.id,
      );

      expect(playerAdded, true);

      playerAdded = await database.playerGameDao.isPlayerInGame(
        gameId: testgameWithGroup.id,
        playerId: '',
      );

      expect(playerAdded, false);
    });

    test('Removing player from game works correctly', () async {
      await database.gameDao.addGame(game: testgameWithPlayers);

      final playerToRemove = testgameWithPlayers.players![0];

      final removed = await database.playerGameDao.removePlayerFromGame(
        playerId: playerToRemove.id,
        gameId: testgameWithPlayers.id,
      );
      expect(removed, true);

      final result = await database.gameDao.getGameById(
        gameId: testgameWithPlayers.id,
      );
      expect(result.players!.length, testgameWithPlayers.players!.length - 1);

      final playerExists = result.players!.any(
        (p) => p.id == playerToRemove.id,
      );
      expect(playerExists, false);
    });

    //TODO: test getPlayersOfGame()
    test('Retrieving players of a game works correctly', () async {});
  });
}
