import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

class CustomRadioListTile<T> extends StatelessWidget {
  final String text;
  final T value;
  final ValueChanged<T> onContainerTap;

  const CustomRadioListTile({
    super.key,
    required this.text,
    required this.value,
    required this.onContainerTap,
  });

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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Radio<T>(value: value, activeColor: CustomTheme.primaryColor),
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
      ),
    );
  }
}
