import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/game.dart';
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
    dbCheck(context);

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

  Future<void> dbCheck(BuildContext context) async {
    Player player1 = Player(id: 'p1', name: 'Alice');
    Player player2 = Player(id: 'p2', name: 'Bob');
    Player player3 = Player(id: 'p3', name: 'Charlie');
    Player player4 = Player(id: 'p4', name: 'Diana');
    Group testgroup = Group(
      id: 'gr1',
      name: 'Test Group',
      members: [player1, player2, player3],
    );
    Game testgame = Game(
      id: 'ga1',
      name: 'Test Game',
      winner: player1.id,
      players: [player4],
      group: testgroup,
    );

    final db = Provider.of<AppDatabase>(context, listen: false);
    //await db.gameDao.addGame(game: testgame);
    print('Game added: ${testgame.name}');
    final game = await db.gameDao.getGameById(gameId: testgame.id);
    print(game.toString());
  }
}
