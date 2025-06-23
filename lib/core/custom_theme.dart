import 'package:flutter/material.dart';

class CustomTheme {
  static Color primaryColor = const Color(0xFF71C0BB);
  static Color secondaryColor = const Color(0xFF2A4759);
  static Color backgroundColor = const Color(0xFF1A1A1A);

  static AppBarTheme appBarTheme = const AppBarTheme(
    backgroundColor: Color(0xFF1A1A1A),
    foregroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  );
}
