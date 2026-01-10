import 'package:flutter/material.dart';
import 'package:game_tracker/core/adaptive_page_route.dart';
import 'package:game_tracker/core/constants.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/data/db/database.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:game_tracker/l10n/generated/app_localizations.dart';
import 'package:game_tracker/presentation/views/main_menu/group_view/group_detail_view.dart';
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

  /// Loaded groups from the database
  late List<Group> loadedGroups;

  /// Loading state
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
    loadGroups();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          AppSkeleton(
            enabled: isLoading,
            child: Visibility(
              visible: groups.isNotEmpty,
              replacement: Center(
                child: TopCenteredMessage(
                  icon: Icons.info,
                  title: loc.info,
                  message: loc.no_groups_created_yet,
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
                  return GroupTile(group: groups[index], onTap: () async {
                    await Navigator.push(
                      context,
                      adaptivePageRoute(
                        builder: (context) {
                          return GroupDetailView(groupToEdit: groups[index]);
                        },
                      ),
                    );
                    setState(() {
                      loadGroups();
                    });
                  });
                },
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.paddingOf(context).bottom,
            child: CustomWidthButton(
              text: loc.create_group,
              sizeRelativeToWidth: 0.90,
              onPressed: () async {
                await Navigator.push(
                  context,
                  adaptivePageRoute(
                    builder: (context) {
                      return const GroupDetailView();
                    },
                  ),
                );
                setState(() {
                  loadGroups();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void loadGroups() {
    Future.wait([
      db.groupDao.getAllGroups(),
      Future.delayed(Constants.minimumSkeletonDuration),
    ]).then((results) {
      loadedGroups = results[0] as List<Group>;
      setState(() {
        groups = loadedGroups
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      });
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }
}
