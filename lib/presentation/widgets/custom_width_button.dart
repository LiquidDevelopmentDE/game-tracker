import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

enum ButtonStyle { primary, secondary }

class CustomWidthButton extends StatelessWidget {
  const CustomWidthButton({
    super.key,
    required this.text,
    this.disabledInfillColor,
    this.buttonStyle = ButtonStyle.primary,
    required this.sizeRelativeToWidth,
    required this.onPressed,
  });

  final String text;
  final Color? disabledInfillColor;
  final double sizeRelativeToWidth;
  final VoidCallback? onPressed;
  final ButtonStyle buttonStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: disabledInfillColor,
        minimumSize: Size(
          MediaQuery.sizeOf(context).width * sizeRelativeToWidth,
          60,
        ),
        backgroundColor: buttonStyle == ButtonStyle.primary
            ? CustomTheme.primaryColor
            : CustomTheme.secondaryColor,
        side: BorderSide(
          color: buttonStyle == ButtonStyle.primary
              ? CustomTheme.primaryColor
              : CustomTheme.secondaryColor,
          width: 2,
        ),
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
