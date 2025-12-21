import 'package:flutter/material.dart';
import 'package:game_tracker/core/constants.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/match.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:game_tracker/presentation/widgets/app_skeleton.dart';
import 'package:game_tracker/presentation/widgets/buttons/quick_create_button.dart';
import 'package:game_tracker/presentation/widgets/tiles/game_tile.dart';
import 'package:game_tracker/presentation/widgets/tiles/info_tile.dart';
import 'package:game_tracker/presentation/widgets/tiles/quick_info_tile.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isLoading = true;
  int matchCount = 0;
  int groupCount = 0;
  List<Match> recentMatches = List.filled(
    2,
    Match(
      name: 'Skeleton Match',
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
    final db = Provider.of<AppDatabase>(context, listen: false);

    Future.wait([
      db.matchDao.getMatchCount(),
      db.groupDao.getGroupCount(),
      db.matchDao.getAllMatches(),
      Future.delayed(minimumSkeletonDuration),
    ]).then((results) {
      matchCount = results[0] as int;
      groupCount = results[1] as int;
      recentMatches = results[2] as List<Match>;

      recentMatches =
          (recentMatches..sort((a, b) => b.createdAt.compareTo(a.createdAt)))
              .take(2)
              .toList();
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
        return AppSkeleton(
          enabled: isLoading,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    QuickInfoTile(
                      width: constraints.maxWidth * 0.45,
                      height: constraints.maxHeight * 0.15,
                      title: 'Matches',
                      icon: Icons.groups_rounded,
                      value: matchCount,
                    ),
                    SizedBox(width: constraints.maxWidth * 0.05),
                    QuickInfoTile(
                      width: constraints.maxWidth * 0.45,
                      height: constraints.maxHeight * 0.15,
                      title: 'Groups',
                      icon: Icons.groups_rounded,
                      value: groupCount,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: InfoTile(
                    width: constraints.maxWidth * 0.95,
                    title: 'Recent Matches',
                    icon: Icons.timer,
                    content: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Visibility(
                        visible: !isLoading,
                        replacement: const Center(
                          heightFactor: 12,
                          child: Text('No recent games available.'),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MatchTile(
                              matchTitle: recentMatches[0].name,
                              game: 'Winner',
                              ruleset: 'Ruleset',
                              players: _getPlayerText(recentMatches[0]),
                              winner: recentMatches[0].winner == null
                                  ? 'Match in progress...'
                                  : recentMatches[0].winner!.name,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Divider(),
                            ),
                            if (recentMatches.length > 1) ...[
                              MatchTile(
                                matchTitle: recentMatches[1].name,
                                game: 'Winner',
                                ruleset: 'Ruleset',
                                players: _getPlayerText(recentMatches[1]),
                                winner: recentMatches[1].winner == null
                                    ? 'Game in progress...'
                                    : recentMatches[1].winner!.name,
                              ),
                              const SizedBox(height: 8),
                            ] else ...[
                              const Center(
                                heightFactor: 4,
                                child: Text('No second game available.'),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                InfoTile(
                  width: constraints.maxWidth * 0.95,
                  title: 'Quick Create',
                  icon: Icons.add_box_rounded,
                  content: Column(
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

  String _getPlayerText(Match game) {
    if (game.group == null) {
      final playerCount = game.players?.length ?? 0;
      return '$playerCount Players';
    }
    if (game.players == null || game.players!.isEmpty) {
      return game.group!.name;
    }
    return '${game.group!.name} + ${game.players!.length}';
  }
}
