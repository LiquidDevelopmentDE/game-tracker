import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/presentation/views/main_menu/game_history_view.dart';
import 'package:game_tracker/presentation/views/main_menu/groups_view.dart';
import 'package:game_tracker/presentation/views/main_menu/home_view.dart';
import 'package:game_tracker/presentation/views/main_menu/settings_view.dart';
import 'package:game_tracker/presentation/views/main_menu/statistics_view.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  final List<Widget> tabs = [
    const HomeView(),
    const GameHistoryView(),
    const GroupsView(),
    const StatisticsView(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _currentTabTitle(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: CustomTheme.backgroundColor,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsView()),
            ),
            icon: const Icon(Icons.settings),
          ),
        ],
        elevation: 0,
      ),
      backgroundColor: CustomTheme.backgroundColor,
      body: tabs[currentIndex],
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: CustomTheme.primaryColor,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        elevation: 10,
        height: 60,
        color: CustomTheme.primaryColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                color: currentIndex == 0 ? Colors.white : Colors.black,
              ),
              onPressed: () => onTabTapped(0),
            ),
            IconButton(
              icon: Icon(
                Icons.history,
                color: currentIndex == 1 ? Colors.white : Colors.black,
              ),
              onPressed: () => onTabTapped(1),
            ),
            const SizedBox(width: 40),
            IconButton(
              icon: Icon(
                Icons.groups,
                color: currentIndex == 2 ? Colors.white : Colors.black,
              ),
              onPressed: () => onTabTapped(2),
            ),
            IconButton(
              icon: Icon(
                Icons.bar_chart,
                color: currentIndex == 3 ? Colors.white : Colors.black,
              ),
              onPressed: () => onTabTapped(3),
            ),
          ],
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