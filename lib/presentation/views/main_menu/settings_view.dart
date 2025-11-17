import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/presentation/widgets/tiles/settings_list_tile.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

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
                      'Menü',
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
                      'Einstellungen',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SettingsListTile(
                    title: 'Export Data',
                    icon: Icons.upload_outlined,
                    suffixWidget: const Icon(Icons.arrow_forward_ios, size: 16),
                    onPressed: () => print('Export Data'),
                  ),
                  SettingsListTile(
                    title: 'Import Data',
                    icon: Icons.download_outlined,
                    suffixWidget: const Icon(Icons.arrow_forward_ios, size: 16),
                    onPressed: () => print('Import Data'),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    child: Text(
                      textAlign: TextAlign.start,
                      'Example Headline',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SettingsListTile(
                    title: 'Example Tile',
                    icon: Icons.upload_outlined,
                    suffixWidget: const Icon(Icons.arrow_forward_ios, size: 16),
                    onPressed: () => print('Example Tile'),
                  ),
                  SettingsListTile(
                    title: 'Example Tile',
                    icon: Icons.download_outlined,
                    suffixWidget: const Icon(Icons.arrow_forward_ios, size: 16),
                    onPressed: () => print('Example Tile'),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
