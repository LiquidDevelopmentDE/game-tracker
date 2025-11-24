import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:game_tracker/presentation/views/main_menu/create_group_view.dart';
import 'package:game_tracker/presentation/widgets/app_skeleton.dart';
import 'package:game_tracker/presentation/widgets/buttons/custom_width_button.dart';
import 'package:game_tracker/presentation/widgets/tiles/group_tile.dart';
import 'package:game_tracker/presentation/widgets/top_centered_message.dart';
import 'package:provider/provider.dart';

class GroupsView extends StatefulWidget {
  const GroupsView({super.key});

  @override
  State<GroupsView> createState() => _GroupsViewState();
}

class _GroupsViewState extends State<GroupsView> {
  late Future<List<Group>> _allGroupsFuture;
  late final AppDatabase db;

  final player = Player(name: 'Skeleton Player');
  late final List<Group> skeletonData = List.filled(
    7,
    Group(
      name: 'Skeleton Game',
      members: [player, player, player, player, player, player],
    ),
  );

  @override
  void initState() {
    super.initState();
    db = Provider.of<AppDatabase>(context, listen: false);
    _allGroupsFuture = Future.delayed(
      const Duration(milliseconds: 250),
      () => db.groupDao.getAllGroups(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          FutureBuilder<List<Group>>(
            future: _allGroupsFuture,
            builder:
                (BuildContext context, AsyncSnapshot<List<Group>> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: TopCenteredMessage(
                        icon: Icons.report,
                        title: 'Error',
                        message: 'Group data couldn\'t\nbe loaded.',
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done &&
                      (!snapshot.hasData || snapshot.data!.isEmpty)) {
                    return const Center(
                      child: TopCenteredMessage(
                        icon: Icons.info,
                        title: 'Info',
                        message: 'No groups created yet.',
                      ),
                    );
                  }
                  final bool isLoading =
                      snapshot.connectionState == ConnectionState.waiting;
                  final List<Group> groups =
                      isLoading ? skeletonData : (snapshot.data ?? [])
                        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
                  return AppSkeleton(
                    enabled: isLoading,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 85),
                      itemCount: groups.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == groups.length) {
                          return SizedBox(
                            height: MediaQuery.paddingOf(context).bottom - 20,
                          );
                        }
                        return GroupTile(group: groups[index]);
                      },
                    ),
                  );
                },
          ),

          Positioned(
            bottom: MediaQuery.paddingOf(context).bottom,
            child: CustomWidthButton(
              text: 'Create Group',
              sizeRelativeToWidth: 0.90,
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const CreateGroupView();
                    },
                  ),
                );
                setState(() {
                  _allGroupsFuture = db.groupDao.getAllGroups();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
