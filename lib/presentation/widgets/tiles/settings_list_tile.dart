import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

class SettingsListTile extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String title;
  final Widget? suffixWidget;
  const SettingsListTile({
    super.key,
    required this.title,
    required this.icon,
    this.suffixWidget,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          child: GestureDetector(
            onTap: onPressed ?? () {},
            child: Container(
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              decoration: CustomTheme.standardBoxDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: CustomTheme.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon, size: 24),
                      ),
                      const SizedBox(width: 16),
                      Text(title, style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                  if (suffixWidget != null)
                    suffixWidget!
                  else
                    const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
