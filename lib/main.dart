import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:game_tracker/presentation/views/main_menu/custom_navigation_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    Provider<AppDatabase>(
      create: (context) => AppDatabase(),
      child: const GameTracker(),
      dispose: (context, db) => db.close(),
    ),
  );
}

class GameTracker extends StatelessWidget {
  const GameTracker({super.key});

  @override
  Widget build(BuildContext context) {
    addSampleGroupData(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game Tracker',
      darkTheme: ThemeData.dark(),

      themeMode: ThemeMode.dark, // forces dark mode
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

  Future<void> addSampleGroupData(BuildContext context) async {
    final db = Provider.of<AppDatabase>(context, listen: false);
    if (await db.groupDao.getGroupCount() == 0) {
      final List<Player> allPlayers = [
        Player(id: '1', name: 'Alex'),
        Player(id: '2', name: 'Ben'),
        Player(id: '3', name: 'Chris'),
        Player(id: '4', name: 'Daniel'),
        Player(id: '5', name: 'Max Mustermann'),
        Player(id: '6', name: 'Sebastian'),
        Player(id: '7', name: 'Jonathan'),
        Player(id: '8', name: 'Alexander'),
      ];

      // 2. Erstelle und füge 8 Gruppen mit unterschiedlicher Spieleranzahl hinzu
      await db.groupDao.addGroup(
        group: Group(
          id: '1',
          name: 'Anfänger',
          members: allPlayers.sublist(0, 3),
        ),
      ); // 3 Spieler
      await db.groupDao.addGroup(
        group: Group(
          id: '2',
          name: 'Die glorreichen Sieben',
          members: allPlayers.sublist(0, 7),
        ),
      ); // 7 Spieler
      await db.groupDao.addGroup(
        group: Group(
          id: '3',
          name: 'Profis',
          members: allPlayers.sublist(4, 8),
        ),
      ); // 4 Spieler
      await db.groupDao.addGroup(
        group: Group(
          id: '4',
          name: 'Duo Infernale',
          members: [allPlayers[0], allPlayers[7]],
        ),
      ); // 2 Spieler
      await db.groupDao.addGroup(
        group: Group(
          id: '5',
          name: 'Die fantastischen Fünf',
          members: allPlayers.sublist(1, 6),
        ),
      ); // 5 Spieler
      await db.groupDao.addGroup(
        group: Group(
          id: '6',
          name: 'Feierabend-Zocker',
          members: allPlayers.sublist(0, 6),
        ),
      ); // 6 Spieler
      await db.groupDao.addGroup(
        group: Group(id: '7', name: 'Alle Mann an Bord!', members: allPlayers),
      ); // 8 Spieler
      await db.groupDao.addGroup(
        group: Group(
          id: '8',
          name: 'Testgruppe Alpha',
          members: [allPlayers[1], allPlayers[3]],
        ),
      );
    }
  }
}
