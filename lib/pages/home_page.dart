import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:simon_game/pages/gameplay_page.dart';
import 'package:simon_game/providers/game_provider.dart';
import 'package:simon_game/widgets/home_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static String id = "homepage";

  void showHowToPlayDialog(BuildContext context) {
    Alert(
      context: context,
      content: Consumer<GameProvider>(
        builder: (context, gameProvider, child) => Column(
          children: [
            const Divider(thickness: 2, color: Colors.white),
            Text(
              "Try to memorize the sequence of tones and repeat it to beat your high score",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20 / MediaQuery.of(context).textScaleFactor),
            ),
          ],
        ),
      ),
      desc: "How to Play",
      style: AlertStyle(
        isCloseButton: false,
        isButtonVisible: false,
        backgroundColor: Colors.black54,
        descStyle: TextStyle(
          color: Colors.white,
          fontSize: 30 / MediaQuery.of(context).textScaleFactor,
        ),
      ),
    ).show();
  }

  void showCreditsDialog(BuildContext context) {
    Alert(
      context: context,
      content: Consumer<GameProvider>(
        builder: (context, gameProvider, child) => Column(
          children: [
            const Divider(thickness: 2, color: Colors.white),
            Text(
              "Lead Programmer\nSherif\n\nThanks sherif for making this game",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20 / MediaQuery.of(context).textScaleFactor),
            ),
          ],
        ),
      ),
      desc: "Credits",
      style: AlertStyle(
        isCloseButton: false,
        isButtonVisible: false,
        backgroundColor: Colors.black54,
        descStyle: TextStyle(
          color: Colors.white,
          fontSize: 30 / MediaQuery.of(context).textScaleFactor,
        ),
      ),
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                "assets/images/icon.png",
              ),
              Consumer<GameProvider>(builder: (context, gameProvider, child) {
                return HomeButton(
                  buttonColor: Colors.red,
                  buttonText: "Start Game",
                  onPress: () {
                    Navigator.pushNamed(context, GameplayPage.id);
                    gameProvider.startGame();
                  },
                );
              }),
              HomeButton(
                buttonColor: Colors.blue,
                buttonText: "How to Play",
                onPress: () => showHowToPlayDialog(context),
              ),
              HomeButton(
                buttonColor: Colors.yellow.shade800,
                buttonText: "Credits",
                onPress: () => showCreditsDialog(context),
              ),
              HomeButton(
                buttonColor: Colors.green,
                buttonText: "Exit Game",
                onPress: () => SystemNavigator.pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
