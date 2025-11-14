import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

class FullWidthButton extends StatelessWidget {
  const FullWidthButton({super.key, required this.text, this.onPressed});

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 60),
        backgroundColor: CustomTheme.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 22,
          color: Colors.white,
        ),
      ),
    );
  }
}
