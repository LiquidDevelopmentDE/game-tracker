import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

/// A custom radio list tile widget that encapsulates a [Radio] button with additional styling and functionality.
/// - [text]: The text to display next to the radio button.
/// - [value]: The value associated with the radio button.
/// - [onContainerTap]: The callback invoked when the container is tapped.
class CustomRadioListTile<T> extends StatelessWidget {
  const CustomRadioListTile({
    super.key,
    required this.text,
    required this.value,
    required this.onContainerTap,
  });

  /// The text to display next to the radio button.
  final String text;

  /// The value associated with the radio button.
  final T value;

  /// The callback invoked when the container is tapped.
  final ValueChanged<T> onContainerTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onContainerTap(value),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: CustomTheme.boxColor,
          border: Border.all(color: CustomTheme.boxBorder),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Radio<T>(
              value: value,
              activeColor: CustomTheme.primaryColor,
              toggleable: true,
            ),
            Expanded(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
