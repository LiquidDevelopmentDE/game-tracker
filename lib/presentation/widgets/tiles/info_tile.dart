import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

class InfoTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final Widget content;
  final EdgeInsets? padding;
  final double? height;
  final double? width;
  const InfoTile({
    super.key,
    required this.title,
    required this.icon,
    required this.content,
    this.padding,
    this.height,
    this.width,
  });

  @override
  State<InfoTile> createState() => _InfoTileState();
}

class _InfoTileState extends State<InfoTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ?? const EdgeInsets.all(12),
      height: widget.height,
      width: widget.width ?? 380,
      decoration: CustomTheme.standardBoxDecoration,
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
    );
  }
}
