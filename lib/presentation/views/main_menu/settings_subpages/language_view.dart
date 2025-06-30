import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  String _selectedLanguage = "Systemstandard";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sprache'), titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), centerTitle: true, backgroundColor: CustomTheme.backgroundColor),
      backgroundColor: CustomTheme.backgroundColor,
      body: Column(
        children: [
          ListTile(
            title: Text("Systemstandard"),
            onTap: () {
              setState(() {
                _selectedLanguage = "Systemstandard";
              });
            },
            leading: Radio(
              value: "Systemstandard",
              groupValue: _selectedLanguage, 
              onChanged: (value) {setState(() {
                _selectedLanguage = value.toString();
              });},
            ),
          ),
          ListTile(
            title: Text("Deutsch"),
            onTap: () {
              setState(() {
                _selectedLanguage = "Deutsch";
              });
            },
            leading: Radio(
              value: "Deutsch",
              groupValue: _selectedLanguage, 
              onChanged: (value) {setState(() {
                _selectedLanguage = value.toString();
              });},
            ),
          ),
          ListTile(
            title: Text("Englisch"),
            onTap: () {
              setState(() {
                _selectedLanguage = "Englisch";
              });
            },
            leading: Radio(
              value: "Englisch",
              groupValue: _selectedLanguage,
              onChanged: (value) {setState(() {
                _selectedLanguage = value.toString();
              });},
            ),
          )
        ],
      ),
    );
  }
}