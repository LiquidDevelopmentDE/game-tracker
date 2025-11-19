import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

class TextIconListTile extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool iconEnabled;

  const TextIconListTile({
    super.key,
    required this.text,
    this.onPressed,
    this.iconEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: CustomTheme.boxColor,
        border: Border.all(color: CustomTheme.boxBorder),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12.5),
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          if (iconEnabled)
            GestureDetector(
              onTap: onPressed,
              child: const Icon(Icons.add, size: 20),
            ),
        ],
      ),
    );
  }
}
