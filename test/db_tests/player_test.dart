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
  });
}
