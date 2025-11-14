import 'package:flutter/material.dart';

class TopCenteredMessage extends StatelessWidget {
  const TopCenteredMessage({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 100),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.topCenter,
      child: Text(
        message,
        style: const TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }
}
