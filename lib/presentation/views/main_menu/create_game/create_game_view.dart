import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/core/enums.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/game.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/presentation/views/main_menu/create_game/choose_group_view.dart';
import 'package:game_tracker/presentation/views/main_menu/create_game/choose_ruleset_view.dart';
import 'package:game_tracker/presentation/widgets/buttons/custom_width_button.dart';
import 'package:game_tracker/presentation/widgets/text_input/text_input_field.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CreateGameView extends StatefulWidget {
  const CreateGameView({super.key});

  @override
  State<CreateGameView> createState() => _CreateGameViewState();
}

class _CreateGameViewState extends State<CreateGameView> {
  late final AppDatabase db;
  late Future<List<Group>> _allGroupsFuture;
  final TextEditingController _gameNameController = TextEditingController();

  /// List of all groups from the database
  late final List<Group> groupsList;

  /// The currently selected group
  Group? selectedGroup;

  /// The index of the currently selected group in [groupsList] to mark it in
  /// the [ChooseGroupView]
  int selectedGroupIndex = -1;

  /// The currently selected ruleset
  Ruleset? selectedRuleset;

  /// The index of the currently selected ruleset in [rulesets] to mark it in
  /// the [ChooseRulesetView]
  int selectedRulesetIndex = -1;

  bool isLoading = true;

  /// List of available rulesets with their display names and descriptions
  /// as tuples of (Ruleset, String, String)
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

  @override
  void initState() {
    super.initState();
    db = Provider.of<AppDatabase>(context, listen: false);

    _allGroupsFuture = db.groupDao.getAllGroups();

    Future.wait([_allGroupsFuture]).then((result) async {
      await Future.delayed(const Duration(milliseconds: 250));
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
        child: Skeletonizer(
          effect: PulseEffect(
            from: Colors.grey[800]!,
            to: Colors.grey[600]!,
            duration: const Duration(milliseconds: 800),
          ),
          enabled: isLoading,
          enableSwitchAnimation: true,
          switchAnimationConfig: const SwitchAnimationConfig(
            duration: Duration(milliseconds: 200),
            switchInCurve: Curves.linear,
            switchOutCurve: Curves.linear,
            transitionBuilder: AnimatedSwitcher.defaultTransitionBuilder,
            layoutBuilder: AnimatedSwitcher.defaultLayoutBuilder,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
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
                    vertical: 5,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  decoration: CustomTheme.standardBoxDecoration,
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
                      Text(
                        selectedRuleset == null
                            ? 'None'
                            : translateRulesetToString(selectedRuleset!),
                      ),
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
                    vertical: 5,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  decoration: CustomTheme.standardBoxDecoration,
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
                      Text(
                        selectedGroup == null ? 'None' : selectedGroup!.name,
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: CustomTheme.standardBoxDecoration,
                width: MediaQuery.of(context).size.width * 0.95,
                height: 400,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const Center(child: Text('PlayerComponent')),
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
                        // TODO: Replace with navigation to GameResultView()
                        print('Created game: $game');
                        Navigator.pop(context);
                      },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// Translates a [Ruleset] enum value to its corresponding string representation.
  String translateRulesetToString(Ruleset ruleset) {
    switch (ruleset) {
      case Ruleset.singleWinner:
        return 'Single Winner';
      case Ruleset.singleLoser:
        return 'Single Loser';
      case Ruleset.mostPoints:
        return 'Most Points';
      case Ruleset.lastPoints:
        return 'Least Points';
    }
  }
}
