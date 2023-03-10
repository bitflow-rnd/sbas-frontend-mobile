import 'package:flutter/material.dart';
import 'package:sbas/config/palette.dart';

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
}
