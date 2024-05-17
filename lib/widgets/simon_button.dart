import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simon_game/constants.dart';
import 'package:simon_game/providers/game_provider.dart';

class SimonButton extends StatelessWidget {
  final int buttonIndex;
  final VoidCallback onPressed;
  const SimonButton(
      {super.key, required this.buttonIndex, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        return GestureDetector(
          onTap: onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              boxShadow: gameProvider.buttonsClicked[buttonIndex]
                  ? [
                      BoxShadow(
                          color: buttonsProperties[buttonIndex]!["color"][300],
                          blurRadius: 20,
                          spreadRadius: 5)
                    ]
                  : null,
              color: buttonsProperties[buttonIndex]!["color"],
              borderRadius: buttonsProperties[buttonIndex]!["borderRadius"],
            ),
          ),
        );
      },
    );
  }
}
