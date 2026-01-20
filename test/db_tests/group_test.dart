import 'package:clock/clock.dart';
import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/player.dart';

void main() {
  late AppDatabase database;
  late Player testPlayer1;
  late Player testPlayer2;
  late Player testPlayer3;
  late Player testPlayer4;
  late Group testGroup1;
  late Group testGroup2;
  late Group testGroup3;
  late Group testGroup4;
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
      testGroup1 = Group(
        name: 'Test Group',
        members: [testPlayer1, testPlayer2, testPlayer3],
      );
      testGroup2 = Group(
        id: 'gr2',
        name: 'Second Group',
        members: [testPlayer2, testPlayer3, testPlayer4],
      );
      testGroup3 = Group(
        id: 'gr2',
        name: 'Second Group',
        members: [testPlayer2, testPlayer4],
      );
      testGroup4 = Group(
        id: 'gr2',
        name: 'Second Group',
        members: [testPlayer1, testPlayer2, testPlayer3, testPlayer4],
      );
    });
  });
  tearDown(() async {
    await database.close();
  });
  group('Group Tests', () {
    test('Adding and fetching a single group works correctly', () async {
      await database.groupDao.addGroup(group: testGroup1);

      final fetchedGroup = await database.groupDao.getGroupById(
        groupId: testGroup1.id,
      );

      expect(fetchedGroup.id, testGroup1.id);
      expect(fetchedGroup.name, testGroup1.name);
      expect(fetchedGroup.createdAt, testGroup1.createdAt);

      expect(fetchedGroup.members.length, testGroup1.members.length);
      for (int i = 0; i < testGroup1.members.length; i++) {
        expect(fetchedGroup.members[i].id, testGroup1.members[i].id);
        expect(fetchedGroup.members[i].name, testGroup1.members[i].name);
        expect(
          fetchedGroup.members[i].createdAt,
          testGroup1.members[i].createdAt,
        );
      }
    });

    test('Adding and fetching multiple groups works correctly', () async {
      await database.groupDao.addGroupsAsList(
        groups: [testGroup1, testGroup2, testGroup3, testGroup4],
      );

      final allGroups = await database.groupDao.getAllGroups();
      expect(allGroups.length, 2);

      final testGroups = {testGroup1.id: testGroup1, testGroup2.id: testGroup2};

      for (final group in allGroups) {
        final testGroup = testGroups[group.id]!;

        expect(group.id, testGroup.id);
        expect(group.name, testGroup.name);
        expect(group.createdAt, testGroup.createdAt);

        expect(group.members.length, testGroup.members.length);
        for (int i = 0; i < testGroup.members.length; i++) {
          expect(group.members[i].id, testGroup.members[i].id);
          expect(group.members[i].name, testGroup.members[i].name);
          expect(group.members[i].createdAt, testGroup.members[i].createdAt);
        }
      }
    });

    test('Adding the same group twice does not create duplicates', () async {
      await database.groupDao.addGroup(group: testGroup1);
      await database.groupDao.addGroup(group: testGroup1);

      final allGroups = await database.groupDao.getAllGroups();
      expect(allGroups.length, 1);
    });

    test('Group existence check works correctly', () async {
      var groupExists = await database.groupDao.groupExists(
        groupId: testGroup1.id,
      );
      expect(groupExists, false);

      await database.groupDao.addGroup(group: testGroup1);

      groupExists = await database.groupDao.groupExists(groupId: testGroup1.id);
      expect(groupExists, true);
    });

    test('Deleting a group works correctly', () async {
      await database.groupDao.addGroup(group: testGroup1);

      final groupDeleted = await database.groupDao.deleteGroup(
        groupId: testGroup1.id,
      );
      expect(groupDeleted, true);

      final groupExists = await database.groupDao.groupExists(
        groupId: testGroup1.id,
      );
      expect(groupExists, false);
    });

    test('Updating a group name works correcly', () async {
      await database.groupDao.addGroup(group: testGroup1);

      const newGroupName = 'new group name';

      await database.groupDao.updateGroupName(
        groupId: testGroup1.id,
        newName: newGroupName,
      );

      final result = await database.groupDao.getGroupById(
        groupId: testGroup1.id,
      );
      expect(result.name, newGroupName);
    });

    test('Getting the group count works correctly', () async {
      final initialCount = await database.groupDao.getGroupCount();
      expect(initialCount, 0);

      await database.groupDao.addGroup(group: testGroup1);

      final groupAdded = await database.groupDao.getGroupCount();
      expect(groupAdded, 1);

      final groupRemoved = await database.groupDao.deleteGroup(
        groupId: testGroup1.id,
      );
      expect(groupRemoved, true);

      final finalCount = await database.groupDao.getGroupCount();
      expect(finalCount, 0);
    });

    test('getAllGroups returns empty list when no groups exist', () async {
      final allGroups = await database.groupDao.getAllGroups();
      expect(allGroups, isEmpty);
    });

    test('getGroupById throws exception for non-existent group', () async {
      expect(
        () => database.groupDao.getGroupById(groupId: 'non-existent-id'),
        throwsA(isA<StateError>()),
      );
    });

    test('addGroup returns false when group already exists', () async {
      final firstAdd = await database.groupDao.addGroup(group: testGroup1);
      expect(firstAdd, true);

      final secondAdd = await database.groupDao.addGroup(group: testGroup1);
      expect(secondAdd, false);

      final allGroups = await database.groupDao.getAllGroups();
      expect(allGroups.length, 1);
    });

    test('addGroupsAsList handles empty list correctly', () async {
      await database.groupDao.addGroupsAsList(groups: []);

      final allGroups = await database.groupDao.getAllGroups();
      expect(allGroups.length, 0);
    });

    test('deleteGroup returns false for non-existent group', () async {
      final deleted = await database.groupDao.deleteGroup(
        groupId: 'non-existent-id',
      );
      expect(deleted, false);
    });

    test('updateGroupName returns false for non-existent group', () async {
      final updated = await database.groupDao.updateGroupName(
        groupId: 'non-existent-id',
        newName: 'New Name',
      );
      expect(updated, false);
    });

    test('Updating a group description works correctly', () async {
      await database.groupDao.addGroup(group: testGroup1);

      const newDescription = 'This is a new description';

      final updated = await database.groupDao.updateGroupDescription(
        groupId: testGroup1.id,
        newDescription: newDescription,
      );
      expect(updated, true);

      final result = await database.groupDao.getGroupById(
        groupId: testGroup1.id,
      );
      expect(result.description, newDescription);
    });

    test('updateGroupDescription can set description to null', () async {
      final groupWithDescription = Group(
        name: 'Group with description',
        description: 'Initial description',
        members: [testPlayer1],
      );
      await database.groupDao.addGroup(group: groupWithDescription);

      final updated = await database.groupDao.updateGroupDescription(
        groupId: groupWithDescription.id,
        newDescription: null,
      );
      expect(updated, true);

      final result = await database.groupDao.getGroupById(
        groupId: groupWithDescription.id,
      );
      expect(result.description, isNull);
    });

    test('updateGroupDescription returns false for non-existent group',
        () async {
      final updated = await database.groupDao.updateGroupDescription(
        groupId: 'non-existent-id',
        newDescription: 'New Description',
      );
      expect(updated, false);
    });

    test('deleteAllGroups removes all groups', () async {
      await database.groupDao.addGroupsAsList(
        groups: [testGroup1, testGroup2],
      );

      final countBefore = await database.groupDao.getGroupCount();
      expect(countBefore, 2);

      final deleted = await database.groupDao.deleteAllGroups();
      expect(deleted, true);

      final countAfter = await database.groupDao.getGroupCount();
      expect(countAfter, 0);
    });

    test('deleteAllGroups returns false when no groups exist', () async {
      final deleted = await database.groupDao.deleteAllGroups();
      expect(deleted, false);
    });

    test('Group with special characters in name is stored correctly', () async {
      final specialGroup = Group(
        name: 'Group\'s & "Special" <Name>',
        description: 'Description with émojis 🎮🎲',
        members: [testPlayer1],
      );
      await database.groupDao.addGroup(group: specialGroup);

      final fetchedGroup = await database.groupDao.getGroupById(
        groupId: specialGroup.id,
      );
      expect(fetchedGroup.name, 'Group\'s & "Special" <Name>');
      expect(fetchedGroup.description, 'Description with émojis 🎮🎲');
    });

    test('Group with empty members list is stored correctly', () async {
      final emptyGroup = Group(
        name: 'Empty Group',
        members: [],
      );
      await database.groupDao.addGroup(group: emptyGroup);

      final fetchedGroup = await database.groupDao.getGroupById(
        groupId: emptyGroup.id,
      );
      expect(fetchedGroup.name, 'Empty Group');
      expect(fetchedGroup.members, isEmpty);
    });

    test('Multiple updates to the same group work correctly', () async {
      await database.groupDao.addGroup(group: testGroup1);

      await database.groupDao.updateGroupName(
        groupId: testGroup1.id,
        newName: 'Updated Name',
      );
      await database.groupDao.updateGroupDescription(
        groupId: testGroup1.id,
        newDescription: 'Updated Description',
      );

      final updatedGroup = await database.groupDao.getGroupById(
        groupId: testGroup1.id,
      );
      expect(updatedGroup.name, 'Updated Name');
      expect(updatedGroup.description, 'Updated Description');
      expect(updatedGroup.members.length, testGroup1.members.length);
    });

    test('addGroupsAsList with duplicate groups only adds once', () async {
      await database.groupDao.addGroupsAsList(
        groups: [testGroup1, testGroup1, testGroup1],
      );

      final allGroups = await database.groupDao.getAllGroups();
      expect(allGroups.length, 1);
    });
  });
}
