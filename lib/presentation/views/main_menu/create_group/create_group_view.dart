import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/data/db/database.dart';
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
  List<Player> selectedPlayers = [
    Player(id: '0', name: 'Player 0'),
    Player(id: '0', name: 'Player 0'),
    Player(id: '0', name: 'Player 0'),
    Player(id: '0', name: 'Player 0'),
  ];
  late Future<List<Player>> _allPlayersFuture;
  late final List<Player> skeletonData = List.filled(
    7,
    Player(id: '0', name: 'Player 0'),
  );

  @override
  @override
  void initState() {
    super.initState();
    final db = Provider.of<AppDatabase>(context, listen: false);
    _allPlayersFuture = db.playerDao.getAllPlayers();
  }

  @override
  Widget build(BuildContext context) {
    addSamplePlayers(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomTheme.backgroundColor,
        appBar: AppBar(
          backgroundColor: CustomTheme.backgroundColor,
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
                decoration: InputDecoration(
                  filled: true,
                  fillColor: CustomTheme.boxColor,
                  hint: Text("Group name", style: TextStyle(fontSize: 18)),
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
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Ausgewählte Spieler: (X)",
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
                        for (var player in selectedPlayers)
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
                                Text(
                                  player.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 3),
                                GestureDetector(
                                  child: const Icon(Icons.close, size: 20),
                                  onTap: () {
                                    setState(() {
                                      selectedPlayers.remove(player);
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
                                (!snapshot.hasData || snapshot.data!.isEmpty)) {
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
                            final List<Player> players = isLoading
                                ? skeletonData
                                : (snapshot.data ?? []);
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
                                child: ListView.builder(
                                  itemCount: players.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
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
                                              Text(
                                                players[index].name,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.add, size: 20),
                                                onPressed: () {},
                                              ),
                                            ],
                                          ),
                                        ); //GroupTile(group: groups[index]);
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
              sizeRelativeToWidth: 0.95,
              onPressed: () {},
            ),
            SizedBox(height: 10),
            FullWidthButton(
              text: "Cancel",
              infillColor: CustomTheme.boxColor,
              borderColor: CustomTheme.primaryColor,
              sizeRelativeToWidth: 0.95,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> addSamplePlayers(BuildContext context) async {
    final db = Provider.of<AppDatabase>(context, listen: false);
    final playerCount = await db.playerDao.getPlayerCount();
    if (playerCount == 0) {
      for (int i = 1; i <= 10; i++) {
        final player = Player(id: '$i', name: 'Spieler $i');
        await db.playerDao.addPlayer(player: player);
      }
      print("10 Beispiel-Spieler wurden zur Datenbank hinzugefügt.");
      final players = await db.playerDao.getAllPlayers();
      for (int i = 0; i < players.length; i++) {
        print(players[i]);
      }
    }
  }
}
