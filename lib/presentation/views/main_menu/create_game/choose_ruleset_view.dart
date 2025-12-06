import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/core/enums.dart';
import 'package:game_tracker/presentation/widgets/tiles/title_description_list_tile.dart';

class ChooseRulesetView extends StatefulWidget {
  final List<(Ruleset, String, String)> rulesets;
  final int initialRulesetIndex;

  const ChooseRulesetView({
    super.key,
    required this.rulesets,
    required this.initialRulesetIndex,
  });

  @override
  State<ChooseRulesetView> createState() => _ChooseRulesetViewState();
}

class _ChooseRulesetViewState extends State<ChooseRulesetView> {
  late int selectedRulesetIndex;

  @override
  void initState() {
    selectedRulesetIndex = widget.initialRulesetIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: CustomTheme.backgroundColor,
        appBar: AppBar(
          backgroundColor: CustomTheme.backgroundColor,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop(
                selectedRulesetIndex == -1
                    ? null
                    : widget.rulesets[selectedRulesetIndex].$1,
              );
            },
          ),
          title: const Text(
            'Choose Ruleset',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.only(bottom: 85),
          itemCount: widget.rulesets.length,
          itemBuilder: (BuildContext context, int index) {
            return TitleDescriptionListTile(
              onPressed: () async {
                setState(() {
                  if (selectedRulesetIndex == index) {
                    selectedRulesetIndex = -1;
                  } else {
                    selectedRulesetIndex = index;
                  }
                });
              },
              title: widget.rulesets[index].$2,
              description: widget.rulesets[index].$3,
              isHighlighted: selectedRulesetIndex == index,
            );
          },
        ),
      ),
    );
  }
}
