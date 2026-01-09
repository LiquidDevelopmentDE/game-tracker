import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/l10n/generated/app_localizations.dart';
import 'package:game_tracker/presentation/views/main_menu/group_view/groups_view.dart';
import 'package:game_tracker/presentation/views/main_menu/home_view.dart';
import 'package:game_tracker/presentation/views/main_menu/match_view/match_view.dart';
import 'package:game_tracker/presentation/views/main_menu/settings_view.dart';
import 'package:game_tracker/presentation/views/main_menu/statistics_view.dart';
import 'package:game_tracker/presentation/widgets/navbar_item.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar>
    with SingleTickerProviderStateMixin {
  /// Currently selected tab index
  int currentIndex = 0;

  /// Key count to force rebuild of tab views
  int tabKeyCount = 0;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    // Pretty ugly but works
    final List<Widget> tabs = [
      KeyedSubtree(key: ValueKey('home_$tabKeyCount'), child: const HomeView()),
      KeyedSubtree(
        key: ValueKey('matches_$tabKeyCount'),
        child: const MatchView(),
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
          _currentTabTitle(context),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: CustomTheme.backgroundColor,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsView()),
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
                    label: loc.home,
                    onTabTapped: onTabTapped,
                  ),
                  NavbarItem(
                    index: 1,
                    isSelected: currentIndex == 1,
                    icon: Icons.gamepad_rounded,
                    label: loc.matches,
                    onTabTapped: onTabTapped,
                  ),
                  NavbarItem(
                    index: 2,
                    isSelected: currentIndex == 2,
                    icon: Icons.group_rounded,
                    label: loc.groups,
                    onTabTapped: onTabTapped,
                  ),
                  NavbarItem(
                    index: 3,
                    isSelected: currentIndex == 3,
                    icon: Icons.bar_chart_rounded,
                    label: loc.statistics,
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

  /// Handles tab tap events. Updates the current [index] state.
  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  /// Returns the title of the current tab based on [currentIndex].
  String _currentTabTitle(context) {
    final loc = AppLocalizations.of(context);
    switch (currentIndex) {
      case 0:
        return loc.home;
      case 1:
        return loc.matches;
      case 2:
        return loc.groups;
      case 3:
        return loc.statistics;
      default:
        return '';
    }
  }
}
