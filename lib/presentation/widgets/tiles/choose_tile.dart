import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

class ChooseTile extends StatefulWidget {
  final String title;
  final VoidCallback? onPressed;
  final String? trailingText;
  const ChooseTile({
    super.key,
    required this.title,
    this.trailingText,
    this.onPressed,
  });

  @override
  State<ChooseTile> createState() => _ChooseTileState();
}

class _ChooseTileState extends State<ChooseTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: CustomTheme.standardBoxDecoration,
        child: Row(
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            if (widget.trailingText != null) Text(widget.trailingText!),
            const SizedBox(width: 10),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
