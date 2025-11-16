import 'package:flutter/material.dart';

class TopCenteredMessage extends StatelessWidget {
  const TopCenteredMessage({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });

  final String title;
  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 100),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.topCenter,
      child: Column(
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
