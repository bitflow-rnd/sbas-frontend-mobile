import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  static AppBar getAppBar(
    String text,
    bool automaticallyImplyLeading,
    double elevation,
  ) =>
      AppBar(
        title: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: automaticallyImplyLeading
            ? const BackButton(
                color: Colors.black,
              )
            : null,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        automaticallyImplyLeading: automaticallyImplyLeading,
        elevation: elevation,
      );
}
