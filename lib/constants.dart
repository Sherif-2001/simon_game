import 'package:flutter/material.dart';

final Map<int, Map<String, dynamic>> buttonsProperties = {
  1: {
    "color": Colors.red,
    "borderRadius": const BorderRadius.only(bottomRight: Radius.circular(50))
  },
  2: {
    "color": Colors.blue,
    "borderRadius": const BorderRadius.only(bottomLeft: Radius.circular(50))
  },
  3: {
    "color": Colors.yellow,
    "borderRadius": const BorderRadius.only(topRight: Radius.circular(50))
  },
  4: {
    "color": Colors.green,
    "borderRadius": const BorderRadius.only(topLeft: Radius.circular(50))
  },
};
