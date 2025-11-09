import 'package:flutter/material.dart';
import 'package:game_tracker/presentation/widgets/quick_info_tile.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            QuickInfoTile(title: 'Games', icon: Icons.casino, value: 42),
            QuickInfoTile(
              title: 'Groups',
              icon: Icons.groups_rounded,
              value: 5,
            ),
          ],
        ),
      ],
    );
  }
}
