import 'package:flutter/material.dart';

class CustomTheme {
  static Color primaryColor = const Color(0xFF7505E4);
  static Color secondaryColor = const Color(0xFFAFA2FF);
  static Color backgroundColor = const Color(0xFF0B0B0B);
  static Color boxColor = const Color(0xFF101010);
  static Color onBoxColor = const Color(0xFF181818);
  static Color boxBorder = const Color(0xFF272727);

  static BoxDecoration standardBoxDecoration = BoxDecoration(
    color: boxColor,
    border: Border.all(color: boxBorder),
    borderRadius: BorderRadius.circular(12),
  );

  static BoxDecoration highlightedBoxDecoration = BoxDecoration(
    color: boxColor,
    border: Border.all(color: primaryColor),
    borderRadius: BorderRadius.circular(12),
    boxShadow: [BoxShadow(color: primaryColor.withAlpha(120), blurRadius: 12)],
  );

  static AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: backgroundColor,
    foregroundColor: Colors.white,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  );
}
