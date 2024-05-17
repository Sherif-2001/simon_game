import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  const HomeButton(
      {super.key,
      required this.onPress,
      required this.buttonColor,
      required this.buttonText});

  final VoidCallback onPress;
  final Color buttonColor;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.all(20)),
      child: Text(
        buttonText,
        style: const TextStyle(fontSize: 25),
      ),
    );
  }
}
