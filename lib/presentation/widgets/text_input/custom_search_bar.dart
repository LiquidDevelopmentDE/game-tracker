import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final BoxConstraints? constraints;
  final bool trailingButtonShown;
  final bool trailingButtonEnabled;
  final VoidCallback? onTrailingButtonPressed;
  final IconData trailingButtonicon;

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
