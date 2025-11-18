import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/presentation/widgets/tiles/text_icon_tile.dart';

class GroupTile extends StatelessWidget {
  const GroupTile({super.key, required this.group});

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: CustomTheme.boxColor,
        border: Border.all(color: CustomTheme.boxBorder),
        borderRadius: BorderRadius.circular(12),
      ),
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
              for (var member in group.members) TextIconTile(text: member.name),
            ],
          ),
          const SizedBox(height: 2.5),
        ],
      ),
    );
  }
}
