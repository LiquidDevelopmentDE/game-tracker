import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/presentation/widgets/buttons/custom_width_button.dart';

class GameResultView extends StatefulWidget {
  const GameResultView({super.key});

  //TODO: Handle given game

  @override
  State<GameResultView> createState() => _GameResultViewState();
}

class _GameResultViewState extends State<GameResultView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: CustomTheme.backgroundColor,
        scrolledUnderElevation: 0,
        title: const Text(
          'Game Result',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: CustomTheme.boxColor,
            border: Border.all(color: CustomTheme.boxBorder),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Select Winner",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //TODO: Add FutureBuilder
              //TODO: Implement ListView.builder with RadioListTiles and Players from Game
              //TODO Implement Save button with snackbar to confirm save/show error
              CustomWidthButton(text: "Save", sizeRelativeToWidth: 0.95),
            ],
          ),
        ),
      ),
    );
  }
}
