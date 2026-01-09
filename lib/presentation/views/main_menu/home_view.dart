import 'package:flutter/material.dart';
import 'package:game_tracker/core/constants.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/match.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:game_tracker/l10n/generated/app_localizations.dart';
import 'package:game_tracker/presentation/views/main_menu/match_view/match_result_view.dart';
import 'package:game_tracker/presentation/widgets/app_skeleton.dart';
import 'package:game_tracker/presentation/widgets/buttons/quick_create_button.dart';
import 'package:game_tracker/presentation/widgets/tiles/info_tile.dart';
import 'package:game_tracker/presentation/widgets/tiles/match_tile.dart';
import 'package:game_tracker/presentation/widgets/tiles/quick_info_tile.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isLoading = true;

  /// Amount of matches in the database
  int matchCount = 0;

  /// Amount of groups in the database
  int groupCount = 0;

  /// Loaded recent matches from the database
  List<Match> loadedRecentMatches = [];

  /// Recent matches to display, initially filled with skeleton matches
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
    loadHomeViewData();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
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
                      title: loc.matches,
                      icon: Icons.groups_rounded,
                      value: matchCount,
                    ),
                    SizedBox(width: constraints.maxWidth * 0.05),
                    QuickInfoTile(
                      width: constraints.maxWidth * 0.45,
                      height: constraints.maxHeight * 0.15,
                      title: loc.groups,
                      icon: Icons.groups_rounded,
                      value: groupCount,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: MatchTile(
                    width: constraints.maxWidth * 0.95,
                    match: recentMatches[0],
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) =>
                              MatchResultView(match: recentMatches[0]),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: MatchTile(
                    width: constraints.maxWidth * 0.95,
                    match: recentMatches[1],
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) =>
                              MatchResultView(match: recentMatches[1]),
                        ),
                      );
                    },
                  ),
                ),
                /*Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: InfoTile(
                    width: constraints.maxWidth * 0.95,
                    title: loc.recent_matches,
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
                            ).no_recent_matches_available,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MatchSummaryTile(
                              matchTitle: recentMatches[0].name,
                              game: 'Winner',
                              ruleset: 'Ruleset',
                              players: _getPlayerText(
                                recentMatches[0],
                                context,
                              ),
                              winner: recentMatches[0].winner == null
                                  ? AppLocalizations.of(
                                      context,
                                    ).match_in_progress
                                  : recentMatches[0].winner!.name,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Divider(),
                            ),
                            if (loadedRecentMatches.length > 1) ...[
                              MatchSummaryTile(
                                matchTitle: recentMatches[1].name,
                                game: 'Winner',
                                ruleset: 'Ruleset',
                                players: _getPlayerText(
                                  recentMatches[1],
                                  context,
                                ),
                                winner: recentMatches[1].winner == null
                                    ? AppLocalizations.of(
                                        context,
                                      ).match_in_progress
                                    : recentMatches[1].winner!.name,
                              ),
                              const SizedBox(height: 8),
                            ] else ...[
                              Center(
                                heightFactor: 5.35,
                                child: Text(
                                  AppLocalizations.of(
                                    context,
                                  ).no_second_match_available,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),*/
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InfoTile(
                    width: constraints.maxWidth * 0.95,
                    title: loc.quick_create,
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Loads the data for the HomeView from the database.
  /// This includes the match count, group count, and recent matches.
  void loadHomeViewData() {
    final db = Provider.of<AppDatabase>(context, listen: false);
    Future.wait([
      db.matchDao.getMatchCount(),
      db.groupDao.getGroupCount(),
      db.matchDao.getAllMatches(),
      Future.delayed(Constants.minimumSkeletonDuration),
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

  /// Generates a text representation of the players in the match.
  /// If the match has a group, it returns the group name and the number of additional players.
  /// If there is no group, it returns the count of players.
  String _getPlayerText(Match game, context) {
    final loc = AppLocalizations.of(context);
    if (game.group == null) {
      final playerCount = game.players?.length ?? 0;
      return loc.players_count(playerCount);
    }
    if (game.players == null || game.players!.isEmpty) {
      return game.group!.name;
    }
    return '${game.group!.name} + ${game.players!.length}';
  }
}
