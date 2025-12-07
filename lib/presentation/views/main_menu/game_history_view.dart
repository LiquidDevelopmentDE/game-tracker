import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/game.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:game_tracker/presentation/views/main_menu/create_group_view.dart';
import 'package:game_tracker/presentation/views/main_menu/game_result_view.dart';
import 'package:game_tracker/presentation/widgets/app_skeleton.dart';
import 'package:game_tracker/presentation/widgets/buttons/custom_width_button.dart';
import 'package:game_tracker/presentation/widgets/tiles/game_history_tile.dart';
import 'package:game_tracker/presentation/widgets/top_centered_message.dart';
import 'package:provider/provider.dart';

class GameHistoryView extends StatefulWidget {
  const GameHistoryView({super.key});

  @override
  State<GameHistoryView> createState() => _GameHistoryViewState();
}

class _GameHistoryViewState extends State<GameHistoryView> {
  late Future<List<Game>> _gameListFuture;
  late final AppDatabase db;

  late final List<Game> skeletonData = List.filled(
    4,
    Game(
      name: 'Skeleton Gamename',
      group: Group(
        name: 'Groupname',
        members: List.generate(5, (index) => Player(name: 'Player')),
      ),
      winner: Player(name: 'Player'),
      players: [Player(name: 'Player')],
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
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          FutureBuilder<List<Game>>(
            future: _gameListFuture,
            builder:
                (BuildContext context, AsyncSnapshot<List<Game>> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: TopCenteredMessage(
                        icon: Icons.report,
                        title: 'Error',
                        message: 'Game data could not be loaded',
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done &&
                      (!snapshot.hasData || snapshot.data!.isEmpty)) {
                    return const Center(
                      child: TopCenteredMessage(
                        icon: Icons.report,
                        title: 'Info',
                        message: 'No games created yet',
                      ),
                    );
                  }
                  final bool isLoading =
                      snapshot.connectionState == ConnectionState.waiting;
                  final List<Game> games =
                      (isLoading ? skeletonData : (snapshot.data ?? [])
                            ..sort(
                              (a, b) => b.createdAt.compareTo(a.createdAt),
                            ))
                          .toList();
                  return AppSkeleton(
                    enabled: isLoading,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 85),
                      itemCount: games.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == games.length) {
                          return SizedBox(
                            height: MediaQuery.paddingOf(context).bottom - 80,
                          );
                        }
                        return GameHistoryTile(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              CupertinoPageRoute(
                                fullscreenDialog: true,
                                builder: (context) =>
                                    GameResultView(game: games[index]),
                              ),
                            );
                            setState(() {
                              _gameListFuture = db.gameDao.getAllGames();
                            });
                          },
                          game: games[index],
                        );
                      },
                    ),
                  );
                },
          ),
          Positioned(
            bottom: MediaQuery.paddingOf(context).bottom,
            child: CustomWidthButton(
              text: 'Create Game',
              sizeRelativeToWidth: 0.90,
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const CreateGroupView();
                    },
                  ),
                );
                setState(() {
                  _gameListFuture = db.gameDao.getAllGames();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
