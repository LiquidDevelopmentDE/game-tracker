import 'package:flutter/material.dart';
import 'package:game_tracker/presentation/widgets/game_history_listtile.dart';

Widget GameHistoryEmptyBuilder(message) {
  return Container(
      padding: EdgeInsets.only(top:100),
      margin: EdgeInsets.only(left: 10, right: 10),
      alignment: Alignment.topCenter,
      child: Text(
        "$message", 
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
        )
    );
}