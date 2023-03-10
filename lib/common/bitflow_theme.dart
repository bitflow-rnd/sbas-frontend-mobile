import 'package:flutter/material.dart';
import 'package:sbas/constants/palette.dart';

class Bitflow {
  static ThemeData getTheme() {
    return ThemeData(
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          color: Palette.textColor1,
        ),
      ),
      primarySwatch: Colors.blue,
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData();
  }
}
