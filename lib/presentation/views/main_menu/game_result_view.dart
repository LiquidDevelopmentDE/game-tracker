import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/data/dto/game.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:game_tracker/presentation/widgets/buttons/custom_width_button.dart';

class GameResultView extends StatefulWidget {
  final Game game;

  const GameResultView({super.key, required this.game});

  @override
  State<GameResultView> createState() => _GameResultViewState();
}

class _GameResultViewState extends State<GameResultView> {
  late final List<Player> allPlayers;

  @override
  void initState() {
    allPlayers = getAllPlayers(widget.game);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: CustomTheme.backgroundColor,
        scrolledUnderElevation: 0,
        title: const Text(
          'Game Result',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select Winner:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: allPlayers.length,
                        itemBuilder: (context, index) {
                          //TODO: Implement Custom RadioListTile, see text_icon_list_tile
                          return RadioListTile<Player>(
                            title: Text(allPlayers[index].name),
                            value: allPlayers[index],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomWidthButton(
              text: "Save",
              sizeRelativeToWidth: 0.95,
              onPressed: null,
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  List<Player> getAllPlayers(Game game) {
    if (game.group == null && game.players != null) {
      return [...game.players!];
    } else if (game.group != null && game.players != null) {
      return [...game.players!, ...game.group!.members];
    }
    return [...game.group!.members];
  }
}
