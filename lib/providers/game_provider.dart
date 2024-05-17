// ignore_for_file: prefer_final_fields

import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameProvider extends ChangeNotifier {
  final _audioPlayer = AudioPlayer();

  List<int> _soundSequence = [];
  List<int> _inputSequence = [];

  Map<int, bool> _buttonsClicked = {1: false, 2: false, 3: false, 4: false};

  bool _isGameOver = false;

  int _score = 0;
  int _highestScore = 0;

  void startGame() async {
    _score = 0;
    _soundSequence.clear();
    _isGameOver = false;
    loadMaxScore();
    nextSequence();
  }

  void checkSequence(int buttonIndex) {
    _inputSequence.add(buttonIndex);
    for (var i = 0; i < _inputSequence.length; i++) {
      if (_soundSequence[i] != _inputSequence[i]) {
        _isGameOver = true;
        notifyListeners();
        return;
      }
    }
    if (listEquals(_inputSequence, _soundSequence)) {
      _score++;
      if (_score > _highestScore) _highestScore = _score;
      saveMaxScore();
      Future.delayed(const Duration(seconds: 2), () {
        nextSequence();
      });
    }
  }

  void nextSequence() {
    _soundSequence.add(Random().nextInt(4) + 1);
    _inputSequence.clear();

    for (var index = 0; index < _soundSequence.length; index++) {
      Future.delayed(
        Duration(seconds: index),
        () async => await clickButton(_soundSequence[index]),
      );
    }
    notifyListeners();
  }

  Future clickButton(int buttonIndex) async {
    if (_audioPlayer.state == PlayerState.playing) await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('audio/$buttonIndex.mp3'));

    _buttonsClicked[buttonIndex] = !_buttonsClicked[buttonIndex]!;

    Future.delayed(const Duration(milliseconds: 500), () {
      _buttonsClicked[buttonIndex] = !_buttonsClicked[buttonIndex]!;
      notifyListeners();
    });
    notifyListeners();
  }

  void saveMaxScore() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("maxscore", _highestScore);
  }

  void loadMaxScore() async {
    final prefs = await SharedPreferences.getInstance();
    _highestScore = prefs.getInt("maxscore") ?? 0;
  }

  // ======================= Getters ======================
  int get score => _score;

  int get highestScore => _highestScore;

  Map get buttonsClicked => _buttonsClicked;

  bool get isGameOver => _isGameOver;

}


/*
Steps for a game:
1. Add one note to the sequence and play it
2. User input a sequence
3. Check with every input
4. If wrong input, Game Over
5. If right, repeat
*/ 