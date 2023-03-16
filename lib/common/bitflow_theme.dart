import 'package:flutter/material.dart';

class Bitflow {
  static ThemeData getTheme() {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          color: Colors.black,
        ),
        titleLarge: TextStyle(
          color: Colors.black,
        ),
        titleMedium: TextStyle(
          color: Colors.black,
        ),
      ),
      primarySwatch: Colors.blue,
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData();
  }

  static AppBar getAppBar(String text) => AppBar(
        title: Text(
          text,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
      );
}
