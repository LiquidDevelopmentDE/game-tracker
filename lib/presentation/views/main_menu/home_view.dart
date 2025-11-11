import 'package:flutter/material.dart';
import 'package:game_tracker/presentation/widgets/game_tile.dart';
import 'package:game_tracker/presentation/widgets/quick_create_button.dart';
import 'package:game_tracker/presentation/widgets/tiles/info_tile.dart';
import 'package:game_tracker/presentation/widgets/tiles/quick_info_tile.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  QuickInfoTile(
                    width: constraints.maxWidth * 0.45,
                    height: constraints.maxHeight * 0.15,
                    title: 'Games',
                    icon: Icons.casino,
                    value: 42,
                  ),
                  SizedBox(width: constraints.maxWidth * 0.05),
                  QuickInfoTile(
                    width: constraints.maxWidth * 0.45,
                    height: constraints.maxHeight * 0.15,
                    title: 'Groups',
                    icon: Icons.groups_rounded,
                    value: 5,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: InfoTile(
                  width: constraints.maxWidth * 0.95,
                  title: 'Recent Games',
                  icon: Icons.timer,
                  content: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GameTile(
                          gameTitle: 'Gamenight',
                          gameType: 'Cabo',
                          ruleset: 'Lowest Points',
                          players: '5 Players',
                          winner: 'Leonard',
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Divider(),
                        ),
                        GameTile(
                          gameTitle: 'Schoolbreak',
                          gameType: 'Uno',
                          ruleset: 'Highest Points',
                          players: 'The Gang',
                          winner: 'Lina',
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
              InfoTile(
                width: constraints.maxWidth * 0.95,
                title: 'Quick Create',
                icon: Icons.add_box_rounded,
                content: Column(
                  spacing: 8,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        QuickCreateButton(text: 'Category 1', onPressed: () {}),
                        QuickCreateButton(text: 'Category 2', onPressed: () {}),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        QuickCreateButton(text: 'Category 3', onPressed: () {}),
                        QuickCreateButton(text: 'Category 4', onPressed: () {}),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        QuickCreateButton(text: 'Category 5', onPressed: () {}),
                        QuickCreateButton(text: 'Category 6', onPressed: () {}),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
