import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

class TextIconTile extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onIconTap;

  const TextIconTile({
    super.key,
    required this.text,
    this.icon,
    this.onIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: CustomTheme.onBoxColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) const SizedBox(width: 3),
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          if (icon != null) ...<Widget>[
            const SizedBox(width: 3),
            GestureDetector(onTap: onIconTap, child: Icon(icon, size: 20)),
          ],
        ],
      ),
    );
  }
}
