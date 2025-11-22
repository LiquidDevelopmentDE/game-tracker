import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_tracker/presentation/widgets/tiles/info_tile.dart';

class StatisticsTile extends StatelessWidget {
  const StatisticsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.width,
    required this.values,
    required this.itemCount,
    required this.barColor,
  });

  final IconData icon;
  final String title;
  final double width;
  final List<(String, int)> values;
  final int itemCount;
  final Color barColor;

  @override
  Widget build(BuildContext context) {
    final maxBarWidth = MediaQuery.of(context).size.width * 0.7;

    return InfoTile(
      width: width,
      title: title,
      icon: icon,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Visibility(
          visible: values.isNotEmpty,
          replacement: const Center(
            heightFactor: 4,
            child: Text('No data available.'),
          ),
          child: Column(
            children: List.generate(min(values.length, itemCount), (index) {
              /// The maximum wins among all players
              final maxGames = values.isNotEmpty ? values[0].$2 : 0;

              /// Fraction of wins
              final double fraction = (maxGames > 0)
                  ? (values[index].$2 / maxGames)
                  : 0.0;

              /// Calculated width for current the bar
              final double barWidth = maxBarWidth * fraction;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 24,
                          width: barWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: barColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            values[index].$1,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Center(
                      child: Text(
                        values[index].$2.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
