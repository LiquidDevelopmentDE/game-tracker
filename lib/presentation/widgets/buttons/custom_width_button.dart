import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/core/enums.dart';

class CustomWidthButton extends StatelessWidget {
  const CustomWidthButton({
    super.key,
    required this.text,
    this.buttonType = ButtonType.primary,
    required this.sizeRelativeToWidth,
    this.onPressed,
  });

  final String text;
  final double sizeRelativeToWidth;
  final VoidCallback? onPressed;
  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    final Color buttonBackgroundColor;
    final Color disabledBackgroundColor;
    final Color borderSideColor;
    final Color textcolor;
    final Color disabledTextColor;

    if (buttonType == ButtonType.primary) {
      textcolor = Colors.white;
      disabledTextColor = Color.lerp(textcolor, Colors.black, 0.5)!;
      buttonBackgroundColor = CustomTheme.primaryColor;
      disabledBackgroundColor = Color.lerp(
        buttonBackgroundColor,
        Colors.black,
        0.5,
      )!;

      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: textcolor,
          disabledForegroundColor: disabledTextColor,
          backgroundColor: buttonBackgroundColor,
          disabledBackgroundColor: disabledBackgroundColor,
          animationDuration: const Duration(),
          minimumSize: Size(
            MediaQuery.sizeOf(context).width * sizeRelativeToWidth,
            60,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
        ),
      );
    } else if (buttonType == ButtonType.secondary) {
      textcolor = CustomTheme.primaryColor;
      disabledTextColor = Color.lerp(textcolor, Colors.black, 0.5)!;
      buttonBackgroundColor = Colors.transparent;
      disabledBackgroundColor = Colors.transparent;
      borderSideColor = onPressed != null
          ? CustomTheme.primaryColor
          : Color.lerp(CustomTheme.primaryColor, Colors.black, 0.5)!;

      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: textcolor,
          disabledForegroundColor: disabledTextColor,
          backgroundColor: buttonBackgroundColor,
          disabledBackgroundColor: disabledBackgroundColor,
          animationDuration: const Duration(),
          minimumSize: Size(
            MediaQuery.sizeOf(context).width * sizeRelativeToWidth,
            60,
          ),
          side: BorderSide(color: borderSideColor, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
        ),
      );
    } else {
      textcolor = CustomTheme.primaryColor;
      disabledTextColor = Color.lerp(
        CustomTheme.primaryColor,
        Colors.black,
        0.5,
      )!;
      buttonBackgroundColor = Colors.transparent;
      disabledBackgroundColor = Colors.transparent;

      return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: textcolor,
          disabledForegroundColor: disabledTextColor,
          backgroundColor: buttonBackgroundColor,
          disabledBackgroundColor: disabledBackgroundColor,
          animationDuration: const Duration(),
          minimumSize: Size(
            MediaQuery.sizeOf(context).width * sizeRelativeToWidth,
            60,
          ),
          side: const BorderSide(style: BorderStyle.none),
        ),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
        ),
      );
    }
  }
}
