import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/match.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:game_tracker/l10n/generated/app_localizations.dart';
import 'package:game_tracker/presentation/widgets/tiles/custom_radio_list_tile.dart';
import 'package:provider/provider.dart';

class MatchResultView extends StatefulWidget {
  final Match match;

  final VoidCallback? onWinnerChanged;

  const MatchResultView({super.key, required this.match, this.onWinnerChanged});
  @override
  State<MatchResultView> createState() => _MatchResultViewState();
}

class _MatchResultViewState extends State<MatchResultView> {
  late final List<Player> allPlayers;
  late final AppDatabase db;
  Player? _selectedPlayer;

  @override
  void initState() {
    db = Provider.of<AppDatabase>(context, listen: false);
    allPlayers = getAllPlayers(widget.match);
    if (widget.match.winner != null) {
      _selectedPlayer = allPlayers.firstWhere(
        (p) => p.id == widget.match.winner!.id,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            widget.onWinnerChanged?.call();
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: CustomTheme.backgroundColor,
        scrolledUnderElevation: 0,
        title: Text(
          widget.match.name,
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
                    Text(
                      AppLocalizations.of(context)!.select_winner,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: RadioGroup<Player>(
                        groupValue: _selectedPlayer,
                        onChanged: (Player? value) async {
                          setState(() {
                            _selectedPlayer = value;
                          });
                          await _handleWinnerSaving();
                        },
                        child: ListView.builder(
                          itemCount: allPlayers.length,
                          itemBuilder: (context, index) {
                            return CustomRadioListTile(
                              text: allPlayers[index].name,
                              value: allPlayers[index],
                              onContainerTap: (value) async {
                                setState(() {
                                  // Check if the already selected player is the same as the newly tapped player.
                                  if (_selectedPlayer == value) {
                                    // If yes deselected the player by setting it to null.
                                    _selectedPlayer = null;
                                  } else {
                                    // If no assign the newly tapped player to the selected player.
                                    (_selectedPlayer = value);
                                  }
                                });
                                await _handleWinnerSaving();
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
          ],
        ),
      ),
    );
  }

  Future<void> _handleWinnerSaving() async {
    if (_selectedPlayer == null) {
      await db.matchDao.removeWinner(matchId: widget.match.id);
    } else {
      await db.matchDao.setWinner(
        matchId: widget.match.id,
        winnerId: _selectedPlayer!.id,
      );
    }
    widget.onWinnerChanged?.call();
  }

  List<Player> getAllPlayers(Match match) {
    if (match.group == null && match.players != null) {
      return [...match.players!];
    } else if (match.group != null && match.players != null) {
      return [...match.players!, ...match.group!.members];
    }
    return [...match.group!.members];
  }
}
