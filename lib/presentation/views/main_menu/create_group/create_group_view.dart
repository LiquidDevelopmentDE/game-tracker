import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:game_tracker/presentation/widgets/full_width_button.dart';
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
    Player(id: '0', name: 'Player 0'),
  );
  final _groupNameController = TextEditingController();
  final _searchBarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    db = Provider.of<AppDatabase>(context, listen: false);
    _allPlayersFuture = db.playerDao.getAllPlayers();
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomTheme.backgroundColor,
        appBar: AppBar(
          backgroundColor: CustomTheme.backgroundColor,
          scrolledUnderElevation: 0,
          title: const Text(
            "Create new group",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: TextField(
                controller: _groupNameController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: CustomTheme.boxColor,
                  hint: Text(
                    "Group name",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: CustomTheme.boxBorder),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: CustomTheme.boxBorder),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
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
                    SearchBar(
                      controller: _searchBarController,
                      constraints: BoxConstraints(maxHeight: 45, minHeight: 45),
                      hintText: "Search for players",
                      hintStyle: WidgetStateProperty.all(
                        TextStyle(fontSize: 16),
                      ),
                      leading: Icon(Icons.search),
                      backgroundColor: WidgetStateProperty.all(
                        CustomTheme.boxColor,
                      ),
                      side: WidgetStateProperty.all(
                        BorderSide(color: CustomTheme.boxBorder),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty) {
                            suggestedPlayers = [...allPlayers];
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
                    SizedBox(height: 10),
                    Text(
                      "Ausgewählte Spieler: (${selectedPlayers.length})",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: <Widget>[
                        for (var selectedPlayer in selectedPlayers)
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: CustomTheme.onBoxColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(width: 12),
                                Flexible(
                                  child: Text(
                                    selectedPlayer.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 3),
                                GestureDetector(
                                  child: const Icon(Icons.close, size: 20),
                                  onTap: () {
                                    setState(() {
                                      final currentSearch = _searchBarController
                                          .text
                                          .toLowerCase();
                                      selectedPlayers.remove(selectedPlayer);
                                      if (currentSearch.isEmpty ||
                                          selectedPlayer.name
                                              .toLowerCase()
                                              .contains(currentSearch)) {
                                        suggestedPlayers.add(selectedPlayer);
                                        suggestedPlayers.sort(
                                          (a, b) => a.name.compareTo(b.name),
                                        );
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Alle Spieler:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    FutureBuilder(
                      future: _allPlayersFuture,
                      builder: (BuildContext context, AsyncSnapshot<List<Player>> snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: TopCenteredMessage(
                              icon: Icons.report,
                              title: 'Error',
                              message: 'Player data couldn\'t\nbe loaded.',
                            ),
                          );
                        }
                        if (snapshot.connectionState == ConnectionState.done &&
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
                            snapshot.connectionState == ConnectionState.waiting;
                        return Expanded(
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
                              transitionBuilder:
                                  AnimatedSwitcher.defaultTransitionBuilder,
                              layoutBuilder:
                                  AnimatedSwitcher.defaultLayoutBuilder,
                            ),
                            child:
                                (suggestedPlayers.isEmpty &&
                                    !allPlayers.isEmpty)
                                ? TopCenteredMessage(
                                    icon: Icons.info,
                                    title: 'Info',
                                    message:
                                        (selectedPlayers.length ==
                                            allPlayers.length)
                                        ? 'No more players to add.'
                                        : 'No players found with that name.',
                                  )
                                : ListView.builder(
                                    itemCount: suggestedPlayers.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                          vertical: 5,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: CustomTheme.boxColor,
                                          border: Border.all(
                                            color: CustomTheme.boxBorder,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                suggestedPlayers[index].name,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.add, size: 20),
                                              onPressed: () {
                                                setState(() {
                                                  if (!selectedPlayers.contains(
                                                    suggestedPlayers[index],
                                                  )) {
                                                    selectedPlayers.add(
                                                      suggestedPlayers[index],
                                                    );
                                                    selectedPlayers.sort(
                                                      (a, b) => a.name
                                                          .compareTo(b.name),
                                                    );
                                                    suggestedPlayers.remove(
                                                      suggestedPlayers[index],
                                                    );
                                                  }
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            FullWidthButton(
              text: "Create group",
              infillColor: CustomTheme.primaryColor,
              borderColor: CustomTheme.primaryColor,
              disabledInfillColor: CustomTheme.boxColor,
              sizeRelativeToWidth: 0.95,
              onPressed:
                  (_groupNameController.text.isEmpty || selectedPlayers.isEmpty)
                  ? null
                  : () async {
                      String id = "ID_" + _groupNameController.text;
                      String name = _groupNameController.text;
                      List<Player> members = selectedPlayers;
                      bool success = await db.groupDao.addGroup(
                        group: Group(id: id, name: name, members: members),
                      );
                      if (success) {
                        _groupNameController.clear();
                        _searchBarController.clear();
                        selectedPlayers.clear();
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: CustomTheme.boxColor,
                            content: Center(
                              child: Text(
                                "Error while creating group, please try again",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      }
                      setState(() {});
                    },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
