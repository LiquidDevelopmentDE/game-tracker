import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/core/enums.dart';

class ChooseRulesetView extends StatefulWidget {
  const ChooseRulesetView({super.key});

  @override
  State<ChooseRulesetView> createState() => _ChooseRulesetViewState();
}

class _ChooseRulesetViewState extends State<ChooseRulesetView> {
  List<(Ruleset, String, String)> rulesets = [
    (
      Ruleset.singleWinner,
      'Single Winner',
      'Exactly one winner is chosen; ties are resolved by a predefined tiebreaker.',
    ),
    (
      Ruleset.singleLoser,
      'Single Loser',
      'Exactly one loser is determined; last place receives the penalty or consequence.',
    ),
    (
      Ruleset.mostPoints,
      'Most Points',
      'Traditional ruleset: the player with the most points wins.',
    ),
    (
      Ruleset.lastPoints,
      'Least Points',
      'Inverse scoring: the player with the fewest points wins.',
    ),
  ];

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
        itemCount: rulesets.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => Navigator.of(context).pop(rulesets[index].$1),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: CustomTheme.boxColor,
                border: Border.all(color: CustomTheme.boxBorder),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          rulesets[index].$2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    rulesets[index].$3,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 2.5),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
