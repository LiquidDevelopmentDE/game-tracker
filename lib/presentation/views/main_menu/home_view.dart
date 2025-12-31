import 'package:flutter/material.dart';
import 'package:game_tracker/core/constants.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/match.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:game_tracker/l10n/generated/app_localizations.dart';
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
  List<Match> loadedRecentMatches = [];
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
      loadedRecentMatches = results[2] as List<Match>;
      recentMatches =
          (loadedRecentMatches
                ..sort((a, b) => b.createdAt.compareTo(a.createdAt)))
              .take(2)
              .toList();
      if (loadedRecentMatches.length < 2) {
        recentMatches.add(
          Match(name: 'Dummy Match', winner: null, group: null, players: null),
        );
      }
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
          fixLayoutBuilder: true,
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
                      title: AppLocalizations.of(context)!.matches,
                      icon: Icons.groups_rounded,
                      value: matchCount,
                    ),
                    SizedBox(width: constraints.maxWidth * 0.05),
                    QuickInfoTile(
                      width: constraints.maxWidth * 0.45,
                      height: constraints.maxHeight * 0.15,
                      title: AppLocalizations.of(context)!.groups,
                      icon: Icons.groups_rounded,
                      value: groupCount,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: InfoTile(
                    width: constraints.maxWidth * 0.95,
                    title: AppLocalizations.of(context)!.recent_matches,
                    icon: Icons.timer,
                    content: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Visibility(
                        visible: !isLoading && loadedRecentMatches.isNotEmpty,
                        replacement: Center(
                          heightFactor: 12,
                          child: Text(
                            AppLocalizations.of(
                              context,
                            )!.no_recent_matches_available,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MatchTile(
                              matchTitle: recentMatches[0].name,
                              game: AppLocalizations.of(context)!.winner_label,
                              ruleset: AppLocalizations.of(
                                context,
                              )!.ruleset_label,
                              players: _getPlayerText(recentMatches[0]),
                              winner: recentMatches[0].winner == null
                                  ? AppLocalizations.of(
                                      context,
                                    )!.match_in_progress
                                  : recentMatches[0].winner!.name,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Divider(),
                            ),
                            if (loadedRecentMatches.length > 1) ...[
                              MatchTile(
                                matchTitle: recentMatches[1].name,
                                game: AppLocalizations.of(
                                  context,
                                )!.winner_label,
                                ruleset: AppLocalizations.of(
                                  context,
                                )!.ruleset_label,
                                players: _getPlayerText(recentMatches[1]),
                                winner: recentMatches[1].winner == null
                                    ? AppLocalizations.of(
                                        context,
                                      )!.match_in_progress
                                    : recentMatches[1].winner!.name,
                              ),
                              const SizedBox(height: 8),
                            ] else ...[
                              Center(
                                heightFactor: 5.35,
                                child: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.no_second_match_available,
                                ),
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
                  title: AppLocalizations.of(context)!.quick_create,
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
      return AppLocalizations.of(context)!.players_count(playerCount);
    }
    if (game.players == null || game.players!.isEmpty) {
      return game.group!.name;
    }
    return '${game.group!.name} + ${game.players!.length}';
  }
}
