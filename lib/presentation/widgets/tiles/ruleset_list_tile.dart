import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

class RulesetListTile extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback? onPressed;
  final bool isHighlighted;

  const RulesetListTile({
    super.key,
    required this.title,
    required this.description,
    this.onPressed,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: isHighlighted
            ? CustomTheme.highlightedBoxDecoration
            : CustomTheme.standardBoxDecoration,
        duration: const Duration(milliseconds: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(description, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 2.5),
          ],
        ),
      ),
    );
  }
}
