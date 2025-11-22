import 'package:flutter/material.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/game.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:game_tracker/presentation/widgets/buttons/quick_create_button.dart';
import 'package:game_tracker/presentation/widgets/tiles/game_tile.dart';
import 'package:game_tracker/presentation/widgets/tiles/info_tile.dart';
import 'package:game_tracker/presentation/widgets/tiles/quick_info_tile.dart';
import 'package:game_tracker/presentation/widgets/top_centered_message.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<int> _gameCountFuture;
  late Future<int> _groupCountFuture;
  late Future<List<Game>> _recentGamesFuture;
  bool isLoading = true;

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
      winner:
          "Winner ID", //TODO: Should be player object, but isnt yet, waiting for pr
    ),
  );

  @override
  initState() {
    super.initState();
    final db = Provider.of<AppDatabase>(context, listen: false);
    _gameCountFuture = db.gameDao.getGameCount();
    _groupCountFuture = db.groupDao.getGroupCount();
    _recentGamesFuture = db.gameDao.getAllGames();

    Future.wait([_gameCountFuture, _groupCountFuture, _recentGamesFuture]).then(
      (_) async {
        await Future.delayed(const Duration(milliseconds: 50));
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      },
    );
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
          switchAnimationConfig: SwitchAnimationConfig(
            duration: Duration(milliseconds: 200),
            switchInCurve: Curves.linear,
            switchOutCurve: Curves.linear,
            transitionBuilder: AnimatedSwitcher.defaultTransitionBuilder,
            layoutBuilder:
                (Widget? currentChild, List<Widget> previousChildren) {
                  return Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      ...previousChildren,
                      if (currentChild != null) currentChild,
                    ],
                  );
                },
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder<int>(
                      future: _gameCountFuture,
                      builder: (context, snapshot) {
                        final int count = (snapshot.hasData)
                            ? snapshot.data!
                            : 0;
                        return QuickInfoTile(
                          width: constraints.maxWidth * 0.45,
                          height: constraints.maxHeight * 0.15,
                          title: 'Games',
                          icon: Icons.groups_rounded,
                          value: count,
                        );
                      },
                    ),
                    SizedBox(width: constraints.maxWidth * 0.05),
                    FutureBuilder<int>(
                      future: _groupCountFuture,
                      builder: (context, snapshot) {
                        final int count =
                            (snapshot.connectionState == ConnectionState.done &&
                                snapshot.hasData)
                            ? snapshot.data!
                            : 0;
                        return QuickInfoTile(
                          width: constraints.maxWidth * 0.45,
                          height: constraints.maxHeight * 0.15,
                          title: 'Groups',
                          icon: Icons.groups_rounded,
                          value: count,
                        );
                      },
                    ),
                  ],
                ),
                FutureBuilder(
                  future: _recentGamesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: TopCenteredMessage(
                          icon: Icons.report,
                          title: 'Error',
                          message: 'Group data couldn\'t\nbe loaded.',
                        ),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done &&
                        (!snapshot.hasData || snapshot.data!.isEmpty)) {
                      return const Center(
                        child: TopCenteredMessage(
                          icon: Icons.info,
                          title: 'Info',
                          message: 'No games created yet.',
                        ),
                      );
                    }
                    final List<Game> games =
                        isLoading ? skeletonData : (snapshot.data ?? [])
                          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: InfoTile(
                        width: constraints.maxWidth * 0.95,
                        title: 'Recent Games',
                        icon: Icons.timer,
                        content: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GameTile(
                                gameTitle: games[0].name,
                                gameType: "Gametype",
                                ruleset: 'Ruleset',
                                players: _getPlayerText(games[0]),
                                winner:
                                    'Leonard', //TODO: Replace Winner with real Winner
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Divider(),
                              ),
                              GameTile(
                                gameTitle: games[1].name,
                                gameType: 'Gametype',
                                ruleset: 'Ruleset',
                                players: _getPlayerText(games[1]),
                                winner:
                                    'Lina', //TODO: Replace Winner with real Winner
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                InfoTile(
                  width: constraints.maxWidth * 0.95,
                  title: 'Quick Create',
                  icon: Icons.add_box_rounded,
                  content: Column(
                    spacing: 8,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          QuickCreateButton(
                            text: 'Category 1',
                            onPressed: () {},
                          ),
                          QuickCreateButton(
                            text: 'Category 2',
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          QuickCreateButton(
                            text: 'Category 3',
                            onPressed: () {},
                          ),
                          QuickCreateButton(
                            text: 'Category 4',
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          QuickCreateButton(
                            text: 'Category 5',
                            onPressed: () {},
                          ),
                          QuickCreateButton(
                            text: 'Category 6',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getPlayerText(Game game) {
    if (game.group == null) {
      return game.players?.map((p) => p.name).join(', ') ?? 'No Players';
    }
    if (game.players == null || game.players!.isEmpty) {
      return game.group!.name;
    }
    return '${game.group!.name} + ${game.players!.length}';
  }
}
