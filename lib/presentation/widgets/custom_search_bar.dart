import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final BoxConstraints? constraints;
  final bool trailingButtonEnabled;
  final bool trailingButtonShown;
  final VoidCallback? onTrailingButtonPressed;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.hintText,
    this.trailingButtonShown = false,
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
      trailing: trailingButtonShown
          ? [
              GestureDetector(
                onTap: onTrailingButtonPressed,
                child: Icon(
                  Icons.add_circle,
                  color: trailingButtonEnabled
                      ? null
                      : Colors.grey.withValues(alpha: 0.2),
                ),
              ),
              SizedBox(width: 5),
            ]
          : null,
      backgroundColor: WidgetStateProperty.all(CustomTheme.boxColor),
      side: WidgetStateProperty.all(BorderSide(color: CustomTheme.boxBorder)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevation: WidgetStateProperty.all(0),
    );
  }
}
