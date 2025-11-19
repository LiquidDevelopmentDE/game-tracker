import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

class QuickCreateButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  const QuickCreateButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<QuickCreateButton> createState() => _QuickCreateButtonState();
}

class _QuickCreateButtonState extends State<QuickCreateButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(140, 45),
        backgroundColor: CustomTheme.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        widget.text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
