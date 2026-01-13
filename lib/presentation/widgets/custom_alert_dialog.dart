import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

/// A custom alert dialog widget that follows the application's design theme.
///
/// This widget provides a styled alternative to the default Flutter AlertDialog,
/// with consistent colors, borders, and layout that match the app's custom theme.
class CustomAlertDialog extends StatelessWidget {
  /// The title text displayed at the top of the dialog.
  final String title;

  /// The main content text displayed in the body of the dialog.
  final String content;

  /// A list of action widgets (typically buttons) displayed at the bottom of the dialog.
  /// These actions are horizontally spaced around the dialog's width.
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
