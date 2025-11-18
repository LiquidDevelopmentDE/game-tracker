import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/game.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:game_tracker/presentation/widgets/tiles/settings_list_tile.dart';
import 'package:json_schema/json_schema.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();

  /// Helper method to read file content from either bytes or path
  static Future<String> _readFileContent(PlatformFile file) async {
    if (file.bytes != null) return utf8.decode(file.bytes!);
    if (file.path != null) return await File(file.path!).readAsString();

    throw Exception('Die Datei hat keinen lesbaren Inhalt');
  }

  static Future<bool> validateJsonSchema(String jsonString) async {
    final String schemaString;

    schemaString = await rootBundle.loadString('assets/schema.json');

    try {
      final schema = JsonSchema.create(json.decode(schemaString));
      final jsonData = json.decode(jsonString);
      final result = schema.validate(jsonData);

      if (result.isValid) {
        return true;
      }
      return false;
    } catch (e, stack) {
      print('[validateJsonSchema] $e');
      print(stack);
      return false;
    }
  }
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: CustomTheme.backgroundColor),
      backgroundColor: CustomTheme.backgroundColor,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(24, 0, 24, 10),
                    child: Text(
                      textAlign: TextAlign.start,
                      'Menu',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    child: Text(
                      textAlign: TextAlign.start,
                      'Settings',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SettingsListTile(
                    title: 'Export data',
                    icon: Icons.upload_outlined,
                    suffixWidget: const Icon(Icons.arrow_forward_ios, size: 16),
                    onPressed: () async {
                      final String json = await _getAppDataAsJson(context);
                      await exportData(json, 'export');
                    },
                  ),
                  SettingsListTile(
                    title: 'Import data',
                    icon: Icons.download_outlined,
                    suffixWidget: const Icon(Icons.arrow_forward_ios, size: 16),
                    onPressed: () => importData(context),
                  ),
                  SettingsListTile(
                    title: 'Delete all data',
                    icon: Icons.download_outlined,
                    suffixWidget: const Icon(Icons.arrow_forward_ios, size: 16),
                    onPressed: () => deleteAllData(context),
                  ),
                  SettingsListTile(
                    title: 'Add Sample Data',
                    icon: Icons.upload_outlined,
                    suffixWidget: const Icon(Icons.arrow_forward_ios, size: 16),
                    onPressed: () => addSampleData(context),
                  ),
                ],
              ),
            ),
      ),
    );
  }

  Future<void> deleteAllData(BuildContext context) async {
    final db = Provider.of<AppDatabase>(context, listen: false);
    await db.gameDao.deleteAllGames();
    await db.groupDao.deleteAllGroups();
    await db.playerDao.deleteAllPlayers();
    print('[deleteAllData] All data deleted');
  }

  Future<void> addSampleData(BuildContext context) async {
    final db = Provider.of<AppDatabase>(context, listen: false);

    final player1 = Player(name: 'Alice');
    final player2 = Player(name: 'Bob');
    final group = Group(name: 'Friends', members: [player1, player2]);
    final game = Game(name: 'Sample Game', group: group, winner: 'Alice');

    await db.playerDao.addPlayer(player: player1);
    await db.playerDao.addPlayer(player: player2);
    await db.groupDao.addGroup(group: group);
    await db.gameDao.addGame(game: game);
  }

  Future<String> _getAppDataAsJson(BuildContext context) async {
    final db = Provider.of<AppDatabase>(context, listen: false);
    final games = await db.gameDao.getAllGames();
    final groups = await db.groupDao.getAllGroups();
    final players = await db.playerDao.getAllPlayers();

    // Construct a JSON representation of the data
    final Map<String, dynamic> jsonMap = {
      'games': games.map((game) => game.toJson()).toList(),
      'groups': groups.map((group) => group.toJson()).toList(),
      'players': players.map((player) => player.toJson()).toList(),
    };

    return json.encode(jsonMap);
  }

  Future<bool> exportData(String jsonString, String fileName) async {
    try {
      final bytes = Uint8List.fromList(utf8.encode(jsonString));
      await FilePicker.platform.saveFile(
        fileName: '$fileName.json',
        bytes: bytes,
      );
      return true;
    } catch (e, stack) {
      print('[exportData] $e');
      print(stack);
      return false;
    }
  }

  Future<void> importData(BuildContext context) async {
    final db = Provider.of<AppDatabase>(context, listen: false);

    final path = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (path == null) {
      print('[importData] No file selected');
      return;
    }

    try {
      final jsonString = await SettingsView._readFileContent(path.files.single);

      // Checks if the JSON String is in the gameList format
      if (await SettingsView.validateJsonSchema(jsonString)) {
        final Map<String, dynamic> jsonData =
            json.decode(jsonString) as Map<String, dynamic>;
        print('[importData] : $jsonData');
        final List<dynamic>? gamesJson = jsonData['games'] as List<dynamic>?;
        final List<dynamic>? groupsJson = jsonData['groups'] as List<dynamic>?;
        final List<dynamic>? playersJson =
            jsonData['players'] as List<dynamic>?;

        final List<Game> importedGames =
            gamesJson
                ?.map((g) => Game.fromJson(g as Map<String, dynamic>))
                .toList() ??
            [];
        final List<Group> importedGroups =
            groupsJson
                ?.map((g) => Group.fromJson(g as Map<String, dynamic>))
                .toList() ??
            [];
        final List<Player> importedPlayers =
            playersJson
                ?.map((p) => Player.fromJson(p as Map<String, dynamic>))
                .toList() ??
            [];

        for (Player player in importedPlayers) {
          await db.playerDao.addPlayer(player: player);
        }

        for (Group group in importedGroups) {
          await db.groupDao.addGroup(group: group);
        }

        for (Game game in importedGames) {
          await db.gameDao.addGame(game: game);
        }
      } else {
        print('[importData] Invalid JSON schema');
        return;
      }
      print('[importData] Data imported successfully');
      return;
    } on FormatException catch (e, stack) {
      print('[importData] FormatException');
      print('[importData] $e');
      print(stack);
      return;
    } on Exception catch (e, stack) {
      print('[importData] Exception');
      print('[importData] $e');
      print(stack);
      return;
    }
  }
}
