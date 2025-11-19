import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

Widget doubleRowInfoTile(
  String titleOneUpperLeft,
  String titleTwoUpperLeft,
  String titleUpperRight,
  String titleLowerLeft,
  String titleLowerRight,
) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: CustomTheme.secondaryColor,
    ),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 10,
              child: Text(
                '$titleOneUpperLeft $titleTwoUpperLeft',
                style: const TextStyle(fontSize: 20),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 3,
              child: Text(
                titleUpperRight,
                style: const TextStyle(fontSize: 20),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 10,
              child: Text(
                titleLowerLeft,
                style: const TextStyle(fontSize: 20),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 4,
              child: Text(
                titleLowerRight,
                style: const TextStyle(fontSize: 20),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
