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
  late Group testgroup;
  late Game testgame;

  setUp(() {
    database = AppDatabase(
      DatabaseConnection(
        NativeDatabase.memory(),
        // Recommended for widget tests to avoid test errors.
        closeStreamsSynchronously: true,
      ),
    );

    player1 = Player(id: 'p1', name: 'Alice');
    player2 = Player(id: 'p2', name: 'Bob');
    player3 = Player(id: 'p3', name: 'Charlie');
    player4 = Player(id: 'p4', name: 'Diana');
    testgroup = Group(
      id: 'gr1',
      name: 'Test Group',
      members: [player1, player2, player3],
    );
    testgame = Game(
      id: 'ga1',
      name: 'Test Game',
      group: testgroup,
      players: [player4],
    );
  });
  tearDown(() async {
    await database.close();
  });

  group('game tests', () {
    test('game is added correctly', () async {
      await database.gameDao.addGame(game: testgame);

      final result = await database.gameDao.getGameById(gameId: testgame.id);

      expect(result.id, testgame.id);
      expect(result.name, testgame.name);
      expect(result.winner, testgame.winner);

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
        }
      } else {
        fail('Players is null');
      }
    });

    test('game is deleted correctly', () async {
      await database.gameDao.addGame(game: testgame);

      final gameDeleted = await database.gameDao.deleteGame(
        gameId: testgame.id,
      );
      expect(gameDeleted, true);

      final gameExists = await database.gameDao.gameExists(gameId: testgame.id);
      expect(gameExists, false);
    });

    test('get game count works correctly', () async {
      final initialCount = await database.gameDao.getGameCount();
      expect(initialCount, 0);

      await database.gameDao.addGame(game: testgame);

      final gameAdded = await database.gameDao.getGameCount();
      expect(gameAdded, 1);

      final gameRemoved = await database.gameDao.deleteGame(
        gameId: testgame.id,
      );
      expect(gameRemoved, true);

      final finalCount = await database.gameDao.getGameCount();
      expect(finalCount, 0);
    });
  });
}
