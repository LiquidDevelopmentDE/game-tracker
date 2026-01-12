import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MatchSummaryTile extends StatefulWidget {
  final String matchTitle;
  final String game;
  final String ruleset;
  final String players;
  final String winner;

  const MatchSummaryTile({
    super.key,
    required this.matchTitle,
    required this.game,
    required this.ruleset,
    required this.players,
    required this.winner,
  });

  @override
  State<MatchSummaryTile> createState() => _MatchSummaryTileState();
}

class _MatchSummaryTileState extends State<MatchSummaryTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.matchTitle,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5),
            Text(
              widget.game,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: CustomTheme.primaryColor,
          ),
          child: Skeleton.ignore(
            child: Text(
              widget.ruleset,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Center(
          heightFactor: 1.5,
          child: Text(
            widget.players,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            width: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.yellow.shade300,
            ),
            child: Skeleton.ignore(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.emoji_events, color: Colors.black, size: 20),
                  Text(
                    widget.winner,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
