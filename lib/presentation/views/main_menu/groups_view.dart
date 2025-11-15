import 'package:flutter/material.dart';
//import 'package:game_tracker/data/dto/group.dart';
//import 'package:game_tracker/data/dto/player.dart';
import 'package:game_tracker/presentation/widgets/full_width_button.dart';
import 'package:game_tracker/presentation/widgets/group_tile.dart';
import 'package:game_tracker/presentation/widgets/top_centered_message.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
    await Future.delayed(const Duration(seconds: 4));
    final player1 = Player(id: 'p1', name: 'Felix');
    final player2 = Player(id: 'p2', name: 'Yannick');
    final player3 = Player(id: 'p3', name: 'Mathis');
    final player4 = Player(id: 'p4', name: 'Petrus');

    return [
      Group(
        id: 'g1',
        name: 'Weekend Warriors',
        members: [
          player1,
          player2,
          player4,
          player3,
          player1,
          player4,
          player2,
        ],
      ),
      Group(id: 'g2', name: 'Strategy Masters', members: [player3, player4]),
      Group(
        id: 'g3',
        name: 'The Cardboard Crew',
        members: [player1, player2, player3, player4],
      ),
      Group(
        id: 'g4',
        name: 'Gamers',
        members: [player1, player3, player1, player4],
      ),
      Group(
        id: 'g4',
        name: 'The Group',
        members: [player4, player1, player3, player4, player3],
      ),
      Group(
        id: 'g4',
        name: 'Friends',
        members: [player4, player1, player3, player4],
      ),
      Group(
        id: 'g4',
        name: 'Sample Group',
        members: [player1, player1, player4, player3],
      ),
      Group(
        id: 'g4',
        name: 'The Group',
        members: [player1, player1, player3, player4],
      ),
      Group(
        id: 'g4',
        name: 'The Best',
        members: [player1, player3, player1, player4, player1],
      ),
    ];
  }

  final player = Player(id: 'p1', name: 'Felix');
  late final List<Group> skeletonData = List.filled(
    7,
    Group(
      id: 'g1',
      name: 'Weekend Warriors',
      members: [player, player, player, player],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          FutureBuilder<List<Group>>(
            future: _getMockGroups(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Group>> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: TopCenteredMessage(
                        message: 'Error while loading group data.',
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done &&
                      (!snapshot.hasData || snapshot.data!.isEmpty)) {
                    return const Center(
                      child: TopCenteredMessage(
                        message: 'No groups created yet.',
                      ),
                    );
                  }
                  final bool isLoading =
                      snapshot.connectionState == ConnectionState.waiting;
                  final List<Group> groups = isLoading
                      ? skeletonData
                      : (snapshot.data ?? []);
                  return Skeletonizer(
                    effect: PulseEffect(
                      from: Colors.grey[100]!,
                      to: Colors.grey[400]!,
                      duration: const Duration(milliseconds: 800),
                    ),
                    enabled: isLoading,
                    enableSwitchAnimation: true,
                    switchAnimationConfig: const SwitchAnimationConfig(
                      duration: Duration(milliseconds: 200),
                      switchInCurve: Curves.linear,
                      switchOutCurve: Curves.linear,
                      transitionBuilder:
                          AnimatedSwitcher.defaultTransitionBuilder,
                      layoutBuilder: AnimatedSwitcher.defaultLayoutBuilder,
                    ),
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 85),
                      itemCount: groups.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GroupTile(group: groups[index]);
                      },
                    ),
                  );
                },
          ),

          // Dein Button bleibt wie gehabt
          Positioned(
            bottom: 16,
            right: 16,
            child: FullWidthButton(text: 'Create Group', onPressed: () {}),
          ),
        ],
      ),
    );
  }
}
