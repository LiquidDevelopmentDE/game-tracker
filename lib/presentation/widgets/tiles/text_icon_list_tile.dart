import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

class IconListTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const IconListTile({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          IconButton(icon: Icon(icon, size: 20), onPressed: onPressed),
        ],
      ),
    );
  }
}
