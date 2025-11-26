import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/core/enums.dart';
import 'package:game_tracker/presentation/widgets/tiles/ruleset_list_tile.dart';

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
          title: const Text(
            'Choose Ruleset',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              color: CustomTheme.backgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: TabBar(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                // Label Settings
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                labelColor: Colors.white,
                unselectedLabelStyle: const TextStyle(fontSize: 14),
                unselectedLabelColor: Colors.white70,
                // Indicator Settings
                indicator: CustomTheme.standardBoxDecoration,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 1,
                indicatorPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
                // Divider Settings
                dividerHeight: 0,
                tabs: const [
                  Tab(text: 'Rulesets'),
                  Tab(text: 'Gametypes'),
                ],
              ),
            ),
            const Divider(
              indent: 30,
              endIndent: 30,
              thickness: 3,
              radius: BorderRadius.all(Radius.circular(12)),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView.builder(
                    padding: const EdgeInsets.only(bottom: 85),
                    itemCount: widget.rulesets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RulesetListTile(
                        onPressed: () async {
                          setState(() {
                            selectedRulesetIndex = index;
                          });
                          Future.delayed(const Duration(milliseconds: 500), () {
                            if (!context.mounted) return;
                            Navigator.of(
                              context,
                            ).pop(widget.rulesets[index].$1);
                          });
                        },
                        title: widget.rulesets[index].$2,
                        description: widget.rulesets[index].$3,
                        isHighlighted: selectedRulesetIndex == index,
                      );
                    },
                  ),
                  const Center(
                    child: Text(
                      'No gametypes available',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
