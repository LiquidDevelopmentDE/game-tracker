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
  late Group testgroup3;
  late Group testgroup4;
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
      testgroup3 = Group(
        id: 'gr2',
        name: 'Second Group',
        members: [player2, player4],
      );
      testgroup4 = Group(
        id: 'gr2',
        name: 'Second Group',
        members: [player1, player2, player3, player4],
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

    test('Adding and fetching multiple groups works correctly', () async {
      // TODO: Use upcoming addGroups() method
      await database.groupDao.addGroup(group: testgroup);
      await database.groupDao.addGroup(group: testgroup2);
      await database.groupDao.addGroup(group: testgroup3);
      await database.groupDao.addGroup(group: testgroup4);

      final allGroups = await database.groupDao.getAllGroups();
      expect(allGroups.length, 2);

      final testGroups = {testgroup.id: testgroup, testgroup2.id: testgroup2};

      for (final group in allGroups) {
        final expectedGroup = testGroups[group.id]!;

        expect(group.id, expectedGroup.id);
        expect(group.name, expectedGroup.name);
        expect(group.createdAt, expectedGroup.createdAt);

        expect(group.members.length, expectedGroup.members.length);
        for (int i = 0; i < expectedGroup.members.length; i++) {
          expect(group.members[i].id, expectedGroup.members[i].id);
          expect(group.members[i].name, expectedGroup.members[i].name);
          expect(
            group.members[i].createdAt,
            expectedGroup.members[i].createdAt,
          );
        }
      }
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
