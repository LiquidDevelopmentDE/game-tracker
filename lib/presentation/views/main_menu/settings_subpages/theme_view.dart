import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

class ThemeView extends StatefulWidget {
  const ThemeView({super.key});

  @override
  State<ThemeView> createState() => _ThemeViewState();
}

class _ThemeViewState extends State<ThemeView> {
  String _selectedTheme = "Systemstandard";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Design'), titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), centerTitle: true, backgroundColor: CustomTheme.backgroundColor),
      backgroundColor: CustomTheme.backgroundColor,
      body: Column(
        children: [
          ListTile(
            title: Text("Systemstandard"),
            onTap: () {
              setState(() {
                _selectedTheme = "Systemstandard";
              });
            },
            leading: Radio(
              value: "Systemstandard",
              groupValue: _selectedTheme, 
              onChanged: (value) {setState(() {
                _selectedTheme = value.toString();
              });},
            ),
          ),
          ListTile(
            title: Text("Dunkel"),
            onTap: () {
              setState(() {
                _selectedTheme = "Dunkel";
              });
            },
            leading: Radio(
              value: "Dunkel",
              groupValue: _selectedTheme, 
              onChanged: (value) {setState(() {
                _selectedTheme = value.toString();
              });},
            ),
          ),
          ListTile(
            title: Text("Hell"),
            onTap: () {
              setState(() {
                _selectedTheme = "Hell";
              });
            },
            leading: Radio(
              value: "Hell",
              groupValue: _selectedTheme,
              onChanged: (value) {setState(() {
                _selectedTheme = value.toString();
              });},
            ),
          )
        ],
      ),
    );
  }
}