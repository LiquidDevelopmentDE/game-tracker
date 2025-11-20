import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/player.dart';

void main() {
  late AppDatabase database;
  late Player player1;
  late Player player2;
  late Player player3;
  late Player player4;
  late Group testgroup;
  late Group testgroup2;
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
      testgroup = Group(
        name: 'Test Group',
        members: [player1, player2, player3],
      );
      testgroup2 = Group(
        id: 'gr2',
        name: 'Second Group',
        members: [player2, player3, player4],
      );
    });
  });
  tearDown(() async {
    await database.close();
  });
  group('Group Tests', () {
    test('Adding and fetching a single group works correctly', () async {
      await database.groupDao.addGroup(group: testgroup);

      final fetchedGroup = await database.groupDao.getGroupById(
        groupId: testgroup.id,
      );

      expect(fetchedGroup.id, testgroup.id);
      expect(fetchedGroup.name, testgroup.name);
      expect(fetchedGroup.createdAt, testgroup.createdAt);

      expect(fetchedGroup.members.length, testgroup.members.length);
      for (int i = 0; i < testgroup.members.length; i++) {
        expect(fetchedGroup.members[i].id, testgroup.members[i].id);
        expect(fetchedGroup.members[i].name, testgroup.members[i].name);
        expect(
          fetchedGroup.members[i].createdAt,
          testgroup.members[i].createdAt,
        );
      }
    });

    test('Adding and fetching a single group works correctly', () async {
      await database.groupDao.addGroups(groups: [testgroup, testgroup2]);

      final allGroups = await database.groupDao.getAllGroups();
      expect(allGroups.length, 2);

      final fetchedGroup1 = allGroups.firstWhere((g) => g.id == testgroup.id);
      expect(fetchedGroup1.name, testgroup.name);
      expect(fetchedGroup1.members.length, testgroup.members.length);
      expect(fetchedGroup1.members.elementAt(0).id, player1.id);
      expect(fetchedGroup1.members.elementAt(0).createdAt, player1.createdAt);

      final fetchedGroup2 = allGroups.firstWhere((g) => g.id == testgroup2.id);
      expect(fetchedGroup2.name, testgroup2.name);
      expect(fetchedGroup2.members.length, testgroup2.members.length);
      expect(fetchedGroup2.members.elementAt(0).id, player2.id);
      expect(fetchedGroup2.members.elementAt(0).createdAt, player2.createdAt);
    });

    test('Adding the same group twice does not create duplicates', () async {
      await database.groupDao.addGroup(group: testgroup);
      await database.groupDao.addGroup(group: testgroup);

      final allGroups = await database.groupDao.getAllGroups();
      expect(allGroups.length, 1);
    });

    test('Group existence check works correctly', () async {
      var groupExists = await database.groupDao.groupExists(
        groupId: testgroup.id,
      );
      expect(groupExists, false);

      await database.groupDao.addGroup(group: testgroup);

      groupExists = await database.groupDao.groupExists(groupId: testgroup.id);
      expect(groupExists, true);
    });

    test('Deleting a group works correclty', () async {
      await database.groupDao.addGroup(group: testgroup);

      final groupDeleted = await database.groupDao.deleteGroup(
        groupId: testgroup.id,
      );
      expect(groupDeleted, true);

      final groupExists = await database.groupDao.groupExists(
        groupId: testgroup.id,
      );
      expect(groupExists, false);
    });

    test('Updating a group name works correcly', () async {
      await database.groupDao.addGroup(group: testgroup);

      const newGroupName = 'new group name';

      await database.groupDao.updateGroupname(
        groupId: testgroup.id,
        newName: newGroupName,
      );

      final result = await database.groupDao.getGroupById(
        groupId: testgroup.id,
      );
      expect(result.name, newGroupName);
    });

    test('Adding player to group works correctly', () async {
      await database.groupDao.addGroup(group: testgroup);

      await database.playerGroupDao.addPlayerToGroup(
        player: player4,
        groupId: testgroup.id,
      );

      final playerAdded = await database.playerGroupDao.isPlayerInGroup(
        playerId: player4.id,
        groupId: testgroup.id,
      );

      expect(playerAdded, true);

      final playerNotAdded = !await database.playerGroupDao.isPlayerInGroup(
        playerId: '',
        groupId: testgroup.id,
      );

      expect(playerNotAdded, true);

      final result = await database.groupDao.getGroupById(
        groupId: testgroup.id,
      );
      expect(result.members.length, testgroup.members.length + 1);

      final addedPlayer = result.members.firstWhere((p) => p.id == player4.id);
      expect(addedPlayer.name, player4.name);
      expect(addedPlayer.createdAt, player4.createdAt);
    });

    test('Removing player from group works correctly', () async {
      await database.groupDao.addGroup(group: testgroup);

      final playerToRemove = testgroup.members[0];

      final removed = await database.playerGroupDao.removePlayerFromGroup(
        playerId: playerToRemove.id,
        groupId: testgroup.id,
      );
      expect(removed, true);

      final result = await database.groupDao.getGroupById(
        groupId: testgroup.id,
      );
      expect(result.members.length, testgroup.members.length - 1);

      final playerExists = result.members.any((p) => p.id == playerToRemove.id);
      expect(playerExists, false);
    });

    test('Getting the group count works correctly', () async {
      final initialCount = await database.groupDao.getGroupCount();
      expect(initialCount, 0);

      await database.groupDao.addGroup(group: testgroup);

      final groupAdded = await database.groupDao.getGroupCount();
      expect(groupAdded, 1);

      final groupRemoved = await database.groupDao.deleteGroup(
        groupId: testgroup.id,
      );
      expect(groupRemoved, true);

      final finalCount = await database.groupDao.getGroupCount();
      expect(finalCount, 0);
    });
  });
}
