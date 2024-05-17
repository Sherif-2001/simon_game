import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:simon_game/pages/home_page.dart';
import 'package:simon_game/providers/game_provider.dart';
import 'package:simon_game/widgets/simon_button.dart';

class GameplayPage extends StatelessWidget {
  const GameplayPage({super.key});

  static String id = "gameplay";

  void showGameOverDialog(BuildContext context) {
    Alert(
      context: context,
      onWillPopActive: true,
      content: Consumer<GameProvider>(
        builder: (context, gameProvider, child) => Column(
          children: [
            const Divider(thickness: 2, color: Colors.white),
            Text(
              "Score: ${gameProvider.score}\nMax Score: ${gameProvider.highestScore}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20 / MediaQuery.of(context).textScaleFactor),
            ),
          ],
        ),
      ),
      desc: "Game Over",
      buttons: [
        DialogButton(
          onPressed: () => Navigator.popUntil(context,
              (route) => route.isFirst || route.settings.name == HomePage.id),
          color: Colors.white,
          child: const Text("Return Home"),
        )
      ],
      style: AlertStyle(
        isCloseButton: false,
        backgroundColor: Colors.black54,
        descStyle: TextStyle(
          color: Colors.red,
          fontSize: 35 / MediaQuery.of(context).textScaleFactor,
        ),
      ),
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Consumer<GameProvider>(
          builder: (context, gameProvider, child) {
            return Text(
              "Highest Score\n${gameProvider.highestScore}",
              textAlign: TextAlign.center,
            );
          },
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(15),
          constraints: BoxConstraints.expand(
              height: screenSize.width - 30, width: screenSize.width - 30),
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Colors.blueGrey[700]),
          child: Stack(
            children: [
              Consumer<GameProvider>(
                builder: (context, gameProvider, child) {
                  return ClipOval(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) => SimonButton(
                        buttonIndex: index + 1,
                        onPressed: () async {
                          await gameProvider.clickButton(index + 1);
                          gameProvider.checkSequence(index + 1);
                          if (gameProvider.isGameOver) {
                            showGameOverDialog(context);
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[700],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Consumer<GameProvider>(
                        builder: (context, gameProvider, child) {
                      return Text(
                        "Score\n${gameProvider.score}",
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      );
                    }),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
