import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/player.dart';

void main() {
  late AppDatabase database;
  late Player testPlayer;
  late Player testPlayer2;
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
      testPlayer = Player(name: 'Test Player');
      testPlayer2 = Player(name: 'Second Player');
    });
  });
  tearDown(() async {
    await database.close();
  });

  group('player tests', () {
    test('Adding and fetching single player works correclty', () async {
      await database.playerDao.addPlayer(player: testPlayer);
      await database.playerDao.addPlayer(player: testPlayer2);

      final allPlayers = await database.playerDao.getAllPlayers();
      expect(allPlayers.length, 2);

      final fetchedPlayer1 = allPlayers.firstWhere(
        (g) => g.id == testPlayer.id,
      );
      expect(fetchedPlayer1.name, testPlayer.name);
      expect(fetchedPlayer1.createdAt, testPlayer.createdAt);

      final fetchedPlayer2 = allPlayers.firstWhere(
        (g) => g.id == testPlayer2.id,
      );
      expect(fetchedPlayer2.name, testPlayer2.name);
      expect(fetchedPlayer2.createdAt, testPlayer2.createdAt);
    });

    // TODO: Use upcoming addPlayers() method
    // TODO: An Tests in Game orientieren
    test('Adding and fetching multiple players works correclty', () async {
      await database.playerDao.addPlayer(player: testPlayer);
      await database.playerDao.addPlayer(player: testPlayer2);

      final allPlayers = await database.playerDao.getAllPlayers();
      expect(allPlayers.length, 2);

      final fetchedPlayer1 = allPlayers.firstWhere(
        (g) => g.id == testPlayer.id,
      );
      expect(fetchedPlayer1.name, testPlayer.name);
      expect(fetchedPlayer1.createdAt, testPlayer.createdAt);

      final fetchedPlayer2 = allPlayers.firstWhere(
        (g) => g.id == testPlayer2.id,
      );
      expect(fetchedPlayer2.name, testPlayer2.name);
      expect(fetchedPlayer2.createdAt, testPlayer2.createdAt);
    });

    test('Adding the same player twice does not create duplicates', () async {
      await database.playerDao.addPlayer(player: testPlayer);
      await database.playerDao.addPlayer(player: testPlayer);

      final allPlayers = await database.playerDao.getAllPlayers();
      expect(allPlayers.length, 1);
    });

    test('Player existence check works correctly', () async {
      var playerExists = await database.playerDao.playerExists(
        playerId: testPlayer.id,
      );
      expect(playerExists, false);

      await database.playerDao.addPlayer(player: testPlayer);

      playerExists = await database.playerDao.playerExists(
        playerId: testPlayer.id,
      );
      expect(playerExists, true);
    });

    test('Deleting a player works correclty', () async {
      await database.playerDao.addPlayer(player: testPlayer);
      final playerDeleted = await database.playerDao.deletePlayer(
        playerId: testPlayer.id,
      );
      expect(playerDeleted, true);

      final playerExists = await database.playerDao.playerExists(
        playerId: testPlayer.id,
      );
      expect(playerExists, false);
    });

    test('Updating a player name works correcly', () async {
      await database.playerDao.addPlayer(player: testPlayer);

      const newPlayerName = 'new player name';

      await database.playerDao.updatePlayername(
        playerId: testPlayer.id,
        newName: newPlayerName,
      );

      final result = await database.playerDao.getPlayerById(
        playerId: testPlayer.id,
      );
      expect(result.name, newPlayerName);
    });

    test('Getting the player count works correctly', () async {
      var playerCount = await database.playerDao.getPlayerCount();
      expect(playerCount, 0);

      await database.playerDao.addPlayer(player: testPlayer);

      playerCount = await database.playerDao.getPlayerCount();
      expect(playerCount, 1);

      await database.playerDao.addPlayer(player: testPlayer2);

      playerCount = await database.playerDao.getPlayerCount();
      expect(playerCount, 2);

      await database.playerDao.deletePlayer(playerId: testPlayer.id);

      playerCount = await database.playerDao.getPlayerCount();
      expect(playerCount, 1);

      await database.playerDao.deletePlayer(playerId: testPlayer2.id);

      playerCount = await database.playerDao.getPlayerCount();
      expect(playerCount, 0);
    });
  });
}
