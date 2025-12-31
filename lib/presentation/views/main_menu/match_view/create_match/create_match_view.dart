import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/core/enums.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/match.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:game_tracker/l10n/generated/app_localizations.dart';
import 'package:game_tracker/presentation/views/main_menu/match_view/create_match/choose_game_view.dart';
import 'package:game_tracker/presentation/views/main_menu/match_view/create_match/choose_group_view.dart';
import 'package:game_tracker/presentation/views/main_menu/match_view/create_match/choose_ruleset_view.dart';
import 'package:game_tracker/presentation/views/main_menu/match_view/match_result_view.dart';
import 'package:game_tracker/presentation/widgets/buttons/custom_width_button.dart';
import 'package:game_tracker/presentation/widgets/player_selection.dart';
import 'package:game_tracker/presentation/widgets/text_input/text_input_field.dart';
import 'package:game_tracker/presentation/widgets/tiles/choose_tile.dart';
import 'package:provider/provider.dart';

class CreateMatchView extends StatefulWidget {
  final VoidCallback? onWinnerChanged;
  const CreateMatchView({super.key, this.onWinnerChanged});

  @override
  State<CreateMatchView> createState() => _CreateMatchViewState();
}

class _CreateMatchViewState extends State<CreateMatchView> {
  /// Reference to the app database
  late final AppDatabase db;

  /// Controller for the match name input field
  final TextEditingController _matchNameController = TextEditingController();

  /// List of all groups from the database
  List<Group> groupsList = [];

  /// List of all players from the database
  List<Player> playerList = [];

  /// List of players filtered based on the selected group
  /// If a group is selected, this list contains all players from [playerList]
  /// who are not members of the selected group. If no group is selected,
  /// this list is identical to [playerList].
  List<Player> filteredPlayerList = [];

  /// The currently selected group
  Group? selectedGroup;

  /// The index of the currently selected group in [groupsList] to mark it in
  /// the [ChooseGroupView]
  String selectedGroupId = '';

  /// The currently selected ruleset
  Ruleset? selectedRuleset;

  /// The index of the currently selected ruleset in [rulesets] to mark it in
  /// the [ChooseRulesetView]
  int selectedRulesetIndex = -1;

  /// The index of the currently selected game in [games] to mark it in
  /// the [ChooseGameView]
  int selectedGameIndex = -1;

  /// The currently selected players
  List<Player>? selectedPlayers;

  @override
  void initState() {
    super.initState();
    _matchNameController.addListener(() {
      setState(() {});
    });

    db = Provider.of<AppDatabase>(context, listen: false);

    Future.wait([
      db.groupDao.getAllGroups(),
      db.playerDao.getAllPlayers(),
    ]).then((result) async {
      groupsList = result[0] as List<Group>;
      playerList = result[1] as List<Player>;
    });
    filteredPlayerList = List.from(playerList);
  }

  List<(Ruleset, String)> _getRulesets(BuildContext context) {
    return [
      (
        Ruleset.singleWinner,
        AppLocalizations.of(context)!.ruleset_single_winner_desc,
      ),
      (
        Ruleset.singleLoser,
        AppLocalizations.of(context)!.ruleset_single_loser_desc,
      ),
      (
        Ruleset.mostPoints,
        AppLocalizations.of(context)!.ruleset_most_points_desc,
      ),
      (
        Ruleset.leastPoints,
        AppLocalizations.of(context)!.ruleset_least_points_desc,
      ),
    ];
  }

  // TODO: Replace when games are implemented
  List<(String, String, Ruleset)> games = [
    ('Example Game 1', 'This is a description', Ruleset.leastPoints),
    ('Example Game 2', '', Ruleset.singleWinner),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: CustomTheme.backgroundColor,
        scrolledUnderElevation: 0,
        title: Text(
          AppLocalizations.of(context)!.create_new_match,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: TextInputField(
                controller: _matchNameController,
                hintText: AppLocalizations.of(context)!.match_name,
              ),
            ),
            ChooseTile(
              title: AppLocalizations.of(context)!.game,
              trailingText: selectedGameIndex == -1
                  ? AppLocalizations.of(context)!.none
                  : games[selectedGameIndex].$1,
              onPressed: () async {
                selectedGameIndex = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChooseGameView(
                      games: games,
                      initialGameIndex: selectedGameIndex,
                    ),
                  ),
                );
                setState(() {
                  if (selectedGameIndex != -1) {
                    selectedRuleset = games[selectedGameIndex].$3;
                    selectedRulesetIndex = _getRulesets(
                      context,
                    ).indexWhere((r) => r.$1 == selectedRuleset);
                  } else {
                    selectedRuleset = null;
                  }
                });
              },
            ),
            ChooseTile(
              title: AppLocalizations.of(context)!.ruleset,
              trailingText: selectedRuleset == null
                  ? AppLocalizations.of(context)!.none
                  : translateRulesetToString(selectedRuleset!, context),
              onPressed: () async {
                final rulesets = _getRulesets(context);
                selectedRuleset = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChooseRulesetView(
                      rulesets: rulesets,
                      initialRulesetIndex: selectedRulesetIndex,
                    ),
                  ),
                );
                if (!mounted) return;
                selectedRulesetIndex = rulesets.indexWhere(
                  (r) => r.$1 == selectedRuleset,
                );
                selectedGameIndex = -1;
                setState(() {});
              },
            ),
            ChooseTile(
              title: AppLocalizations.of(context)!.group,
              trailingText: selectedGroup == null
                  ? AppLocalizations.of(context)!.none
                  : selectedGroup!.name,
              onPressed: () async {
                selectedGroup = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChooseGroupView(
                      groups: groupsList,
                      initialGroupId: selectedGroupId,
                    ),
                  ),
                );
                selectedGroupId = selectedGroup?.id ?? '';
                if (selectedGroup != null) {
                  filteredPlayerList = playerList
                      .where(
                        (p) => !selectedGroup!.members.any((m) => m.id == p.id),
                      )
                      .toList();
                } else {
                  filteredPlayerList = List.from(playerList);
                }
                setState(() {});
              },
            ),
            Expanded(
              child: PlayerSelection(
                key: ValueKey(selectedGroup?.id ?? 'no_group'),
                initialSelectedPlayers: selectedPlayers ?? [],
                availablePlayers: filteredPlayerList,
                onChanged: (value) {
                  setState(() {
                    selectedPlayers = value;
                  });
                },
              ),
            ),
            CustomWidthButton(
              text: AppLocalizations.of(context)!.create_match,
              sizeRelativeToWidth: 0.95,
              buttonType: ButtonType.primary,
              onPressed: _enableCreateGameButton()
                  ? () async {
                      Match match = Match(
                        name: _matchNameController.text.trim(),
                        createdAt: DateTime.now(),
                        group: selectedGroup,
                        players: selectedPlayers,
                      );
                      await db.matchDao.addMatch(match: match);
                      if (context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => MatchResultView(
                              match: match,
                              onWinnerChanged: widget.onWinnerChanged,
                            ),
                          ),
                        );
                      }
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  /// Determines whether the "Create Game" button should be enabled based on
  /// the current state of the input fields.
  bool _enableCreateGameButton() {
    return _matchNameController.text.isNotEmpty &&
        (selectedGroup != null ||
            (selectedPlayers != null && selectedPlayers!.length > 1)) &&
        selectedRuleset != null;
  }
}
