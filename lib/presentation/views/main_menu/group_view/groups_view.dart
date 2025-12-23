import 'package:flutter/material.dart';
import 'package:game_tracker/core/constants.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:game_tracker/presentation/views/main_menu/group_view/create_group_view.dart';
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
  late final AppDatabase db;
  late List<Group> loadedGroups;
  bool isLoading = true;

  List<Group> groups = List.filled(
    7,
    Group(
      name: 'Skeleton Group',
      members: List.filled(6, Player(name: 'Skeleton Player')),
    ),
  );

  @override
  void initState() {
    super.initState();
    db = Provider.of<AppDatabase>(context, listen: false);
    Future.wait([
      db.groupDao.getAllGroups(),
      Future.delayed(minimumSkeletonDuration),
    ]).then((results) {
      loadedGroups = results[0] as List<Group>;
      setState(() {
        groups = loadedGroups
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      });
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          AppSkeleton(
            enabled: isLoading,
            child: Visibility(
              visible: groups.isNotEmpty,
              replacement: const Center(
                child: TopCenteredMessage(
                  icon: Icons.info,
                  title: 'Info',
                  message: 'No groups created yet',
                ),
              ),
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
            ),
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
                  //_allGroupsFuture = db.groupDao.getAllGroups();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
