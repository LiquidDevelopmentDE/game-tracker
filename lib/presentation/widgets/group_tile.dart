import 'package:flutter/material.dart';
//import 'package:game_tracker/data/dto/group.dart';

class Group {
  final String id;
  final String name;
  final List<Player> members;

  Group({required this.id, required this.name, required this.members});
}

class Player {
  final String id;
  final String name;

  Player({required this.id, required this.name});
}

class GroupTile extends StatelessWidget {
  const GroupTile({super.key, required this.group});

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${group.name}", overflow: TextOverflow.ellipsis),
              Text("${group.members.length}"),
              Icon(Icons.group),
            ],
          ),
          Wrap(
            spacing: 8.0,
            runSpacing: -4.0,
            children: <Widget>[
              for (var member in group.members)
                Container(
                  color: Colors.grey,
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(member.name),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
