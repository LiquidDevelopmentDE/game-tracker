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
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
      extendBody: true, // Enables floating effect
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 8.0),
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(24),
          color: CustomTheme.primaryColor,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _buildNavItem(Icons.home, 'Home', 0),
                  _buildNavItem(Icons.history, 'Games', 1),
                  _buildNavItem(Icons.groups, 'Groups', 2),
                  _buildNavItem(Icons.bar_chart, 'Stats', 3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
  final isSelected = currentIndex == index;

  return Expanded( // makes each nav item occupy equal width = large horizontal hitbox
    child: GestureDetector(
      onTap: () => onTabTapped(index),
      behavior: HitTestBehavior.opaque, // ensures the entire area is tappable
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0), // adds comfortable tap height
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.black,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
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
