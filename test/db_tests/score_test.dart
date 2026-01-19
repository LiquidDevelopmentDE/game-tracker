import 'package:clock/clock.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/game.dart';
import 'package:game_tracker/data/dto/match.dart';
import 'package:game_tracker/data/dto/player.dart';

void main() {
  late AppDatabase database;
  late Player testPlayer1;
  late Player testPlayer2;
  late Player testPlayer3;
  late Game testGame;
  late Match testMatch1;
  late Match testMatch2;
  final fixedDate = DateTime(2025, 19, 11, 00, 11, 23);
  final fakeClock = Clock(() => fixedDate);

  setUp(() async {
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
      testGame = Game(name: 'Test Game');
      testMatch1 = Match(
        name: 'Test Match 1',
        game: testGame,
        players: [testPlayer1, testPlayer2],
      );
      testMatch2 = Match(
        name: 'Test Match 2',
        game: testGame,
        players: [testPlayer2, testPlayer3],
      );
    });

    await database.playerDao.addPlayersAsList(
      players: [testPlayer1, testPlayer2, testPlayer3],
    );
    await database.gameDao.addGame(game: testGame);
    await database.matchDao.addMatch(match: testMatch1);
    await database.matchDao.addMatch(match: testMatch2);
  });

  tearDown(() async {
    await database.close();
  });

  group('Score Tests', () {
    test('Adding and fetching a score works correctly', () async {
      await database.scoreDao.addScore(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
        roundNumber: 1,
        score: 10,
        change: 10,
      );

      final score = await database.scoreDao.getScoreForRound(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
        roundNumber: 1,
      );

      expect(score, isNotNull);
      expect(score!.playerId, testPlayer1.id);
      expect(score.matchId, testMatch1.id);
      expect(score.roundNumber, 1);
      expect(score.score, 10);
      expect(score.change, 10);
    });

    test('Getting scores for a match works correctly', () async {
      await database.scoreDao.addScore(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
        roundNumber: 1,
        score: 10,
        change: 10,
      );
      await database.scoreDao.addScore(
        playerId: testPlayer2.id,
        matchId: testMatch1.id,
        roundNumber: 1,
        score: 20,
        change: 20,
      );
      await database.scoreDao.addScore(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
        roundNumber: 2,
        score: 25,
        change: 15,
      );

      final scores = await database.scoreDao.getScoresForMatch(
        matchId: testMatch1.id,
      );

      expect(scores.length, 3);
    });

    test('Getting player scores in a match works correctly', () async {
      await database.scoreDao.addScore(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
        roundNumber: 1,
        score: 10,
        change: 10,
      );
      await database.scoreDao.addScore(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
        roundNumber: 2,
        score: 25,
        change: 15,
      );
      await database.scoreDao.addScore(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
        roundNumber: 3,
        score: 30,
        change: 5,
      );

      final playerScores = await database.scoreDao.getPlayerScoresInMatch(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
      );

      expect(playerScores.length, 3);
      expect(playerScores[0].roundNumber, 1);
      expect(playerScores[1].roundNumber, 2);
      expect(playerScores[2].roundNumber, 3);
      expect(playerScores[0].score, 10);
      expect(playerScores[1].score, 25);
      expect(playerScores[2].score, 30);
    });

    test('Getting score for a non-existent round returns null', () async {
      final score = await database.scoreDao.getScoreForRound(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
        roundNumber: 999,
      );

      expect(score, isNull);
    });

    test('Updating a score works correctly', () async {
      await database.scoreDao.addScore(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
        roundNumber: 1,
        score: 10,
        change: 10,
      );

      final updated = await database.scoreDao.updateScore(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
        roundNumber: 1,
        newScore: 50,
        newChange: 40,
      );

      expect(updated, true);

      final score = await database.scoreDao.getScoreForRound(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
        roundNumber: 1,
      );

      expect(score, isNotNull);
      expect(score!.score, 50);
      expect(score.change, 40);
    });

    test('Updating a non-existent score returns false', () async {
      final updated = await database.scoreDao.updateScore(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
        roundNumber: 999,
        newScore: 50,
        newChange: 40,
      );

      expect(updated, false);
    });

    test('Deleting a score works correctly', () async {
      await database.scoreDao.addScore(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
        roundNumber: 1,
        score: 10,
        change: 10,
      );

      final deleted = await database.scoreDao.deleteScore(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
        roundNumber: 1,
      );

      expect(deleted, true);

      final score = await database.scoreDao.getScoreForRound(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
        roundNumber: 1,
      );

      expect(score, isNull);
    });

    test('Deleting a non-existent score returns false', () async {
      final deleted = await database.scoreDao.deleteScore(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
        roundNumber: 999,
      );

      expect(deleted, false);
    });

    test('Deleting scores for a match works correctly', () async {
      await database.scoreDao.addScore(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
        roundNumber: 1,
        score: 10,
        change: 10,
      );
      await database.scoreDao.addScore(
        playerId: testPlayer2.id,
        matchId: testMatch1.id,
        roundNumber: 1,
        score: 20,
        change: 20,
      );
      await database.scoreDao.addScore(
        playerId: testPlayer1.id,
        matchId: testMatch2.id,
        roundNumber: 1,
        score: 15,
        change: 15,
      );

      final deleted = await database.scoreDao.deleteScoresForMatch(
        matchId: testMatch1.id,
      );

      expect(deleted, true);

      final match1Scores = await database.scoreDao.getScoresForMatch(
        matchId: testMatch1.id,
      );
      expect(match1Scores.length, 0);

      final match2Scores = await database.scoreDao.getScoresForMatch(
        matchId: testMatch2.id,
      );
      expect(match2Scores.length, 1);
    });

    test('Deleting scores for a player works correctly', () async {
      await database.scoreDao.addScore(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
        roundNumber: 1,
        score: 10,
        change: 10,
      );
      await database.scoreDao.addScore(
        playerId: testPlayer1.id,
        matchId: testMatch2.id,
        roundNumber: 1,
        score: 15,
        change: 15,
      );
      await database.scoreDao.addScore(
        playerId: testPlayer2.id,
        matchId: testMatch1.id,
        roundNumber: 1,
        score: 20,
        change: 20,
      );

      final deleted = await database.scoreDao.deleteScoresForPlayer(
        playerId: testPlayer1.id,
      );

      expect(deleted, true);

      final player1Scores = await database.scoreDao.getPlayerScoresInMatch(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
      );
      expect(player1Scores.length, 0);

      final player2Scores = await database.scoreDao.getPlayerScoresInMatch(
        playerId: testPlayer2.id,
        matchId: testMatch1.id,
      );
      expect(player2Scores.length, 1);
    });

    test('Getting latest round number works correctly', () async {
      var latestRound = await database.scoreDao.getLatestRoundNumber(
        matchId: testMatch1.id,
      );
      expect(latestRound, 0);

      await database.scoreDao.addScore(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
        roundNumber: 1,
        score: 10,
        change: 10,
      );

      latestRound = await database.scoreDao.getLatestRoundNumber(
        matchId: testMatch1.id,
      );
      expect(latestRound, 1);

      await database.scoreDao.addScore(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
        roundNumber: 5,
        score: 50,
        change: 40,
      );

      latestRound = await database.scoreDao.getLatestRoundNumber(
        matchId: testMatch1.id,
      );
      expect(latestRound, 5);
    });

    test('Getting total score for a player works correctly', () async {
      var totalScore = await database.scoreDao.getTotalScoreForPlayer(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
      );
      expect(totalScore, 0);

      await database.scoreDao.addScore(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
        roundNumber: 1,
        score: 10,
        change: 10,
      );
      await database.scoreDao.addScore(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
        roundNumber: 2,
        score: 25,
        change: 15,
      );
      await database.scoreDao.addScore(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
        roundNumber: 3,
        score: 40,
        change: 15,
      );

      totalScore = await database.scoreDao.getTotalScoreForPlayer(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
      );
      expect(totalScore, 40);
    });

    test('Adding the same score twice replaces the existing one', () async {
      await database.scoreDao.addScore(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
        roundNumber: 1,
        score: 10,
        change: 10,
      );
      await database.scoreDao.addScore(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
        roundNumber: 1,
        score: 99,
        change: 99,
      );

      final score = await database.scoreDao.getScoreForRound(
        playerId: testPlayer1.id,
        matchId: testMatch1.id,
        roundNumber: 1,
      );

      expect(score, isNotNull);
      expect(score!.score, 99);
      expect(score.change, 99);
    });
  });
}

