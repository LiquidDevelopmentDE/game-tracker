import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/presentation/widgets/top_centered_message.dart';
import 'package:game_tracker/presentation/widgets/game_history_listtile.dart';

class GameHistoryView extends StatefulWidget {
  const GameHistoryView({super.key});

  @override
  State<GameHistoryView> createState() => _GameHistoryViewState();
}

class _GameHistoryViewState extends State<GameHistoryView> {
  final allGameData = [
    {
      'game': 'Schach',
      'title': 'Abendpartie',
      'players': 2,
      'group': 'Familie',
      'date': '01.06.2024',
    },
    {
      'game': 'Monopoly',
      'title': 'Wochenendspaß',
      'players': 4,
      'group': 'Freunde',
      'date': '28.05.2024',
    },
    {
      'game': 'Catan',
      'title': 'Strategieabend',
      'players': 3,
      'group': 'Brettspieler',
      'date': '25.05.2024',
    },
    {
      'game': 'Uno',
      'title': 'Schnelle Runde',
      'players': 5,
      'group': 'Kollegen',
      'date': '22.05.2024',
    },
    {
      'game': 'Poker',
      'title': 'Freitagspoker',
      'players': 6,
      'group': 'Pokerclub',
      'date': '20.05.2024',
    },
    {
      'game': 'Scrabble',
      'title': 'Wortschlacht',
      'players': 4,
      'group': 'Familie',
      'date': '18.05.2024',
    },
    {
      'game': 'Risiko',
      'title': 'Weltherrschaft',
      'players': 5,
      'group': 'Strategiegruppe',
      'date': '15.05.2024',
    },
    {
      'game': 'Zug um Zug',
      'title': 'Zug-Abenteuer',
      'players': 4,
      'group': 'Reisende',
      'date': '12.05.2024',
    },
    {
      'game': 'Carcassonne',
      'title': 'Plättchenlegen',
      'players': 3,
      'group': 'Brettspieler',
      'date': '10.05.2024',
    },
    {
      'game': 'Pandemie',
      'title': 'Welt retten',
      'players': 4,
      'group': 'Koop-Team',
      'date': '08.05.2024',
    },
    {
      'game': 'Cluedo',
      'title': 'Krimiabend',
      'players': 6,
      'group': 'Detektive',
      'date': '05.05.2024',
    },
    {
      'game': 'Dixit',
      'title': 'Fantasiespiel',
      'players': 5,
      'group': 'Künstler',
      'date': '02.05.2024',
    },
    {
      'game': 'Azul',
      'title': 'Plättchenmeister',
      'players': 4,
      'group': 'Familie',
      'date': '30.04.2024',
    },
    {
      'game': 'Splendor',
      'title': 'Edelsteinhändler',
      'players': 3,
      'group': 'Freunde',
      'date': '28.04.2024',
    },
    {
      'game': '7 Wonders',
      'title': 'Antike Reiche',
      'players': 7,
      'group': 'Geschichtsfreunde',
      'date': '25.04.2024',
    },
  ];
  late List<Map<String, dynamic>> suggestedGameData;

  @override
  void initState() {
    super.initState();
    suggestedGameData = List.from(allGameData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              Container(margin: EdgeInsets.only(bottom: 75)),
              Expanded(
                child: gameHistoryListView(allGameData, suggestedGameData),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            child: SearchBar(
              leading: Icon(Icons.search),
              onChanged: (value) {
                if (value.isEmpty) {
                  setState(() {
                    suggestedGameData.clear();
                    suggestedGameData.addAll(allGameData);
                  });
                  return;
                }
                final suggestions = allGameData.where((currentGame) {
                  return currentGame['game'].toString().toLowerCase().contains(
                        value.toLowerCase(),
                      ) ||
                      currentGame['title'].toString().toLowerCase().contains(
                        value.toLowerCase(),
                      ) ||
                      currentGame['group'].toString().toLowerCase().contains(
                        value.toLowerCase(),
                      );
                });
                setState(() {
                  suggestedGameData.clear();
                  suggestedGameData.addAll(suggestions);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget gameHistoryListView(allGameData, suggestedGameData) {
  if (suggestedGameData.isEmpty && allGameData.isEmpty) {
    return TopCenteredMessage("Keine Spiele erstellt");
  } else if (suggestedGameData.isEmpty) {
    return TopCenteredMessage("Kein Spiel mit den Suchparametern gefunden.");
  }
  return ListView.builder(
    itemCount: suggestedGameData.length,
    itemBuilder: (context, index) {
      final currentGame = suggestedGameData[index];
      return GameHistoryListTile(currentGame);
    },
  );
}
