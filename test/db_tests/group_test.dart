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
  });
  tearDown(() async {
    await database.close();
  });
  group('group tests', () {
    test('all groups get fetched correclty', () async {
      final testgroup2 = Group(
        id: 'gr2',
        name: 'Second Group',
        members: [player2, player3, player4],
      );
      await database.groupDao.addGroup(group: testgroup);
      await database.groupDao.addGroup(group: testgroup2);

      final allGroups = await database.groupDao.getAllGroups();
      expect(allGroups.length, 2);

      final fetchedGroup1 = allGroups.firstWhere((g) => g.id == testgroup.id);
      expect(fetchedGroup1.name, testgroup.name);
      expect(fetchedGroup1.members.length, testgroup.members.length);
      expect(fetchedGroup1.members.elementAt(0).id, player1.id);

      final fetchedGroup2 = allGroups.firstWhere((g) => g.id == testgroup2.id);
      expect(fetchedGroup2.name, testgroup2.name);
      expect(fetchedGroup2.members.length, testgroup2.members.length);
      expect(fetchedGroup2.members.elementAt(0).id, player2.id);
    });

    test('group and group members gets added correctly', () async {
      await database.groupDao.addGroup(group: testgroup);

      final result = await database.groupDao.getGroupById(
        groupId: testgroup.id,
      );

      expect(result.id, testgroup.id);
      expect(result.name, testgroup.name);

      expect(result.members.length, testgroup.members.length);
      for (int i = 0; i < testgroup.members.length; i++) {
        expect(result.members[i].id, testgroup.members[i].id);
        expect(result.members[i].name, testgroup.members[i].name);
      }
    });

    test('group gets deleted correctly', () async {
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

    test('group name gets updated correcly ', () async {
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

      final playerAdded2 = await database.playerGroupDao.isPlayerInGroup(
        playerId: 'a',
        groupId: testgroup.id,
      );

      expect(playerAdded2, false);

      expect(playerAdded, true);

      final result = await database.groupDao.getGroupById(
        groupId: testgroup.id,
      );
      expect(result.members.length, testgroup.members.length + 1);

      final addedPlayer = result.members.firstWhere((p) => p.id == player4.id);
      expect(addedPlayer.name, player4.name);
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

    test('get group count works correctly', () async {
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
