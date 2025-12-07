import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/core/enums.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/game.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:game_tracker/presentation/views/main_menu/create_game/choose_game_view.dart';
import 'package:game_tracker/presentation/views/main_menu/create_game/choose_group_view.dart';
import 'package:game_tracker/presentation/views/main_menu/create_game/choose_ruleset_view.dart';
import 'package:game_tracker/presentation/views/main_menu/game_result_view.dart';
import 'package:game_tracker/presentation/widgets/buttons/custom_width_button.dart';
import 'package:game_tracker/presentation/widgets/player_selection.dart';
import 'package:game_tracker/presentation/widgets/text_input/text_input_field.dart';
import 'package:game_tracker/presentation/widgets/tiles/choose_tile.dart';
import 'package:provider/provider.dart';

class CreateGameView extends StatefulWidget {
  const CreateGameView({super.key});

  @override
  State<CreateGameView> createState() => _CreateGameViewState();
}

class _CreateGameViewState extends State<CreateGameView> {
  /// Reference to the app database
  late final AppDatabase db;

  /// Futures to load all groups and players from the database
  late Future<List<Group>> _allGroupsFuture;

  /// Future to load all players from the database
  late Future<List<Player>> _allPlayersFuture;

  /// Controller for the game name input field
  final TextEditingController _gameNameController = TextEditingController();

  /// List of all groups from the database
  List<Group> groupsList = [];

  /// List of all players from the database
  List<Player> playerList = [];

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

  int selectedGameIndex = -1;

  /// The currently selected players
  List<Player>? selectedPlayers;

  /// List of available rulesets with their descriptions
  /// as tuples of (Ruleset, String)
  /// TODO: Replace when rulesets are implemented
  List<(Ruleset, String)> rulesets = [
    (
      Ruleset.singleWinner,
      'Exactly one winner is chosen; ties are resolved by a predefined tiebreaker.',
    ),
    (
      Ruleset.singleLoser,
      'Exactly one loser is determined; last place receives the penalty or consequence.',
    ),
    (
      Ruleset.mostPoints,
      'Traditional ruleset: the player with the most points wins.',
    ),
    (
      Ruleset.leastPoints,
      'Inverse scoring: the player with the fewest points wins.',
    ),
  ];

  // TODO: Replace when games are implemented
  List<(String, String, Ruleset)> games = [
    ('Example Game 1', 'This is a discription', Ruleset.leastPoints),
    ('Example Game 2', '', Ruleset.singleWinner),
  ];

  @override
  void initState() {
    super.initState();
    db = Provider.of<AppDatabase>(context, listen: false);

    _allGroupsFuture = db.groupDao.getAllGroups();
    _allPlayersFuture = db.playerDao.getAllPlayers();

    Future.wait([_allGroupsFuture, _allPlayersFuture]).then((result) async {
      groupsList = result[0] as List<Group>;
      playerList = result[1] as List<Player>;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: CustomTheme.backgroundColor,
        scrolledUnderElevation: 0,
        title: const Text(
          'Create new game',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                controller: _gameNameController,
                hintText: 'Game name',
              ),
            ),
            ChooseTile(
              title: 'Game',
              trailingText: selectedGameIndex == -1
                  ? 'None'
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
                    print('selectedGameIndex: $selectedGameIndex');
                    selectedRuleset = games[selectedGameIndex].$3;
                    selectedRulesetIndex = rulesets.indexWhere(
                      (r) => r.$1 == selectedRuleset,
                    );
                  } else {
                    selectedRuleset = null;
                  }
                });
              },
            ),
            ChooseTile(
              title: 'Ruleset',
              trailingText: selectedRuleset == null
                  ? 'None'
                  : translateRulesetToString(selectedRuleset!),
              onPressed: () async {
                selectedRuleset = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChooseRulesetView(
                      rulesets: rulesets,
                      initialRulesetIndex: selectedRulesetIndex,
                    ),
                  ),
                );
                selectedRulesetIndex = rulesets.indexWhere(
                  (r) => r.$1 == selectedRuleset,
                );
                selectedGameIndex = -1;
                setState(() {});
              },
            ),
            ChooseTile(
              title: 'Group',
              trailingText: selectedGroup == null
                  ? 'None'
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
                setState(() {});
              },
            ),
            Expanded(
              child: PlayerSelection(
                key: ValueKey(selectedGroup?.id ?? 'no_group'),
                initialSelectedPlayers: selectedPlayers ?? [],
                availablePlayers: selectedGroup == null
                    ? playerList
                    : playerList
                          .where(
                            (p) => !selectedGroup!.members.any(
                              (m) => m.id == p.id,
                            ),
                          )
                          .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPlayers = value;
                  });
                },
              ),
            ),
            CustomWidthButton(
              text: 'Create game',
              sizeRelativeToWidth: 0.95,
              buttonType: ButtonType.primary,
              onPressed: _enableCreateGameButton()
                  ? () async {
                      Game game = Game(
                        name: _gameNameController.text.trim(),
                        createdAt: DateTime.now(),
                        group: selectedGroup!,
                        players: selectedPlayers,
                      );
                      await db.gameDao.addGame(game: game);
                      if (context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => GameResultView(game: game),
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
    return _gameNameController.text.isNotEmpty &&
        (selectedGroup != null ||
            (selectedPlayers != null && selectedPlayers!.length > 1)) &&
        selectedRuleset != null;
  }
}
