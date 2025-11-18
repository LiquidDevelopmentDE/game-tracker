import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/presentation/widgets/tiles/settings_list_tile.dart';
import 'package:game_tracker/services/data_transfer_service.dart';
import 'package:json_schema/json_schema.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();

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
                      final String json =
                          await DataTransferService.getAppDataAsJson(context);
                      await DataTransferService.exportData(
                        json,
                        'exported_data',
                      );
                    },
                  ),
                  SettingsListTile(
                    title: 'Import data',
                    icon: Icons.download_outlined,
                    suffixWidget: const Icon(Icons.arrow_forward_ios, size: 16),
                    onPressed: () => DataTransferService.importData(context),
                  ),
                  SettingsListTile(
                    title: 'Delete all data',
                    icon: Icons.download_outlined,
                    suffixWidget: const Icon(Icons.arrow_forward_ios, size: 16),
                    onPressed: () => DataTransferService.deleteAllData(context),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
