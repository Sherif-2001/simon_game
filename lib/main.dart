import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:simon_game/pages/gameplay_page.dart';
import 'package:simon_game/pages/home_page.dart';
import 'package:simon_game/providers/game_provider.dart';

void main() {
  runApp(const MainApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameProvider(),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(scaffoldBackgroundColor: Colors.blueGrey[900]),
          routes: {
            HomePage.id: (context) => const HomePage(),
            GameplayPage.id: (context) => const GameplayPage()
          },
          home: const HomePage(),
        );
      },
    );
  }
}
