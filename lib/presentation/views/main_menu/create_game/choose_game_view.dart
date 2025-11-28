import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/core/enums.dart';
import 'package:game_tracker/presentation/widgets/text_input/custom_search_bar.dart';
import 'package:game_tracker/presentation/widgets/tiles/title_description_list_tile.dart';

class ChooseGameView extends StatefulWidget {
  final List<(String, String, Ruleset)> games;
  final int initialGameIndex;

  const ChooseGameView({
    super.key,
    required this.games,
    required this.initialGameIndex,
  });

  @override
  State<ChooseGameView> createState() => _ChooseGameViewState();
}

class _ChooseGameViewState extends State<ChooseGameView> {
  late int selectedGameIndex;
  final TextEditingController searchBarController = TextEditingController();

  @override
  void initState() {
    selectedGameIndex = widget.initialGameIndex;
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
          'Choose Game',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CustomSearchBar(
            controller: searchBarController,
            hintText: 'Game Name',
          ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              itemCount: widget.games.length,
              itemBuilder: (BuildContext context, int index) {
                return TitleDescriptionListTile(
                  title: widget.games[index].$1,
                  description: widget.games[index].$2,
                  badgeText: translateRulesetToString(widget.games[index].$3),
                  isHighlighted: selectedGameIndex == index,
                  onPressed: () async {
                    setState(() {
                      selectedGameIndex = index;
                    });
                    Future.delayed(const Duration(milliseconds: 500), () {
                      if (!context.mounted) return;
                      Navigator.of(context).pop(selectedGameIndex);
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
