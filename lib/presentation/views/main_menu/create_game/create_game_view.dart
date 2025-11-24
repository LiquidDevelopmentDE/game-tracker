import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/core/enums.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/game.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:game_tracker/presentation/views/main_menu/create_game/choose_group_view.dart';
import 'package:game_tracker/presentation/views/main_menu/create_game/choose_ruleset_view.dart';
import 'package:game_tracker/presentation/widgets/buttons/custom_width_button.dart';
import 'package:game_tracker/presentation/widgets/text_input_field.dart';
import 'package:provider/provider.dart';

class CreateGameView extends StatefulWidget {
  const CreateGameView({super.key});

  @override
  State<CreateGameView> createState() => _CreateGameViewState();
}

class _CreateGameViewState extends State<CreateGameView> {
  final TextEditingController _gameNameController = TextEditingController();
  late final AppDatabase db;
  late Future<List<Group>> _allGroupsFuture;

  late final List<Group> groupsList;

  Group? selectedGroup;
  int selectedGroupIndex = -1;
  Ruleset? selectedRuleset;
  int selectedRulesetIndex = -1;

  bool isLoading = true;

  List<(Ruleset, String, String)> rulesets = [
    (
      Ruleset.singleWinner,
      'Single Winner',
      'Exactly one winner is chosen; ties are resolved by a predefined tiebreaker.',
    ),
    (
      Ruleset.singleLoser,
      'Single Loser',
      'Exactly one loser is determined; last place receives the penalty or consequence.',
    ),
    (
      Ruleset.mostPoints,
      'Most Points',
      'Traditional ruleset: the player with the most points wins.',
    ),
    (
      Ruleset.lastPoints,
      'Least Points',
      'Inverse scoring: the player with the fewest points wins.',
    ),
  ];

  late final List<Player> skeletonData = List.filled(
    7,
    Player(name: 'Player 0'),
  );

  @override
  void initState() {
    super.initState();
    db = Provider.of<AppDatabase>(context, listen: false);

    _gameNameController.addListener(() {
      setState(() {});
    });

    _allGroupsFuture = db.groupDao.getAllGroups();

    Future.wait([_allGroupsFuture]).then((result) async {
      await Future.delayed(const Duration(milliseconds: 1000));
      groupsList = result[0];

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
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
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: TextInputField(
                controller: _gameNameController,
                hintText: 'Game name',
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            GestureDetector(
              onTap: () async {
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
                setState(() {});
              },
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  color: CustomTheme.boxColor,
                  border: Border.all(color: CustomTheme.boxBorder),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Text(
                      'Ruleset',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(selectedRuleset == null ? 'None' : 'Single Winner'),
                    const SizedBox(width: 10),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                selectedGroup = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChooseGroupView(
                      groups: groupsList,
                      initialGroupIndex: selectedGroupIndex,
                    ),
                  ),
                );
                selectedGroupIndex = groupsList.indexWhere(
                  (g) => g.id == selectedGroup?.id,
                );
                setState(() {});
              },
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  color: CustomTheme.boxColor,
                  border: Border.all(color: CustomTheme.boxBorder),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Text(
                      'Group',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(selectedGroup == null ? 'None' : selectedGroup!.name),
                    const SizedBox(width: 10),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),
            const Spacer(),
            CustomWidthButton(
              text: 'Create game',
              sizeRelativeToWidth: 0.95,
              buttonType: ButtonType.primary,
              onPressed:
                  (_gameNameController.text.isEmpty ||
                      selectedGroup == null ||
                      selectedRuleset == null)
                  ? null
                  : () async {
                      Game game = Game(
                        name: _gameNameController.text.trim(),
                        createdAt: DateTime.now(),
                        group: selectedGroup!,
                      );
                      print('Creating game: ${game.name}');
                    },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
