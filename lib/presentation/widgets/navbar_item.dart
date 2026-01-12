import 'package:flutter/material.dart';

/// A navigation bar item widget that represents a single tab in a navigation bar.
/// - [index]: The index of the tab.
/// - [isSelected]: A boolean indicating whether the tab is currently selected.
/// - [icon]: The icon to display for the tab.
/// - [label]: The label to display for the tab.
/// - [onTabTapped]: The callback to be invoked when the tab is tapped.
class NavbarItem extends StatefulWidget {
  const NavbarItem({
    super.key,
    required this.index,
    required this.isSelected,
    required this.icon,
    required this.label,
    required this.onTabTapped,
  });

  /// The index of the tab.
  final int index;

  /// A boolean indicating whether the tab is currently selected.
  final bool isSelected;

  /// The icon to display for the tab.
  final IconData icon;

  /// The label to display for the tab.
  final String label;

  /// The callback to be invoked when the tab is tapped.
  final Function(int) onTabTapped;

  @override
  State<NavbarItem> createState() => _NavbarItemState();
}

class _NavbarItemState extends State<NavbarItem> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => widget.onTabTapped(widget.index),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: widget.isSelected ? Colors.white : Colors.black,
              ),
              const SizedBox(height: 4),
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.isSelected ? Colors.white : Colors.black,
                  fontSize: 12,
                  fontWeight: widget.isSelected
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
