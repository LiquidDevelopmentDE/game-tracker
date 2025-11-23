import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/data/dto/game.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:game_tracker/presentation/views/main_menu/game_history_view.dart';
import 'package:game_tracker/presentation/views/main_menu/game_result_view.dart';
import 'package:game_tracker/presentation/views/main_menu/groups_view.dart';
import 'package:game_tracker/presentation/views/main_menu/home_view.dart';
import 'package:game_tracker/presentation/views/main_menu/statistics_view.dart';
import 'package:game_tracker/presentation/widgets/navbar_item.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  int tabKeyCount = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Pretty ugly but works
    final List<Widget> tabs = [
      KeyedSubtree(key: ValueKey('home_$tabKeyCount'), child: const HomeView()),
      KeyedSubtree(
        key: ValueKey('games_$tabKeyCount'),
        child: const GameHistoryView(),
      ),
      KeyedSubtree(
        key: ValueKey('groups_$tabKeyCount'),
        child: const GroupsView(),
      ),
      KeyedSubtree(
        key: ValueKey('stats_$tabKeyCount'),
        child: const StatisticsView(),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _currentTabTitle(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: CustomTheme.backgroundColor,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => GameResultView(
                    game: Game(
                      name: "Test Game",
                      players: [
                        Player(name: "Petrus"),
                        Player(name: "Peter"),
                        Player(name: "Petra"),
                      ],
                      group: Group(
                        name: "Die Petris",
                        members: [
                          Player(name: "Petralia"),
                          Player(name: "Petrenlia"),
                          Player(name: "Petrumlia"),
                        ],
                      ),
                    ),
                  ),
                ), //TODO Replace with Settingsview
              );
              setState(() {
                tabKeyCount++;
              });
            },
            icon: const Icon(Icons.settings),
          ),
        ],
        elevation: 0,
      ),
      backgroundColor: CustomTheme.backgroundColor,
      body: tabs[currentIndex],
      extendBody: true,
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.only(bottom: 30),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: CustomTheme.primaryColor,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  NavbarItem(
                    index: 0,
                    isSelected: currentIndex == 0,
                    icon: Icons.home_rounded,
                    label: 'Home',
                    onTabTapped: onTabTapped,
                  ),
                  NavbarItem(
                    index: 1,
                    isSelected: currentIndex == 1,
                    icon: Icons.gamepad_rounded,
                    label: 'Games',
                    onTabTapped: onTabTapped,
                  ),
                  NavbarItem(
                    index: 2,
                    isSelected: currentIndex == 2,
                    icon: Icons.group_rounded,
                    label: 'Groups',
                    onTabTapped: onTabTapped,
                  ),
                  NavbarItem(
                    index: 3,
                    isSelected: currentIndex == 3,
                    icon: Icons.bar_chart_rounded,
                    label: 'Stats',
                    onTabTapped: onTabTapped,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  String _currentTabTitle() {
    switch (currentIndex) {
      case 0:
        return 'Home';
      case 1:
        return 'Game History';
      case 2:
        return 'Groups';
      case 3:
        return 'Statistics';
      default:
        return '';
    }
  }
}
