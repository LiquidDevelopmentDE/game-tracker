import 'package:flutter/material.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/presentation/widgets/game_tile.dart';
import 'package:game_tracker/presentation/widgets/quick_create_button.dart';
import 'package:game_tracker/presentation/widgets/tiles/info_tile.dart';
import 'package:game_tracker/presentation/widgets/tiles/quick_info_tile.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<int> _gameCountFuture;
  late Future<int> _groupCountFuture;
  bool isLoading = true;

  @override
  initState() {
    super.initState();
    final db = Provider.of<AppDatabase>(context, listen: false);
    _gameCountFuture = db.gameDao.getGameCount();
    _groupCountFuture = db.groupDao.getGroupCount();

    Future.wait([_gameCountFuture, _groupCountFuture]).then((_) async {
      await Future.delayed(const Duration(milliseconds: 50));
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Skeletonizer(
          effect: PulseEffect(
            from: Colors.grey[800]!,
            to: Colors.grey[600]!,
            duration: const Duration(milliseconds: 800),
          ),
          enabled: isLoading,
          enableSwitchAnimation: true,
          switchAnimationConfig: const SwitchAnimationConfig(
            duration: Duration(milliseconds: 200),
            switchInCurve: Curves.linear,
            switchOutCurve: Curves.linear,
            transitionBuilder: AnimatedSwitcher.defaultTransitionBuilder,
            layoutBuilder: AnimatedSwitcher.defaultLayoutBuilder,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder<int>(
                      future: _gameCountFuture,
                      builder: (context, snapshot) {
                        final int count = (snapshot.hasData)
                            ? snapshot.data!
                            : 0;
                        return QuickInfoTile(
                          width: constraints.maxWidth * 0.45,
                          height: constraints.maxHeight * 0.15,
                          title: 'Games',
                          icon: Icons.groups_rounded,
                          value: count,
                        );
                      },
                    ),
                    SizedBox(width: constraints.maxWidth * 0.05),
                    FutureBuilder<int>(
                      future: _groupCountFuture,
                      builder: (context, snapshot) {
                        final int count =
                            (snapshot.connectionState == ConnectionState.done &&
                                snapshot.hasData)
                            ? snapshot.data!
                            : 0;
                        return QuickInfoTile(
                          width: constraints.maxWidth * 0.45,
                          height: constraints.maxHeight * 0.15,
                          title: 'Groups',
                          icon: Icons.groups_rounded,
                          value: count,
                        );
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                          QuickCreateButton(
                            text: 'Category 1',
                            onPressed: () {},
                          ),
                          QuickCreateButton(
                            text: 'Category 2',
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          QuickCreateButton(
                            text: 'Category 3',
                            onPressed: () {},
                          ),
                          QuickCreateButton(
                            text: 'Category 4',
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          QuickCreateButton(
                            text: 'Category 5',
                            onPressed: () {},
                          ),
                          QuickCreateButton(
                            text: 'Category 6',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
