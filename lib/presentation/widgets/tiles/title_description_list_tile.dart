import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

class TitleDescriptionListTile extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback? onPressed;
  final bool isHighlighted;
  final String? badgeText;
  final Color? badgeColor;

  const TitleDescriptionListTile({
    super.key,
    required this.title,
    required this.description,
    this.onPressed,
    this.isHighlighted = false,
    this.badgeText,
    this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: isHighlighted
            ? CustomTheme.highlightedBoxDecoration
            : CustomTheme.standardBoxDecoration,
        duration: const Duration(milliseconds: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                if (badgeText != null) ...[
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 6,
                    ),
                    decoration: BoxDecoration(
                      color: badgeColor ?? CustomTheme.primaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      badgeText!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            if (description.isNotEmpty) ...[
              const SizedBox(height: 5),
              Text(description, style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 2.5),
            ],
          ],
        ),
      ),
    );
  }
}
