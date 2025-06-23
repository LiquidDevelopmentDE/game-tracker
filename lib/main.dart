import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/presentation/views/main_menu/custom_navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game Tracker',
      darkTheme: ThemeData.dark(),

      themeMode: ThemeMode.dark, // forces light mode
      theme: ThemeData(
        primaryColor: CustomTheme.primaryColor,
        scaffoldBackgroundColor: CustomTheme.backgroundColor,
        appBarTheme: CustomTheme.appBarTheme,

        colorScheme: ColorScheme.fromSeed(
          seedColor: CustomTheme.primaryColor,
          brightness: Brightness.dark,
        ).copyWith(surface: CustomTheme.backgroundColor),
      ),

      home: const CustomNavigationBar(),
    );
  }
}
