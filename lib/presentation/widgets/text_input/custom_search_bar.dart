import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

/// A custom search bar widget that encapsulates a [SearchBar] with additional customization options.
/// - [controller]: The controller for the search bar's text input.
/// - [hintText]: The hint text displayed in the search bar when it is empty.
/// - [trailingButtonShown]: Whether to show the trailing button.
/// - [trailingButtonicon]: The icon for the trailing button.
/// - [trailingButtonEnabled]: Whether the trailing button is in enabled state.
/// - [onTrailingButtonPressed]: The callback invoked when the trailing button is pressed.
/// - [onChanged]: The callback invoked when the text in the search bar changes.
/// - [constraints]: The constraints for the search bar.
class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.hintText,
    this.trailingButtonShown = false,
    this.trailingButtonicon = Icons.clear,
    this.trailingButtonEnabled = true,
    this.onTrailingButtonPressed,
    this.onChanged,
    this.constraints,
  });

  /// The controller for the search bar's text input.
  final TextEditingController controller;

  /// The hint text displayed in the search bar when it is empty.
  final String hintText;

  /// Whether to show the trailing button.
  final bool trailingButtonShown;

  /// The icon for the trailing button.
  final IconData trailingButtonicon;

  /// Whether the trailing button is in enabled state.
  final bool trailingButtonEnabled;

  /// The callback invoked when the trailing button is pressed.
  final VoidCallback? onTrailingButtonPressed;

  /// The callback invoked when the text in the search bar changes.
  final ValueChanged<String>? onChanged;

  /// The constraints for the search bar.
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: controller,
      constraints:
          constraints ?? const BoxConstraints(maxHeight: 45, minHeight: 45),
      hintText: hintText,
      onChanged: onChanged,
      hintStyle: WidgetStateProperty.all(const TextStyle(fontSize: 16)),
      leading: const Icon(Icons.search),
      trailing: [
        Visibility(
          visible: trailingButtonShown,
          child: GestureDetector(
            onTap: trailingButtonEnabled ? onTrailingButtonPressed : null,
            child: Icon(
              trailingButtonicon,
              color: trailingButtonEnabled
                  ? null
                  : Colors.grey.withValues(alpha: 0.2),
            ),
          ),
        ),
        const SizedBox(width: 5),
      ],
      backgroundColor: WidgetStateProperty.all(CustomTheme.boxColor),
      side: WidgetStateProperty.all(BorderSide(color: CustomTheme.boxBorder)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevation: WidgetStateProperty.all(0),
    );
  }
}
