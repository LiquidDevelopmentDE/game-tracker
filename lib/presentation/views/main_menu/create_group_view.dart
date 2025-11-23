import 'package:flutter/material.dart' hide ButtonStyle;
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/core/enums.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:game_tracker/presentation/widgets/buttons/custom_width_button.dart';
import 'package:game_tracker/presentation/widgets/custom_search_bar.dart';
import 'package:game_tracker/presentation/widgets/text_input_field.dart';
import 'package:game_tracker/presentation/widgets/tiles/text_icon_list_tile.dart';
import 'package:game_tracker/presentation/widgets/tiles/text_icon_tile.dart';
import 'package:game_tracker/presentation/widgets/top_centered_message.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CreateGroupView extends StatefulWidget {
  const CreateGroupView({super.key});

  @override
  State<CreateGroupView> createState() => _CreateGroupViewState();
}

class _CreateGroupViewState extends State<CreateGroupView> {
  List<Player> selectedPlayers = [];
  List<Player> suggestedPlayers = [];
  List<Player> allPlayers = [];
  late final AppDatabase db;
  late Future<List<Player>> _allPlayersFuture;
  late final List<Player> skeletonData = List.filled(
    7,
    Player(name: 'Player 0'),
  );
  final _groupNameController = TextEditingController();
  final _searchBarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    db = Provider.of<AppDatabase>(context, listen: false);
    _searchBarController.addListener(() {
      setState(() {});
    });
    _groupNameController.addListener(() {
      setState(() {});
    });
    loadPlayerList();
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    _searchBarController.dispose();
    super.dispose();
  }

  void loadPlayerList() {
    _allPlayersFuture = Future.delayed(
      const Duration(milliseconds: 250),
      () => db.playerDao.getAllPlayers(),
    );
    suggestedPlayers = skeletonData;
    _allPlayersFuture.then((loadedPlayers) {
      setState(() {
        loadedPlayers.sort((a, b) => a.name.compareTo(b.name));
        allPlayers = [...loadedPlayers];
        suggestedPlayers = [...loadedPlayers];
      });
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
          'Create new group',
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
                controller: _groupNameController,
                hintText: 'Group name',
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: CustomTheme.boxColor,
                  border: Border.all(color: CustomTheme.boxBorder),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSearchBar(
                      controller: _searchBarController,
                      constraints: const BoxConstraints(
                        maxHeight: 45,
                        minHeight: 45,
                      ),
                      hintText: 'Search for players',
                      trailingButtonShown: true,
                      trailingButtonicon: Icons.add_circle,
                      trailingButtonEnabled: _searchBarController.text
                          .trim()
                          .isNotEmpty,
                      onTrailingButtonPressed: () async {
                        addNewPlayerFromSearch(context: context);
                      },
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty) {
                            suggestedPlayers = allPlayers.where((player) {
                              return !selectedPlayers.contains(player);
                            }).toList();
                          } else {
                            suggestedPlayers = allPlayers.where((player) {
                              final bool nameMatches = player.name
                                  .toLowerCase()
                                  .contains(value.toLowerCase());
                              final bool isNotSelected = !selectedPlayers
                                  .contains(player);
                              return nameMatches && isNotSelected;
                            }).toList();
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Ausgewählte Spieler: (${selectedPlayers.length})',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: <Widget>[
                        for (var player in selectedPlayers)
                          TextIconTile(
                            text: player.name,
                            onIconTap: () {
                              setState(() {
                                final currentSearch = _searchBarController.text
                                    .toLowerCase();
                                selectedPlayers.remove(player);
                                if (currentSearch.isEmpty ||
                                    player.name.toLowerCase().contains(
                                      currentSearch,
                                    )) {
                                  suggestedPlayers.add(player);
                                  suggestedPlayers.sort(
                                    (a, b) => a.name.compareTo(b.name),
                                  );
                                }
                              });
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Alle Spieler:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    FutureBuilder(
                      future: _allPlayersFuture,
                      builder:
                          (
                            BuildContext context,
                            AsyncSnapshot<List<Player>> snapshot,
                          ) {
                            if (snapshot.hasError) {
                              return const Center(
                                child: TopCenteredMessage(
                                  icon: Icons.report,
                                  title: 'Error',
                                  message: 'Player data couldn\'t\nbe loaded.',
                                ),
                              );
                            }
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                (!snapshot.hasData ||
                                    snapshot.data!.isEmpty ||
                                    (selectedPlayers.isEmpty &&
                                        allPlayers.isEmpty))) {
                              return const Center(
                                child: TopCenteredMessage(
                                  icon: Icons.info,
                                  title: 'Info',
                                  message: 'No players created yet.',
                                ),
                              );
                            }
                            final bool isLoading =
                                snapshot.connectionState ==
                                ConnectionState.waiting;
                            return Expanded(
                              child: Skeletonizer(
                                effect: PulseEffect(
                                  from: Colors.grey[800]!,
                                  to: Colors.grey[600]!,
                                  duration: const Duration(milliseconds: 800),
                                ),
                                enabled: isLoading,
                                enableSwitchAnimation: true,
                                switchAnimationConfig:
                                    const SwitchAnimationConfig(
                                      duration: Duration(milliseconds: 200),
                                      switchInCurve: Curves.linear,
                                      switchOutCurve: Curves.linear,
                                      transitionBuilder: AnimatedSwitcher
                                          .defaultTransitionBuilder,
                                      layoutBuilder:
                                          AnimatedSwitcher.defaultLayoutBuilder,
                                    ),
                                child: Visibility(
                                  visible:
                                      (suggestedPlayers.isEmpty &&
                                      allPlayers.isNotEmpty),
                                  replacement: ListView.builder(
                                    itemCount: suggestedPlayers.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                          return TextIconListTile(
                                            text: suggestedPlayers[index].name,
                                            onPressed: () {
                                              setState(() {
                                                if (!selectedPlayers.contains(
                                                  suggestedPlayers[index],
                                                )) {
                                                  selectedPlayers.add(
                                                    suggestedPlayers[index],
                                                  );
                                                  selectedPlayers.sort(
                                                    (a, b) => a.name.compareTo(
                                                      b.name,
                                                    ),
                                                  );
                                                  suggestedPlayers.remove(
                                                    suggestedPlayers[index],
                                                  );
                                                }
                                              });
                                            },
                                          );
                                        },
                                  ),
                                  child: TopCenteredMessage(
                                    icon: Icons.info,
                                    title: 'Info',
                                    message:
                                        (selectedPlayers.length ==
                                            allPlayers.length)
                                        ? 'No more players to add.'
                                        : 'No players found with that name.',
                                  ),
                                ),
                              ),
                            );
                          },
                    ),
                  ],
                ),
              ),
            ),
            CustomWidthButton(
              text: 'Create group',
              sizeRelativeToWidth: 0.95,
              buttonType: ButtonType.primary,
              onPressed:
                  (_groupNameController.text.isEmpty || selectedPlayers.isEmpty)
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
                        _groupNameController.clear();
                        _searchBarController.clear();
                        selectedPlayers.clear();
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: CustomTheme.boxColor,
                            content: const Center(
                              child: Text(
                                'Error while creating group, please try again',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      }
                      setState(() {});
                    },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// Adds a new player to the database from the search bar input.
  /// Shows a snackbar indicating success or failure.
  /// [context] - BuildContext to show the snackbar.
  void addNewPlayerFromSearch({required BuildContext context}) async {
    String playerName = _searchBarController.text.trim();
    Player createdPlayer = Player(name: playerName);
    bool success = await db.playerDao.addPlayer(player: createdPlayer);
    if (!context.mounted) return;
    if (success) {
      selectedPlayers.add(createdPlayer);
      allPlayers.add(createdPlayer);
      setState(() {
        _searchBarController.clear();
        suggestedPlayers = allPlayers.where((player) {
          return !selectedPlayers.contains(player);
        }).toList();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: CustomTheme.boxColor,
          content: Center(
            child: Text(
              'Successfully added player $playerName.',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: CustomTheme.boxColor,
          content: Center(
            child: Text(
              'Could not add player $playerName.',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }
  }
}
