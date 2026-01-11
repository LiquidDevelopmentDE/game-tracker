import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: const TextStyle(color: CustomTheme.textColor,),),
      content: Text(content, style: const TextStyle(color: CustomTheme.textColor),),
      actions: actions,
      backgroundColor: CustomTheme.boxColor,
      actionsAlignment: MainAxisAlignment.spaceAround,
      shape: RoundedRectangleBorder(
        borderRadius: CustomTheme.standardBorderRadiusAll,
        side: BorderSide(color: CustomTheme.boxBorder),
      ),
    );
  }
}
