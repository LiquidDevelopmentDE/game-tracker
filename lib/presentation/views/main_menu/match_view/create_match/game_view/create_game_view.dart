import 'package:flutter/material.dart';
import 'package:game_tracker/core/adaptive_page_route.dart';
import 'package:game_tracker/core/constants.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/core/enums.dart';
import 'package:game_tracker/data/dto/game.dart';
import 'package:game_tracker/l10n/generated/app_localizations.dart';
import 'package:game_tracker/presentation/views/main_menu/match_view/create_match/game_view/choose_ruleset_view.dart';
import 'package:game_tracker/presentation/widgets/buttons/custom_width_button.dart';
import 'package:game_tracker/presentation/widgets/text_input/text_input_field.dart';
import 'package:game_tracker/presentation/widgets/tiles/choose_tile.dart';

class CreateGameView extends StatefulWidget {
  const CreateGameView({super.key, this.gameToEdit, required this.callback});

  final Game? gameToEdit;

  final VoidCallback callback;

  @override
  State<CreateGameView> createState() => _CreateGameViewState();
}

class _CreateGameViewState extends State<CreateGameView> {
  Ruleset? selectedRuleset;
  int selectedRulesetIndex = -1;
  late List<(Ruleset, String)> _rulesets;

  final _gameNameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _gameNameController.addListener(() => setState(() {}));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final loc = AppLocalizations.of(context);
    _rulesets = [
      (Ruleset.singleWinner, loc.ruleset_single_winner),
      (Ruleset.singleLoser, loc.ruleset_single_loser),
      (Ruleset.mostPoints, loc.ruleset_most_points),
      (Ruleset.leastPoints, loc.ruleset_least_points),
    ];

    if (widget.gameToEdit != null) {
      _gameNameController.text = widget.gameToEdit!.name;
      _descriptionController.text = widget.gameToEdit!.description ?? '';
      // TODO: Handle ruleset initialization from gameToEdit
    }
  }

  @override
  void dispose() {
    _gameNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context);
    final isEditing = widget.gameToEdit != null;

    return ScaffoldMessenger(
      child: Scaffold(
        backgroundColor: CustomTheme.backgroundColor,
        appBar: AppBar(
          title: Text(isEditing ? loc.edit_game : loc.create_game),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                margin: CustomTheme.tileMargin,
                child: TextInputField(
                  controller: _gameNameController,
                  maxLength: Constants.MAX_MATCH_NAME_LENGTH,
                  hintText: loc.game_name,
                ),
              ),
              ChooseTile(
                title: loc.ruleset,
                trailingText: selectedRuleset == null
                    ? loc.none
                    : translateRulesetToString(selectedRuleset!, context),
                onPressed: () async {
                  final result = await Navigator.of(context).push<Ruleset?>(
                    adaptivePageRoute(
                      builder: (context) => ChooseRulesetView(
                        rulesets: _rulesets,
                        initialRulesetIndex: selectedRulesetIndex,
                      ),
                    ),
                  );
                  if (mounted) {
                    setState(() {
                      selectedRuleset = result;
                      selectedRulesetIndex =
                          result == null ? -1 : _rulesets.indexWhere((r) => r.$1 == result);
                    });
                  }
                },
              ),
              Container(
                margin: CustomTheme.tileMargin,
                child: TextInputField(
                  controller: _descriptionController,
                  hintText: loc.description,
                  minLines: 6,
                  maxLines: 6,
                  maxLength: Constants.MAX_GAME_DESCRIPTION_LENGTH,
                  showCounterText: true,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CustomWidthButton(
                  text: isEditing ? loc.edit_group : loc.create_game,
                  sizeRelativeToWidth: 1,
                  buttonType: ButtonType.primary,
                  onPressed: _gameNameController.text.trim().isNotEmpty && selectedRulesetIndex != -1
                      ? () {
                          //TODO: Handle saving to db & updating game selection view
                          Navigator.of(context).pop();
                        }
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
