import 'package:flutter/material.dart';
import 'package:sbas/config/palette.dart';

class BitflowTheme {
  static ThemeData get() {
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
