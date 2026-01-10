import 'dart:core' hide Match;
import 'package:flutter/material.dart';
import 'package:game_tracker/core/adaptive_page_route.dart';
import 'package:game_tracker/core/constants.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/match.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:game_tracker/l10n/generated/app_localizations.dart';
import 'package:game_tracker/presentation/views/main_menu/match_view/create_match/create_match_view.dart';
import 'package:game_tracker/presentation/views/main_menu/match_view/match_result_view.dart';
import 'package:game_tracker/presentation/widgets/app_skeleton.dart';
import 'package:game_tracker/presentation/widgets/buttons/custom_width_button.dart';
import 'package:game_tracker/presentation/widgets/tiles/match_tile.dart';
import 'package:game_tracker/presentation/widgets/top_centered_message.dart';
import 'package:provider/provider.dart';

class MatchView extends StatefulWidget {
  const MatchView({super.key});

  @override
  State<MatchView> createState() => _MatchViewState();
}

class _MatchViewState extends State<MatchView> {
  late final AppDatabase db;
  bool isLoading = true;

  /// Loaded matches from the database,
  /// initially filled with skeleton matches
  List<Match> matches = List.filled(
    4,
    Match(
      name: 'Skeleton match name',
      group: Group(
        name: 'Group name',
        members: List.filled(5, Player(name: 'Player')),
      ),
      winner: Player(name: 'Player'),
      players: [Player(name: 'Player')],
    ),
  );

  @override
  void initState() {
    super.initState();
    db = Provider.of<AppDatabase>(context, listen: false);
    loadGames();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          AppSkeleton(
            enabled: isLoading,
            child: Visibility(
              visible: matches.isNotEmpty,
              replacement: Center(
                child: TopCenteredMessage(
                  icon: Icons.report,
                  title: loc.info,
                  message: loc.no_matches_created_yet,
                ),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 85),
                itemCount: matches.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == matches.length) {
                    return SizedBox(
                      height: MediaQuery.paddingOf(context).bottom - 20,
                    );
                  }
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: MatchTile(
                        width: MediaQuery.sizeOf(context).width * 0.95,
                        onTap: () async {
                          Navigator.push(
                            context,
                            adaptivePageRoute(
                              fullscreenDialog: true,
                              builder: (context) => MatchResultView(
                                match: matches[index],
                                onWinnerChanged: loadGames,
                              ),
                            ),
                          );
                        },
                        match: matches[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.paddingOf(context).bottom,
            child: CustomWidthButton(
              text: loc.create_match,
              sizeRelativeToWidth: 0.90,
              onPressed: () async {
                Navigator.push(
                  context,
                  adaptivePageRoute(
                      builder: (context) =>
                          CreateMatchView(onWinnerChanged: loadGames))
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Loads the games from the database and sorts them by creation date.
  void loadGames() {
    Future.wait([
      db.matchDao.getAllMatches(),
      Future.delayed(Constants.minimumSkeletonDuration),
    ]).then((results) {
      if (mounted) {
        setState(() {
          final loadedMatches = results[0] as List<Match>;
          matches = loadedMatches
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
          isLoading = false;
        });
      }
    });
  }
}
