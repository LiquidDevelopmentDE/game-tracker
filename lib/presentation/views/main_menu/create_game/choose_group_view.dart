import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/presentation/widgets/tiles/group_tile.dart';

class ChooseGroupView extends StatefulWidget {
  final List<Group> groups;
  final int? selectedGroupIndex;

  const ChooseGroupView({
    super.key,
    required this.groups,
    this.selectedGroupIndex,
  });

  @override
  State<ChooseGroupView> createState() => _ChooseGroupViewState();
}

class _ChooseGroupViewState extends State<ChooseGroupView> {
  late int selectedGroup;

  @override
  void initState() {
    selectedGroup = widget.selectedGroupIndex ?? -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: CustomTheme.backgroundColor,
        scrolledUnderElevation: 0,
        title: const Text(
          'Choose Group',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 85),
        itemCount: widget.groups.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedGroup = index;
              });

              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.of(context).pop(widget.groups[index]);
              });
            },
            child: GroupTile(
              group: widget.groups[index],
              isHighlighted: selectedGroup == index,
            ),
          );
        },
      ),
    );
  }
}
