import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/player.dart';

void main() {
  late AppDatabase database;
  late Player testPlayer;

  setUp(() {
    database = AppDatabase(
      DatabaseConnection(
        NativeDatabase.memory(),
        // Recommended for widget tests to avoid test errors.
        closeStreamsSynchronously: true,
      ),
    );

    testPlayer = Player(id: 'test_id', name: 'Test Player');
  });
  tearDown(() async {
    await database.close();
  });

  group('player tests', () {
    test('all players get fetched correclty', () async {
      final testPlayer2 = Player(id: 'gr2', name: 'Second Group');
      await database.playerDao.addPlayer(player: testPlayer);
      await database.playerDao.addPlayer(player: testPlayer2);

      final allPlayers = await database.playerDao.getAllPlayers();
      expect(allPlayers.length, 2);

      final fetchedPlayer1 = allPlayers.firstWhere(
        (g) => g.id == testPlayer.id,
      );
      expect(fetchedPlayer1.name, testPlayer.name);

      final fetchedPlayer2 = allPlayers.firstWhere(
        (g) => g.id == testPlayer2.id,
      );
      expect(fetchedPlayer2.name, testPlayer2.name);
    });

    test('players get inserted correcly ', () async {
      await database.playerDao.addPlayer(player: testPlayer);
      final result = await database.playerDao.getPlayerById(
        playerId: testPlayer.id,
      );

      expect(result.id, testPlayer.id);
      expect(result.name, testPlayer.name);
    });

    test('players get deleted correcly ', () async {
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

    test('player name gets updated correcly ', () async {
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

    test('get player count works correctly', () async {
      final initialCount = await database.playerDao.getPlayerCount();
      expect(initialCount, 0);

      await database.playerDao.addPlayer(player: testPlayer);

      final playerAdded = await database.playerDao.getPlayerCount();
      expect(playerAdded, 1);

      final playerRemoved = await database.playerDao.deletePlayer(
        playerId: testPlayer.id,
      );
      expect(playerRemoved, true);

      final finalCount = await database.playerDao.getPlayerCount();
      expect(finalCount, 0);
    });
  });
}
