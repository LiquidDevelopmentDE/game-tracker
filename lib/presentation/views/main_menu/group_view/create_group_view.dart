import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/core/enums.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:game_tracker/l10n/generated/app_localizations.dart';
import 'package:game_tracker/presentation/widgets/buttons/custom_width_button.dart';
import 'package:game_tracker/presentation/widgets/player_selection.dart';
import 'package:game_tracker/presentation/widgets/text_input/text_input_field.dart';
import 'package:provider/provider.dart';

class CreateGroupView extends StatefulWidget {
  const CreateGroupView({super.key});

  @override
  State<CreateGroupView> createState() => _CreateGroupViewState();
}

class _CreateGroupViewState extends State<CreateGroupView> {
  late final AppDatabase db;

  /// Controller for the group name input field
  final _groupNameController = TextEditingController();

  /// List of currently selected players
  List<Player> selectedPlayers = [];

  @override
  void initState() {
    super.initState();
    db = Provider.of<AppDatabase>(context, listen: false);
    _groupNameController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: CustomTheme.backgroundColor,
        scrolledUnderElevation: 0,
        title: Text(
          loc.create_new_group,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                controller: _groupNameController,
                hintText: loc.group_name,
              ),
            ),
            Expanded(
              child: PlayerSelection(
                onChanged: (value) {
                  setState(() {
                    selectedPlayers = [...value];
                  });
                },
              ),
            ),
            CustomWidthButton(
              text: loc.create_group,
              sizeRelativeToWidth: 0.95,
              buttonType: ButtonType.primary,
              onPressed:
                  (_groupNameController.text.isEmpty ||
                      (selectedPlayers.length < 2))
                  ? null
                  : () async {
                      bool success = await db.groupDao.addGroup(
                        group: Group(
                          name: _groupNameController.text.trim(),
                          members: selectedPlayers,
                        ),
                      );
                      if (!context.mounted) return;
                      if (success) {
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: CustomTheme.boxColor,
                            content: Center(
                              child: Text(
                                AppLocalizations.of(
                                  context,
                                ).error_creating_group,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      }
                    },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
