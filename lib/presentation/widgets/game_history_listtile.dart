import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';

Widget GameHistoryListTile(currentGame){
  return  Container(
            margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: CustomTheme.secondaryColor,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("${currentGame['game']}: ", style: TextStyle(fontSize: 20)),
                    Text("${currentGame['title']}", style: TextStyle(fontSize: 20)),
                    Spacer(),
                    Text("${currentGame['players']} Spieler", style: TextStyle(fontSize: 20))
                  ],
                ),
                Row(
                  children: [
                    Text("${currentGame['group']}", style: TextStyle(fontSize: 20)),
                    Spacer(),
                    Text("${currentGame['date']}", style: TextStyle(fontSize: 20))
                  ],
                ),
              ],
            ),
          );
}