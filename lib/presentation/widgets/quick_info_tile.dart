import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

class QuickInfoTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final int value;
  const QuickInfoTile({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
  });

  @override
  State<QuickInfoTile> createState() => _QuickInfoTileState();
}

class _QuickInfoTileState extends State<QuickInfoTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      height: 110,
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: CustomTheme.boxColor,
        border: Border.all(color: CustomTheme.boxBorder),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.casino),
              const SizedBox(width: 5),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            widget.value.toString(),
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
