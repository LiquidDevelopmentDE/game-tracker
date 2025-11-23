import 'package:flutter/material.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/game.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:game_tracker/presentation/widgets/tiles/game_history_tile.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class GameHistoryView extends StatefulWidget {
  const GameHistoryView({super.key});

  @override
  State<GameHistoryView> createState() => _GameHistoryViewState();
}

class _GameHistoryViewState extends State<GameHistoryView> {
  late Future<List<Game>> _gameListFuture;
  late final AppDatabase db;

  late final List<Game> skeletonData = List.filled(
    2,
    Game(
      name: 'Skeleton Game',
      group: Group(
        name: 'Skeleton Group',
        members: [
          Player(name: 'Skeleton Player 1'),
          Player(name: 'Skeleton Player 2'),
        ],
      ),
      winner: Player(name: 'Skeleton Player 1'),
    ),
  );

  @override
  void initState() {
    super.initState();
    db = Provider.of<AppDatabase>(context, listen: false);
    _gameListFuture = Future.delayed(
      const Duration(milliseconds: 250),
          () => db.gameDao.getAllGames(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Game>>(
      future: _gameListFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Game>> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            heightFactor: 4,
            child: Text(
              'Error while loading recent games.',
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done &&
            (!snapshot.hasData || snapshot.data!.isEmpty)) {
          return const Center(
            heightFactor: 4,
            child: Text('No recent games available.'),
          );
        }

        final bool isLoading = snapshot.connectionState == ConnectionState.waiting;
        final List<Game> games = (isLoading
            ? skeletonData
            : (snapshot.data ?? [])
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt)))
            .take(2)
            .toList();

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
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 85),
            itemCount: games.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == games.length) {
                return SizedBox(
                  height: MediaQuery.paddingOf(context).bottom - 20,
                );
              }
              return GameHistoryTile(game: games[index]);
            },
          ),
        );
      },
    );
  }
}