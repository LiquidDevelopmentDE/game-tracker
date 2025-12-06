import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/game.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:game_tracker/presentation/widgets/buttons/custom_width_button.dart';
import 'package:game_tracker/presentation/widgets/tiles/custom_radio_list_tile.dart';
import 'package:provider/provider.dart';

class GameResultView extends StatefulWidget {
  final Game game;

  const GameResultView({super.key, required this.game});

  @override
  State<GameResultView> createState() => _GameResultViewState();
}

class _GameResultViewState extends State<GameResultView> {
  late final List<Player> allPlayers;
  late final AppDatabase db;
  Player? _selectedPlayer;

  @override
  void initState() {
    db = Provider.of<AppDatabase>(context, listen: false);
    allPlayers = getAllPlayers(widget.game);
    if (widget.game.winner != null) {
      _selectedPlayer = allPlayers.firstWhere(
        (p) => p.id == widget.game.winner!.id,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: CustomTheme.backgroundColor,
        scrolledUnderElevation: 0,
        title: Text(
          widget.game.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
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
                      'Select Winner:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: RadioGroup<Player>(
                        groupValue: _selectedPlayer,
                        onChanged: (Player? value) {
                          setState(() {
                            _selectedPlayer = value;
                          });
                        },
                        child: ListView.builder(
                          itemCount: allPlayers.length,
                          itemBuilder: (context, index) {
                            return CustomRadioListTile(
                              text: allPlayers[index].name,
                              value: allPlayers[index],
                              onContainerTap: (value) {
                                setState(() {
                                  _selectedPlayer = value;
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomWidthButton(
              text: 'Save',
              sizeRelativeToWidth: 0.95,
              onPressed: _selectedPlayer != null
                  ? () async {
                      bool success = await db.gameDao.setWinner(
                        gameId: widget.game.id,
                        winnerId: _selectedPlayer!.id,
                      );
                      if (!context.mounted) return;
                      if (success) {
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: CustomTheme.boxColor,
                            content: const Center(
                              child: Text(
                                'Error while setting winner, please try again',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      }
                      setState(() {});
                    }
                  : null,
            ),
            const SizedBox(height: 10),
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
