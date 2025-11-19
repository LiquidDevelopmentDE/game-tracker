import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:skeletonizer/skeletonizer.dart';

class GameHistoryTile extends StatefulWidget {
  final String gameTitle;
  final String gameType;
  final String ruleset;
  final String groupName;
  final String winner;

  const GameHistoryTile({
    super.key,
    required this.gameTitle,
    required this.gameType,
    required this.ruleset,
    required this.groupName,
    required this.winner,
  });

  @override
  State<GameHistoryTile> createState() => _GameHistoryTileState();
}

class _GameHistoryTileState extends State<GameHistoryTile> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.gameTitle,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5),
            Text(
              widget.gameType,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

}
