import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

class InfoTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final Widget content;
  final EdgeInsets? padding;
  final double? height;
  const InfoTile({
    super.key,
    required this.title,
    required this.icon,
    required this.content,
    this.padding,
    this.height,
  });

  @override
  State<InfoTile> createState() => _InfoTileState();
}

class _InfoTileState extends State<InfoTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.all(12),
        height: widget.height ?? 200,
        width: 380,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: CustomTheme.boxColor,
          border: Border.all(color: CustomTheme.boxBorder),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            const SizedBox(height: 10),
            widget.content,
          ],
        ),
      ),
    );
  }
}
