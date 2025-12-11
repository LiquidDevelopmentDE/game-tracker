import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_tracker/core/enums.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/match.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:json_schema/json_schema.dart';
import 'package:provider/provider.dart';

class DataTransferService {
  /// Deletes all data from the database.
  static Future<void> deleteAllData(BuildContext context) async {
    final db = Provider.of<AppDatabase>(context, listen: false);
    await db.matchDao.deleteAllMatches();
    await db.groupDao.deleteAllGroups();
    await db.playerDao.deleteAllPlayers();
  }

  /// Retrieves all application data and converts it to a JSON string.
  /// Returns the JSON string representation of the data.
  static Future<String> getAppDataAsJson(BuildContext context) async {
    final db = Provider.of<AppDatabase>(context, listen: false);
    final matches = await db.matchDao.getAllMatches();
    final groups = await db.groupDao.getAllGroups();
    final players = await db.playerDao.getAllPlayers();

    // Construct a JSON representation of the data
    final Map<String, dynamic> jsonMap = {
      'matches': matches.map((match) => match.toJson()).toList(),
      'groups': groups.map((group) => group.toJson()).toList(),
      'players': players.map((player) => player.toJson()).toList(),
    };

    return json.encode(jsonMap);
  }

  /// Exports the given JSON string to a file with the specified name.
  /// Returns an [ExportResult] indicating the outcome.
  ///
  /// [jsonString] The JSON string to be exported.
  /// [fileName] The desired name for the exported file (without extension).
  static Future<ExportResult> exportData(
    String jsonString,
    String fileName,
  ) async {
    try {
      final bytes = Uint8List.fromList(utf8.encode(jsonString));
      final path = await FilePicker.platform.saveFile(
        fileName: '$fileName.json',
        bytes: bytes,
      );
      if (path == null) {
        return ExportResult.canceled;
      } else {
        return ExportResult.success;
      }
    } catch (e, stack) {
      print('[exportData] $e');
      print(stack);
      return ExportResult.unknownException;
    }
  }

  /// Imports data from a selected JSON file into the database.
  static Future<ImportResult> importData(BuildContext context) async {
    final db = Provider.of<AppDatabase>(context, listen: false);

    final path = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (path == null) {
      return ImportResult.canceled;
    }

    try {
      final jsonString = await _readFileContent(path.files.single);
      if (jsonString == null) {
        return ImportResult.fileReadError;
      }

      if (await _validateJsonSchema(jsonString)) {
        final Map<String, dynamic> jsonData =
            json.decode(jsonString) as Map<String, dynamic>;

        final List<dynamic>? matchesJson =
            jsonData['matches'] as List<dynamic>?;
        final List<dynamic>? groupsJson = jsonData['groups'] as List<dynamic>?;
        final List<dynamic>? playersJson =
            jsonData['players'] as List<dynamic>?;

        final List<Match> importedMatches =
            matchesJson
                ?.map((g) => Match.fromJson(g as Map<String, dynamic>))
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

        await db.playerDao.addPlayersAsList(players: importedPlayers);
        await db.groupDao.addGroupsAsList(groups: importedGroups);
        await db.matchDao.addMatchAsList(matches: importedMatches);
      } else {
        return ImportResult.invalidSchema;
      }
      return ImportResult.success;
    } on FormatException catch (e, stack) {
      print('[importData] FormatException');
      print('[importData] $e');
      print(stack);
      return ImportResult.formatException;
    } on Exception catch (e, stack) {
      print('[importData] Exception');
      print('[importData] $e');
      print(stack);
      return ImportResult.unknownException;
    }
  }

  /// Helper method to read file content from either bytes or path
  static Future<String?> _readFileContent(PlatformFile file) async {
    if (file.bytes != null) return utf8.decode(file.bytes!);
    if (file.path != null) return await File(file.path!).readAsString();
    return null;
  }

  /// Validates the given JSON string against the predefined schema.
  static Future<bool> _validateJsonSchema(String jsonString) async {
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
