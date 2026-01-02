import 'package:flutter/material.dart';
import 'package:game_tracker/core/constants.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:game_tracker/l10n/generated/app_localizations.dart';
import 'package:game_tracker/presentation/widgets/app_skeleton.dart';
import 'package:game_tracker/presentation/widgets/text_input/custom_search_bar.dart';
import 'package:game_tracker/presentation/widgets/tiles/text_icon_list_tile.dart';
import 'package:game_tracker/presentation/widgets/tiles/text_icon_tile.dart';
import 'package:game_tracker/presentation/widgets/top_centered_message.dart';
import 'package:provider/provider.dart';

class PlayerSelection extends StatefulWidget {
  final Function(List<Player> value) onChanged;
  final List<Player>? availablePlayers;
  final List<Player>? initialSelectedPlayers;

  const PlayerSelection({
    super.key,
    required this.onChanged,
    this.availablePlayers,
    this.initialSelectedPlayers,
  });

  @override
  State<PlayerSelection> createState() => _PlayerSelectionState();
}

class _PlayerSelectionState extends State<PlayerSelection> {
  List<Player> selectedPlayers = [];
  List<Player> suggestedPlayers = [];
  List<Player> allPlayers = [];
  bool isLoading = true;
  late final TextEditingController _searchBarController =
      TextEditingController();
  late final AppDatabase db;
  late Future<List<Player>> _allPlayersFuture;
  late final List<Player> skeletonData = List.filled(
    7,
    Player(name: 'Player 0'),
  );

  @override
  void initState() {
    super.initState();
    db = Provider.of<AppDatabase>(context, listen: false);
    suggestedPlayers = skeletonData;
    loadPlayerList();
  }

  void loadPlayerList() {
    _allPlayersFuture = Future.wait([
      db.playerDao.getAllPlayers(),
      Future.delayed(minimumSkeletonDuration),
    ]).then((results) => results[0] as List<Player>);
    if (mounted) {
      _allPlayersFuture.then((loadedPlayers) {
        setState(() {
          // If a list of available players is provided (even if empty), use that list.
          if (widget.availablePlayers != null) {
            widget.availablePlayers!.sort((a, b) => a.name.compareTo(b.name));
            allPlayers = [...widget.availablePlayers!];
            suggestedPlayers = [...allPlayers];

            if (widget.initialSelectedPlayers != null) {
              // Ensures that only players available for selection are pre-selected.
              selectedPlayers = widget.initialSelectedPlayers!
                  .where(
                    (p) => widget.availablePlayers!.any(
                      (available) => available.id == p.id,
                    ),
                  )
                  .toList();
            }
          } else {
            // Otherwise, use the loaded players from the database.
            loadedPlayers.sort((a, b) => a.name.compareTo(b.name));
            allPlayers = [...loadedPlayers];
            suggestedPlayers = [...loadedPlayers];
          }
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: CustomTheme.standardBoxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSearchBar(
            controller: _searchBarController,
            constraints: const BoxConstraints(maxHeight: 45, minHeight: 45),
            hintText: AppLocalizations.of(context).search_for_players,
            trailingButtonShown: true,
            trailingButtonicon: Icons.add_circle,
            trailingButtonEnabled: _searchBarController.text.trim().isNotEmpty,
            onTrailingButtonPressed: () async {
              addNewPlayerFromSearch(context: context);
            },
            onChanged: (value) {
              setState(() {
                // Filters the list of suggested players based on the search input.
                if (value.isEmpty) {
                  // If the search is empty, it shows all unselected players.
                  suggestedPlayers = allPlayers.where((player) {
                    return !selectedPlayers.contains(player);
                  }).toList();
                } else {
                  // If there is input, it filters by name match (case-insensitive) and ensures
                  // that already selected players are excluded from the results.
                  suggestedPlayers = allPlayers.where((player) {
                    final bool nameMatches = player.name.toLowerCase().contains(
                      value.toLowerCase(),
                    );
                    final bool isNotSelected = !selectedPlayers.contains(
                      player,
                    );
                    return nameMatches && isNotSelected;
                  }).toList();
                }
              });
            },
          ),
          const SizedBox(height: 10),
          Text(
            AppLocalizations.of(
              context,
            ).selected_players(selectedPlayers.length),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            child: selectedPlayers.isEmpty
                ? Center(
                    child: Text(
                      AppLocalizations.of(context).no_players_selected,
                    ),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (var player in selectedPlayers)
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: TextIconTile(
                              text: player.name,
                              onIconTap: () {
                                setState(() {
                                  // Removes the player from the selection and notifies the parent.
                                  selectedPlayers.remove(player);
                                  widget.onChanged([...selectedPlayers]);

                                  // Get the current search query
                                  final currentSearch = _searchBarController
                                      .text
                                      .toLowerCase();

                                  // If the player matches the current search query (or search is empty),
                                  // they are added back to the `suggestedPlayers` and the list is re-sorted.
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
                          ),
                      ],
                    ),
                  ),
          ),
          const SizedBox(height: 10),
          Text(
            AppLocalizations.of(context).all_players,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: AppSkeleton(
              enabled: isLoading,
              child: Visibility(
                visible: suggestedPlayers.isNotEmpty,
                replacement: TopCenteredMessage(
                  icon: Icons.info,
                  title: 'Info',
                  message: _getInfoText(),
                ),
                child: ListView.builder(
                  itemCount: suggestedPlayers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TextIconListTile(
                      text: suggestedPlayers[index].name,
                      onPressed: () {
                        setState(() {
                          // If the player is not already selected
                          if (!selectedPlayers.contains(
                            suggestedPlayers[index],
                          )) {
                            // Add to player to the front of the selectedPlayers
                            selectedPlayers.insert(0, suggestedPlayers[index]);
                            // Notify the parent widget of the change
                            widget.onChanged([...selectedPlayers]);
                            // Remove the player from the suggestedPlayers
                            suggestedPlayers.remove(suggestedPlayers[index]);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
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
      selectedPlayers.insert(0, createdPlayer);
      widget.onChanged([...selectedPlayers]);
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
              AppLocalizations.of(
                context,
              ).successfully_added_player(playerName),
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
              AppLocalizations.of(context).could_not_add_player(playerName),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }
  }

  /// Determines the appropriate info text to display when no players
  /// are available in the suggested players list.
  String _getInfoText() {
    if (allPlayers.isEmpty) {
      // No players exist in the database
      return AppLocalizations.of(context).no_players_created_yet;
    } else if (selectedPlayers.length == allPlayers.length ||
        widget.availablePlayers?.isEmpty == true) {
      // All players have been selected or
      // available players list is provided but empty
      return AppLocalizations.of(context).all_players_selected;
    } else {
      // No players match the search query
      return AppLocalizations.of(context).no_players_found_with_that_name;
    }
  }
}
