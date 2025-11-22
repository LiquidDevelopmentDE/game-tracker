import 'package:flutter/material.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/game.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:game_tracker/presentation/widgets/tiles/statistics_tile.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class StatisticsView extends StatefulWidget {
  const StatisticsView({super.key});

  @override
  State<StatisticsView> createState() => _StatisticsViewState();
}

class _StatisticsViewState extends State<StatisticsView> {
  late Future<List<Game>> _gamesFuture;
  late Future<List<Player>> _playersFuture;
  List<(String, int)> winCounts = List.filled(6, ('Skeleton Player', 5));
  List<(String, int)> gameCounts = List.filled(6, ('Skeleton Player', 5));

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    final db = Provider.of<AppDatabase>(context, listen: false);
    _gamesFuture = db.gameDao.getAllGames();
    _playersFuture = db.playerDao.getAllPlayers();

    Future.wait([_gamesFuture, _playersFuture]).then((results) async {
      await Future.delayed(const Duration(milliseconds: 500));
      final games = results[0] as List<Game>;
      final players = results[1] as List<Player>;
      winCounts = _calculateWinsForAllPlayers(games, players);
      gameCounts = _calculateGameAmountsForAllPlayers(games, players);
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Skeletonizer(
          effect: PulseEffect(
            from: Colors.grey[800]!,
            to: Colors.grey[600]!,
            duration: const Duration(milliseconds: 800),
          ),
          enabled: isLoading,
          enableSwitchAnimation: true,
          switchAnimationConfig: const SwitchAnimationConfig(
            duration: Duration(milliseconds: 200),
            switchInCurve: Curves.linear,
            switchOutCurve: Curves.linear,
            transitionBuilder: AnimatedSwitcher.defaultTransitionBuilder,
            layoutBuilder: AnimatedSwitcher.defaultLayoutBuilder,
          ),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: constraints.maxHeight * 0.01),
                  StatisticsTile(
                    icon: Icons.sports_score,
                    title: 'Wins per Player',
                    width: constraints.maxWidth * 0.95,
                    values: winCounts,
                    itemCount: 6,
                    barColor: Colors.blue,
                  ),
                  SizedBox(height: constraints.maxHeight * 0.02),
                  StatisticsTile(
                    icon: Icons.casino,
                    title: 'Games per Player',
                    width: constraints.maxWidth * 0.95,
                    values: gameCounts,
                    itemCount: 6,
                    barColor: Colors.green,
                  ),
                  SizedBox(height: MediaQuery.paddingOf(context).bottom),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Calculates the number of wins for each player
  /// and returns a sorted list of tuples (playerName, winCount)
  List<(String, int)> _calculateWinsForAllPlayers(
    List<Game> games,
    List<Player> players,
  ) {
    List<(String, int)> winCounts = [];

    // Getting the winners
    for (var game in games) {
      final winner = game.winner;
      print('Game: ${game.id}, Winner: $winner');
      if (winner != null && winner.isNotEmpty) {
        final index = winCounts.indexWhere((entry) => entry.$1 == winner);
        if (index != -1) {
          final current = winCounts[index].$2;
          winCounts[index] = (winner, current + 1);
        } else {
          winCounts.add((winner, 1));
        }
      }
    }

    // Adding all players with zero wins
    for (var player in players) {
      final index = winCounts.indexWhere((entry) => entry.$1 == player.id);
      if (index == -1) {
        winCounts.add((player.id, 0));
      }
    }

    // Replace player IDs with names
    for (int i = 0; i < winCounts.length; i++) {
      final playerId = winCounts[i].$1;
      final player = players.firstWhere(
        (p) => p.id == playerId,
        orElse: () => Player(id: playerId, name: 'N.a.'),
      );
      winCounts[i] = (player.name, winCounts[i].$2);
    }

    winCounts.sort((a, b) => b.$2.compareTo(a.$2));

    return winCounts;
  }

  /// Calculates the number of games played for each player
  /// and returns a sorted list of tuples (playerName, gameCount)
  List<(String, int)> _calculateGameAmountsForAllPlayers(
    List<Game> games,
    List<Player> players,
  ) {
    List<(String, int)> gameCounts = [];

    // Counting games for each player
    for (var game in games) {
      if (game.group != null) {
        final members = game.group!.members.map((p) => p.id).toList();
        for (var playerId in members) {
          final index = gameCounts.indexWhere((entry) => entry.$1 == playerId);
          if (index != -1) {
            final current = gameCounts[index].$2;
            gameCounts[index] = (playerId, current + 1);
          } else {
            gameCounts.add((playerId, 1));
          }
        }
      }
      if (game.players != null) {
        final members = game.players!.map((p) => p.id).toList();
        for (var playerId in members) {
          final index = gameCounts.indexWhere((entry) => entry.$1 == playerId);
          if (index != -1) {
            final current = gameCounts[index].$2;
            gameCounts[index] = (playerId, current + 1);
          } else {
            gameCounts.add((playerId, 1));
          }
        }
      }
    }

    // Adding all players with zero games
    for (var player in players) {
      final index = gameCounts.indexWhere((entry) => entry.$1 == player.id);
      if (index == -1) {
        gameCounts.add((player.id, 0));
      }
    }

    // Replace player IDs with names
    for (int i = 0; i < gameCounts.length; i++) {
      final playerId = gameCounts[i].$1;
      final player = players.firstWhere(
        (p) => p.id == playerId,
        orElse: () => Player(id: playerId, name: 'N.a.'),
      );
      gameCounts[i] = (player.name, gameCounts[i].$2);
    }

    gameCounts.sort((a, b) => b.$2.compareTo(a.$2));

    return gameCounts;
  }
}
