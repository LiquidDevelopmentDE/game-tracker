import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/presentation/widgets/tiles/group_tile.dart';

class ChooseGroupView extends StatefulWidget {
  final List<Group> groups;
  final int initialGroupIndex;

  const ChooseGroupView({
    super.key,
    required this.groups,
    required this.initialGroupIndex,
  });

  @override
  State<ChooseGroupView> createState() => _ChooseGroupViewState();
}

class _ChooseGroupViewState extends State<ChooseGroupView> {
  late int selectedGroupIndex;

  @override
  void initState() {
    selectedGroupIndex = widget.initialGroupIndex;
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
              selectedGroupIndex == -1
                  ? null
                  : widget.groups[selectedGroupIndex],
            );
          },
        ),
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
                if (selectedGroupIndex == index) {
                  selectedGroupIndex = -1;
                } else {
                  selectedGroupIndex = index;
                }
              });
            },
            child: GroupTile(
              group: widget.groups[index],
              isHighlighted: selectedGroupIndex == index,
            ),
          );
        },
      ),
    );
  }
}
