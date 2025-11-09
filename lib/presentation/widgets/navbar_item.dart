import 'package:flutter/material.dart';

class NavbarItem extends StatefulWidget {
  final int index;
  final bool isSelected;
  final IconData icon;
  final String label;
  final Function(int) onTabTapped;

  const NavbarItem({
    super.key,
    required this.index,
    required this.isSelected,
    required this.icon,
    required this.label,
    required this.onTabTapped,
  });

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
