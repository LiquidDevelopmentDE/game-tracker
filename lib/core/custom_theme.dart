import 'package:flutter/material.dart';

class CustomTheme {
  CustomTheme._(); // Private constructor to prevent instantiation

  // ==================== Colors ====================
  static Color primaryColor = const Color(0xFF7505E4);
  static Color secondaryColor = const Color(0xFFAFA2FF);
  static Color backgroundColor = const Color(0xFF0B0B0B);
  static Color boxColor = const Color(0xFF101010);
  static Color onBoxColor = const Color(0xFF181818);
  static Color boxBorder = const Color(0xFF272727);
  static const Color textColor = Colors.white;
  static Color navBarItemSelectedColor = primaryColor.withGreen(100);
  static Color navBarItemUnselectedColor = Colors.grey.shade400;

  // ==================== Border Radius ====================
  static const double standardBorderRadius = 12.0;
  static BorderRadius get standardBorderRadiusAll =>
      BorderRadius.circular(standardBorderRadius);

  // ==================== Padding & Margins ====================
  static const EdgeInsets standardMargin = EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 10,
  );
  static const EdgeInsets tileMargin = EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 5,
  );

  // ==================== Decorations ====================
  static BoxDecoration standardBoxDecoration = BoxDecoration(
    color: boxColor,
    border: Border.all(color: boxBorder),
    borderRadius: standardBorderRadiusAll,
  );

  static BoxDecoration highlightedBoxDecoration = BoxDecoration(
    color: boxColor,
    border: Border.all(color: primaryColor),
    borderRadius: standardBorderRadiusAll,
    boxShadow: [BoxShadow(color: primaryColor.withAlpha(120), blurRadius: 12)],
  );

  // ==================== App Bar Theme ====================
  static AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: backgroundColor,
    foregroundColor: textColor,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    titleTextStyle: const TextStyle(
      color: textColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
    ),
    iconTheme: const IconThemeData(color: textColor),
  );
}
