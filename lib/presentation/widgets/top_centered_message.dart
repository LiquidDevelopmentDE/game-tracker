import 'package:flutter/material.dart';

/// A widget that displays a message centered at the top of the screen with an icon, title, and message.
/// - [icon]: The icon to display above the title.
/// - [title]: The title text to display.
/// - [message]: The message text to display below the title.
class TopCenteredMessage extends StatelessWidget {
  const TopCenteredMessage({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.fullscreen = true,
  });

  /// The icon to display above the title.
  final IconData icon;

  /// The title text to display.
  final String title;

  /// The message text to display below the title.
  final String message;

  final bool fullscreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: fullscreen ? const EdgeInsets.only(top: 100) : null,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: fullscreen
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: [
          Icon(icon, size: 45),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            message,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
