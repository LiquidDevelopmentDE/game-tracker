import 'package:flutter/material.dart';
import "package:game_tracker/core/custom_theme.dart";
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:game_tracker/presentation/views/main_menu/settings_subpages/theme_view.dart';
import 'package:game_tracker/presentation/views/main_menu/settings_subpages/language_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      appBar: AppBar(title: const Text('Einstellungen'), titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), centerTitle: true, backgroundColor: CustomTheme.backgroundColor),
      body: Column(
        children: [
          ListTile(
            title: Text("Design"),
            subtitle: Text("Dunkel"),
            leading: Icon(Icons.design_services),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ThemeView()));
            }
          ),
          ListTile(
            title: Text("Sprache"),
            subtitle: Text("Deutsch"),
            leading: Icon(Icons.language),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LanguageView()));
            }
          ),
          ListTile(
            title: Text("App Version"),
            leading: Icon(Icons.info),
            trailing: Icon(Icons.copy),
            subtitle: Text("1.0.0"),
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: "1.0.0"));
            }
          ),
          ListTile(
            title: Text("Fehler melden"),
            leading: Icon(Icons.error),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () async {
              await launchUrl(
                Uri.parse("https://github.com/LiquidDevelopmentDE/game-tracker/issues/new?type=bug",),
              );
            }
          ),
          ListTile(
            title: Text("Kontakt"),
            leading: Icon(Icons.email),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () async {
              await launchUrl(
                Uri.parse("mailto:leckeier@eierlecker.de?subject=Kontakt via Game Tracker App V1.0.0",),
              );
            }
          ),
          ListTile(
            title: Text("Alle Daten löschen"),
            leading: Icon(Icons.delete_forever),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Daten löschen"),
                  content: Text("Möchten Sie wirklich alle Daten löschen?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        // daten löschen
                        Navigator.of(context).pop();
                      },
                      child: Text("Ja"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Nein"),
                    ),
                  ],
                ),
              );
            },
          ),
          Spacer(flex: 7),
          Expanded(child: Text("Programmiert mit ❤️ von LIQUID Development"))
        ]
        ),
    );
  }
}
