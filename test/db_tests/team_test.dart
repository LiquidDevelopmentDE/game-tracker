import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:game_tracker/data/dto/team.dart';

void main() {
  late AppDatabase database;
  late Player testPlayer1;
  late Player testPlayer2;
  late Player testPlayer3;
  late Player testPlayer4;
  late Team testTeam1;
  late Team testTeam2;
  late Team testTeam3;
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
      testPlayer4 = Player(name: 'Diana');
      testTeam1 = Team(
        name: 'Team Alpha',
        members: [testPlayer1, testPlayer2],
      );
      testTeam2 = Team(
        name: 'Team Beta',
        members: [testPlayer3, testPlayer4],
      );
      testTeam3 = Team(
        name: 'Team Gamma',
        members: [testPlayer1, testPlayer3],
      );
    });

    await database.playerDao.addPlayersAsList(
      players: [testPlayer1, testPlayer2, testPlayer3, testPlayer4],
    );
  });

  tearDown(() async {
    await database.close();
  });

  group('Team Tests', () {

    // Verifies that a single team can be added and retrieved with all fields intact.
    test('Adding and fetching a single team works correctly', () async {
      final added = await database.teamDao.addTeam(team: testTeam1);
      expect(added, true);

      final fetchedTeam = await database.teamDao.getTeamById(
        teamId: testTeam1.id,
      );

      expect(fetchedTeam.id, testTeam1.id);
      expect(fetchedTeam.name, testTeam1.name);
      expect(fetchedTeam.createdAt, testTeam1.createdAt);
    });

    // Verifies that multiple teams can be added at once and retrieved correctly.
    test('Adding and fetching multiple teams works correctly', () async {
      await database.teamDao.addTeamsAsList(
        teams: [testTeam1, testTeam2, testTeam3],
      );

      final allTeams = await database.teamDao.getAllTeams();
      expect(allTeams.length, 3);

      final testTeams = {
        testTeam1.id: testTeam1,
        testTeam2.id: testTeam2,
        testTeam3.id: testTeam3,
      };

      for (final team in allTeams) {
        final testTeam = testTeams[team.id]!;

        expect(team.id, testTeam.id);
        expect(team.name, testTeam.name);
        expect(team.createdAt, testTeam.createdAt);
      }
    });

    // Verifies that adding the same team twice does not create duplicates and returns false.
    test('Adding the same team twice does not create duplicates', () async {
      await database.teamDao.addTeam(team: testTeam1);
      final addedAgain = await database.teamDao.addTeam(team: testTeam1);

      expect(addedAgain, false);

      final teamCount = await database.teamDao.getTeamCount();
      expect(teamCount, 1);
    });

    // Verifies that teamExists returns correct boolean based on team presence.
    test('Team existence check works correctly', () async {
      var teamExists = await database.teamDao.teamExists(teamId: testTeam1.id);
      expect(teamExists, false);

      await database.teamDao.addTeam(team: testTeam1);

      teamExists = await database.teamDao.teamExists(teamId: testTeam1.id);
      expect(teamExists, true);
    });

    // Verifies that deleteTeam removes the team and returns true.
    test('Deleting a team works correctly', () async {
      await database.teamDao.addTeam(team: testTeam1);

      final teamDeleted = await database.teamDao.deleteTeam(
        teamId: testTeam1.id,
      );
      expect(teamDeleted, true);

      final teamExists = await database.teamDao.teamExists(
        teamId: testTeam1.id,
      );
      expect(teamExists, false);
    });

    // Verifies that deleteTeam returns false for a non-existent team ID.
    test('Deleting a non-existent team returns false', () async {
      final teamDeleted = await database.teamDao.deleteTeam(
        teamId: 'non-existent-id',
      );
      expect(teamDeleted, false);
    });

    // Verifies that getTeamCount returns correct count through add/delete operations.
    test('Getting the team count works correctly', () async {
      var teamCount = await database.teamDao.getTeamCount();
      expect(teamCount, 0);

      await database.teamDao.addTeam(team: testTeam1);

      teamCount = await database.teamDao.getTeamCount();
      expect(teamCount, 1);

      await database.teamDao.addTeam(team: testTeam2);

      teamCount = await database.teamDao.getTeamCount();
      expect(teamCount, 2);

      await database.teamDao.deleteTeam(teamId: testTeam1.id);

      teamCount = await database.teamDao.getTeamCount();
      expect(teamCount, 1);

      await database.teamDao.deleteTeam(teamId: testTeam2.id);

      teamCount = await database.teamDao.getTeamCount();
      expect(teamCount, 0);
    });

    // Verifies that updateTeamName correctly updates only the name field.
    test('Updating team name works correctly', () async {
      await database.teamDao.addTeam(team: testTeam1);

      var fetchedTeam = await database.teamDao.getTeamById(
        teamId: testTeam1.id,
      );
      expect(fetchedTeam.name, testTeam1.name);

      const newName = 'Updated Team Name';
      await database.teamDao.updateTeamName(
        teamId: testTeam1.id,
        newName: newName,
      );

      fetchedTeam = await database.teamDao.getTeamById(teamId: testTeam1.id);
      expect(fetchedTeam.name, newName);
    });

    // Verifies that deleteAllTeams removes all teams from the database.
    test('Deleting all teams works correctly', () async {
      await database.teamDao.addTeamsAsList(
        teams: [testTeam1, testTeam2, testTeam3],
      );

      var teamCount = await database.teamDao.getTeamCount();
      expect(teamCount, 3);

      final deleted = await database.teamDao.deleteAllTeams();
      expect(deleted, true);

      teamCount = await database.teamDao.getTeamCount();
      expect(teamCount, 0);
    });

    // Verifies that deleteAllTeams returns false when no teams exist.
    test('Deleting all teams when empty returns false', () async {
      final deleted = await database.teamDao.deleteAllTeams();
      expect(deleted, false);
    });

    // Verifies that addTeamsAsList returns false when given an empty list.
    test('Adding teams as list with empty list returns false', () async {
      final added = await database.teamDao.addTeamsAsList(teams: []);
      expect(added, false);
    });

    // Verifies that addTeamsAsList with duplicate IDs ignores duplicates and keeps the first.
    test('Adding teams with duplicate IDs ignores duplicates', () async {
      final duplicateTeam = Team(
        id: testTeam1.id,
        name: 'Duplicate Team',
        members: [testPlayer4],
      );

      await database.teamDao.addTeamsAsList(
        teams: [testTeam1, duplicateTeam, testTeam2],
      );

      final teamCount = await database.teamDao.getTeamCount();
      expect(teamCount, 2);

      // The first one should be kept (insertOrIgnore)
      final fetchedTeam = await database.teamDao.getTeamById(
        teamId: testTeam1.id,
      );
      expect(fetchedTeam.name, testTeam1.name);
    });
  });
}