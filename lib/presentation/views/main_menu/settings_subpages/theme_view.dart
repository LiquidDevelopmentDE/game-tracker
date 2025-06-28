import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

class ThemeView extends StatefulWidget {
  const ThemeView({super.key});

  @override
  State<ThemeView> createState() => _ThemeViewState();
}

class _ThemeViewState extends State<ThemeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Design'), titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), centerTitle: true, backgroundColor: CustomTheme.backgroundColor),
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
            title: Text("Dunkel"),
            leading: Radio(
              value: Null,
              groupValue: Null, 
              onChanged: (value) {},
            ),
          ),
          ListTile(
            title: Text("Hell"),
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