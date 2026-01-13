import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

/// A custom animated button widget that provides a scaling and opacity effect
/// when pressed. This widget is designed to be used in dialogs or other UI
/// components where a visually appealing button is required.
class AnimatedDialogButton extends StatefulWidget {
  /// Callback function that is triggered when the button is pressed.
  final VoidCallback onPressed;

  /// The child widget to be displayed inside the button, typically a text or icon.
  final Widget child;

  /// Creates an instance of `AnimatedDialogButton`.
  ///
  /// The [onPressed] and [child] parameters are required.
  const AnimatedDialogButton({required this.onPressed, required this.child});

  @override
  State<AnimatedDialogButton> createState() => _AnimatedDialogButtonState();
}

class _AnimatedDialogButtonState extends State<AnimatedDialogButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: AnimatedOpacity(
          opacity: _isPressed ? 0.6 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: Container(
            decoration: CustomTheme.standardBoxDecoration,
            padding: EdgeInsets.symmetric(horizontal: 26, vertical: 6),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
