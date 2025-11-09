import 'package:flutter/material.dart';
import 'package:game_tracker/presentation/widgets/game_tile.dart';
import 'package:game_tracker/presentation/widgets/info_tile.dart';
import 'package:game_tracker/presentation/widgets/quick_create_button.dart';
import 'package:game_tracker/presentation/widgets/quick_info_tile.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Row(
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
        const InfoTile(
          title: 'Recent Games',
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          icon: Icons.timer,
          content: GameTile(),
        ),
        InfoTile(
          title: 'Quick Create',
          height: 210,
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          icon: Icons.add_box_rounded,
          content: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  QuickCreateButton(text: 'Cabo', onPressed: () {}),
                  QuickCreateButton(text: 'Uno', onPressed: () {}),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  QuickCreateButton(text: 'Phase 10', onPressed: () {}),
                  QuickCreateButton(text: 'Category 5', onPressed: () {}),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  QuickCreateButton(text: 'Category 6', onPressed: () {}),
                  QuickCreateButton(text: 'Category 7', onPressed: () {}),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
