import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:skeletonizer/skeletonizer.dart';

class GameHistoryTile extends StatefulWidget {
  final String gameTitle;
  final String gameType;
  final String date;
  final String groupName;
  final String winner;

  const GameHistoryTile({
    super.key,
    required this.gameTitle,
    required this.gameType,
    required this.date,
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
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: CustomTheme.boxColor,
            border: Border.all(color: CustomTheme.boxBorder),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                      widget.gameTitle,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
              Row(
                children: [
                  Text(
                    widget.date,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(width: 5),
                  const Text('·'),
                  const SizedBox(width: 5),
                  Text(
                    widget.gameType,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              
            ]
          )
        ),
      ],
    );
  }

}
