import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

class QuickInfoTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final int value;
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  const QuickInfoTile({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
    this.height,
    this.width,
    this.padding,
  });

  @override
  State<QuickInfoTile> createState() => _QuickInfoTileState();
}

class _QuickInfoTileState extends State<QuickInfoTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ?? const EdgeInsets.all(12),
      height: widget.height ?? 110,
      width: widget.width ?? 180,
      decoration: CustomTheme.standardBoxDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(widget.icon),
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
