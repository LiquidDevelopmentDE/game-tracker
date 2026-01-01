import 'dart:core' hide Match;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_tracker/core/constants.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/match.dart';
import 'package:game_tracker/data/dto/player.dart';
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
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          AppSkeleton(
            enabled: isLoading,
            child: Visibility(
              visible: matches.isNotEmpty,
              replacement: const Center(
                child: TopCenteredMessage(
                  icon: Icons.report,
                  title: 'Info',
                  message: 'No games created yet',
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
                  return MatchTile(
                    onTap: () async {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => MatchResultView(
                            match: matches[index],
                            onWinnerChanged: loadGames,
                          ),
                        ),
                      );
                    },
                    match: matches[index],
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.paddingOf(context).bottom,
            child: CustomWidthButton(
              text: 'Create Match',
              sizeRelativeToWidth: 0.90,
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CreateMatchView(onWinnerChanged: loadGames),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void loadGames() {
    Future.wait([
      db.matchDao.getAllMatches(),
      Future.delayed(minimumSkeletonDuration),
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
