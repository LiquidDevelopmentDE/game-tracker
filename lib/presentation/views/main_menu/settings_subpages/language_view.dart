import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sprache'), titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), centerTitle: true, backgroundColor: CustomTheme.backgroundColor),
      backgroundColor: CustomTheme.backgroundColor,
      body: Column(
        children: [
          ListTile(
            title: Text("Systemstandard"),
            leading: Radio(
              value: Null,
              groupValue: Null, 
              onChanged: (value) {},
            ),
          ),
          ListTile(
            title: Text("Deutsch"),
            leading: Radio(
              value: Null,
              groupValue: Null, 
              onChanged: (value) {},
            ),
          ),
          ListTile(
            title: Text("Englisch"),
            leading: Radio(
              value: Null,
              groupValue: Null, 
              onChanged: (value) {},
            ),
          )
        ],
      ),
    );
  }
}