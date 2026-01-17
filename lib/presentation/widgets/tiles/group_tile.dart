import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/presentation/widgets/tiles/text_icon_tile.dart';

class GroupTile extends StatelessWidget {
  /// A tile widget that displays information about a group, including its name and members.
  /// - [group]: The group data to be displayed.
  /// - [isHighlighted]: Whether the tile should be highlighted.
  /// - [onTap]: An optional callback function to handle tap events.
  const GroupTile({super.key, required this.group, this.isHighlighted = false, this.onTap});

  /// The group data to be displayed.
  final Group group;

  /// Whether the tile should be highlighted.
  final bool isHighlighted;

  /// Callback function to handle tap events.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        margin: CustomTheme.standardMargin,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: isHighlighted
            ? CustomTheme.highlightedBoxDecoration
            : CustomTheme.standardBoxDecoration,
        duration: const Duration(milliseconds: 150),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    group.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${group.members.length}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 3),
                    const Icon(Icons.group, size: 22),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 12.0,
              runSpacing: 8.0,
              children: <Widget>[
                for (var member in [
                  ...group.members,
                ]..sort((a, b) => a.name.compareTo(b.name)))
                  TextIconTile(text: member.name, iconEnabled: false),
              ],
            ),
            const SizedBox(height: 2.5),
          ],
        ),
      ),
    );
  }
}
