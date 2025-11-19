import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

enum ButtonStyle { primary, secondary }

class CustomWidthButton extends StatelessWidget {
  const CustomWidthButton({
    super.key,
    required this.text,
    this.buttonStyle = ButtonStyle.primary,
    required this.sizeRelativeToWidth,
    this.onPressed,
  });

  final String text;
  final double sizeRelativeToWidth;
  final VoidCallback? onPressed;
  final ButtonStyle buttonStyle;

  @override
  Widget build(BuildContext context) {

    final Color buttonBackgroundColor;
    final Color disabledBackgroundColor;
    final Color borderSideColor;
    final Color disabledBorderSideColor;
    final Color textcolor;
    final Color disabledTextColor;


    if(buttonStyle == ButtonStyle.primary){
      buttonBackgroundColor = CustomTheme.primaryColor;
      disabledBackgroundColor = CustomTheme.primaryColor.withValues(alpha: 0.24);
      borderSideColor = Colors.transparent;
      disabledBorderSideColor = Colors.transparent;
      textcolor = Colors.white;
      disabledTextColor = Colors.white.withValues(alpha: 0.24);
    } else{
      buttonBackgroundColor = Colors.transparent;
      disabledBackgroundColor = Colors.transparent;
      borderSideColor = CustomTheme.primaryColor.withValues(alpha: 0.6 );
      disabledBorderSideColor = Colors.transparent;
      textcolor = CustomTheme.primaryColor;
      disabledTextColor = CustomTheme.primaryColor.withValues(alpha: 0.24);
    }


    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: disabledBackgroundColor,
        minimumSize: Size(
          MediaQuery.sizeOf(context).width * sizeRelativeToWidth,
          60,
        ),
        backgroundColor: buttonBackgroundColor,
        side: BorderSide(
          color: borderSideColor,
          width: 2,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 22,
          color: (onPressed == null)
              ? disabledTextColor
              : textcolor,
        ),
      ),
    );
  }
}
