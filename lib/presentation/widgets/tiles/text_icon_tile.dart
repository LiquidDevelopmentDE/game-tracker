import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

class TextIconTile extends StatelessWidget {
  final String text;
  final bool iconEnabled;
  final VoidCallback? onIconTap;

  const TextIconTile({
    super.key,
    required this.text,
    this.onIconTap,
    this.iconEnabled = true,
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
          if (iconEnabled) const SizedBox(width: 3),
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          if (iconEnabled) ...<Widget>[
            const SizedBox(width: 3),
            GestureDetector(
              onTap: onIconTap,
              child: const Icon(Icons.close, size: 20),
            ),
          ],
        ],
      ),
    );
  }
}
