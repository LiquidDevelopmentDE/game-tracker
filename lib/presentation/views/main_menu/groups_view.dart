import 'package:flutter/material.dart';
//import 'package:game_tracker/data/dto/group.dart';
//import 'package:game_tracker/data/dto/player.dart';
import 'package:game_tracker/presentation/widgets/full_width_button.dart';
import 'package:game_tracker/presentation/widgets/group_tile.dart';
import 'package:game_tracker/presentation/widgets/top_centered_message.dart';

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

class GroupsView extends StatefulWidget {
  const GroupsView({super.key});

  @override
  State<GroupsView> createState() => _GroupsViewState();
}

class _GroupsViewState extends State<GroupsView> {
  Future<List<Group>> _getMockGroups() async {
    await Future.delayed(const Duration(seconds: 1));
    final player1 = Player(id: 'p1', name: 'Felix');
    final player2 = Player(id: 'p2', name: 'Yannick');
    final player3 = Player(id: 'p3', name: 'Mathis');
    final player4 = Player(id: 'p4', name: 'Petrus');

    return [
      Group(
        id: 'g1',
        name: 'Weekend Warriors',
        members: [player1, player2, player4],
      ),
      Group(id: 'g2', name: 'Strategy Masters', members: [player3, player4]),
      Group(
        id: 'g3',
        name: 'The Cardboard Crew',
        members: [player1, player2, player3, player4],
      ),
      Group(id: 'g4', name: 'The Group', members: [player1, player3, player4]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: _getMockGroups(),
          builder: (BuildContext context, AsyncSnapshot<List<Group>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: TopCenteredMessage(
                  message: "Data not yet available, show sceleton",
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: TopCenteredMessage(
                  message: "Error while loading group data.",
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: TopCenteredMessage(message: "No groups created yet."),
              );
            }
            return GroupTile(group: snapshot.data![0]);
            //return ListView.builder()
          },
        ),
        FullWidthButton(text: "Create Group", onPressed: () {}),
      ],
    );
  }
}
