import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

class GameTile extends StatefulWidget {
  const GameTile({super.key});

  @override
  State<GameTile> createState() => _GameTileState();
}

class _GameTileState extends State<GameTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      height: 120,
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: CustomTheme.boxColor,
        border: Border.all(color: CustomTheme.boxBorder),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text(
                'Gametitle',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5),
              Text(
                'Gametype',
                style: TextStyle(fontSize: 14, color: Colors.grey),
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
            child: const Text(
              'Ruleset',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Center(
            child: Text(
              '5 Player',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Spacer(),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              width: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.yellow.shade300,
              ),
              child: const Text(
                'In Progress',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
