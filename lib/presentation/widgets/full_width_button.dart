import 'package:flutter/material.dart';

class FullWidthButton extends StatelessWidget {
  const FullWidthButton({
    super.key,
    required this.text,
    required this.borderColor,
    required this.infillColor,
    this.disabledInfillColor,
    required this.sizeRelativeToWidth,
    required this.onPressed,
  });

  final String text;
  final Color borderColor;
  final Color infillColor;
  final Color? disabledInfillColor;
  final double sizeRelativeToWidth;
  final VoidCallback? onPressed;

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
        backgroundColor: infillColor,
        side: BorderSide(color: borderColor, width: 2),
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
