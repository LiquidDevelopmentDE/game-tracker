import 'package:flutter/material.dart';

class CustomTheme {
  static Color primaryColor = const Color(0xFF7505E4);
  static Color secondaryColor = const Color(0xFFAFA2FF);
  static Color backgroundColor = const Color(0xFF1A1A1A);

  static AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: backgroundColor,
    foregroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  );
}
