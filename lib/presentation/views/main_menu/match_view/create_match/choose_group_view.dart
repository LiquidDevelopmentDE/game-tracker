import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/presentation/widgets/text_input/custom_search_bar.dart';
import 'package:game_tracker/presentation/widgets/tiles/group_tile.dart';
import 'package:game_tracker/presentation/widgets/top_centered_message.dart';

class ChooseGroupView extends StatefulWidget {
  final List<Group> groups;
  final String initialGroupId;

  const ChooseGroupView({
    super.key,
    required this.groups,
    required this.initialGroupId,
  });

  @override
  State<ChooseGroupView> createState() => _ChooseGroupViewState();
}

class _ChooseGroupViewState extends State<ChooseGroupView> {
  late String selectedGroupId;
  final TextEditingController controller = TextEditingController();
  final String hintText = 'Group Name';
  late final List<Group> filteredGroups;

  @override
  void initState() {
    selectedGroupId = widget.initialGroupId;
    filteredGroups = [...widget.groups];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: CustomTheme.backgroundColor,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop(
              selectedGroupId == ''
                  ? null
                  : widget.groups.firstWhere(
                      (group) => group.id == selectedGroupId,
                    ),
            );
          },
        ),
        title: const Text(
          'Choose Group',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomSearchBar(
              controller: controller,
              hintText: hintText,
              onChanged: (value) {
                setState(() {
                  filterGroups(value);
                });
              },
            ),
          ),
          Expanded(
            child: Visibility(
              visible: filteredGroups.isNotEmpty,
              replacement: Visibility(
                visible: controller.text.isNotEmpty,
                replacement: const TopCenteredMessage(
                  icon: Icons.info,
                  title: 'Info',
                  message: 'You have no groups created yet',
                ),
                child: const TopCenteredMessage(
                  icon: Icons.info,
                  title: 'Info',
                  message: 'There is no group matching your search',
                ),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 85),
                itemCount: filteredGroups.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedGroupId != filteredGroups[index].id) {
                          selectedGroupId = filteredGroups[index].id;
                        } else {
                          selectedGroupId = '';
                        }
                      });
                    },
                    child: GroupTile(
                      group: filteredGroups[index],
                      isHighlighted:
                          selectedGroupId == filteredGroups[index].id,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Filters the groups based on the search query.
  /// TODO: Maybe implement also targetting player names?
  void filterGroups(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredGroups.clear();
        filteredGroups.addAll(widget.groups);
      } else {
        filteredGroups.clear();
        filteredGroups.addAll(
          widget.groups.where(
            (group) => group.name.toLowerCase().contains(query.toLowerCase()),
          ),
        );
      }
    });
  }
}
