import 'package:flutter/material.dart';
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
  late Future<int> _matchCountFuture;
  late Future<int> _groupCountFuture;
  late Future<List<Match>> _recentMatchesFuture;
  bool isLoading = true;

  late final List<Match> skeletonData = List.filled(
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
  initState() {
    super.initState();
    final db = Provider.of<AppDatabase>(context, listen: false);
    _matchCountFuture = db.matchDao.getMatchCount();
    _groupCountFuture = db.groupDao.getGroupCount();
    _recentMatchesFuture = db.matchDao.getAllMatches();

    Future.wait([
      _matchCountFuture,
      _groupCountFuture,
      _recentMatchesFuture,
    ]).then((_) async {
      await Future.delayed(const Duration(milliseconds: 250));
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
                    FutureBuilder<int>(
                      future: _matchCountFuture,
                      builder: (context, snapshot) {
                        final int count = (snapshot.hasData)
                            ? snapshot.data!
                            : 0;
                        return QuickInfoTile(
                          width: constraints.maxWidth * 0.45,
                          height: constraints.maxHeight * 0.15,
                          title: 'Matches',
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: InfoTile(
                    width: constraints.maxWidth * 0.95,
                    title: 'Recent Matches',
                    icon: Icons.timer,
                    content: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: FutureBuilder(
                        future: _recentMatchesFuture,
                        builder:
                            (
                              BuildContext context,
                              AsyncSnapshot<List<Match>> snapshot,
                            ) {
                              if (snapshot.hasError) {
                                return const Center(
                                  heightFactor: 4,
                                  child: Text(
                                    'Error while loading recent matches.',
                                  ),
                                );
                              }
                              final List<Match> matches =
                                  (isLoading
                                            ? skeletonData
                                            : (snapshot.data ?? [])
                                        ..sort(
                                          (a, b) => b.createdAt.compareTo(
                                            a.createdAt,
                                          ),
                                        ))
                                      .take(2)
                                      .toList();
                              if (matches.isNotEmpty) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MatchTile(
                                      matchTitle: matches[0].name,
                                      game: 'Winner',
                                      ruleset: 'Ruleset',
                                      players: _getPlayerText(matches[0]),
                                      winner: matches[0].winner == null
                                          ? 'Game in progress...'
                                          : matches[0].winner!.name,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8.0,
                                      ),
                                      child: Divider(),
                                    ),
                                    if (matches.length > 1) ...[
                                      MatchTile(
                                        matchTitle: matches[1].name,
                                        game: 'Winner',
                                        ruleset: 'Ruleset',
                                        players: _getPlayerText(matches[1]),
                                        winner: matches[1].winner == null
                                            ? 'Game in progress...'
                                            : matches[1].winner!.name,
                                      ),
                                      const SizedBox(height: 8),
                                    ] else ...[
                                      const Center(
                                        heightFactor: 4,
                                        child: Text(
                                          'No second game available.',
                                        ),
                                      ),
                                    ],
                                  ],
                                );
                              } else {
                                return const Center(
                                  heightFactor: 12,
                                  child: Text('No recent games available.'),
                                );
                              }
                            },
                      ),
                    ),
                  ),
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
