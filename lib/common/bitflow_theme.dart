import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Bitflow {
  static final defaultRadius = 9.2.r; //border radius
  static ThemeData getTheme() {
    return ThemeData(
      fontFamily: 'SpoqaHanSansNeo',
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
    return ThemeData(
      fontFamily: 'SpoqaHanSansNeo',
    );
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
            fontWeight: FontWeight.bold,
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

class CTS extends TextStyle {
  //Common Text Style
  CTS(
      {Color? color = Colors.black,
      fontFamily = 'SpoqaHanSansNeo',
      TextDecoration? decoration = TextDecoration.none,
      double? fontSize = 24,
      double? height = 1.34,
      FontWeight? fontWeight = FontWeight.w400})
      : super(color: color, fontFamily: fontFamily, fontSize: fontSize!.sp, height: height, fontWeight: fontWeight, decoration: decoration);

  CTS.thin({Color color = Colors.black, TextDecoration decoration = TextDecoration.none, double fontSize = 24})
      : this(decoration: decoration, color: color, fontSize: fontSize, fontWeight: FontWeight.w100, height: 1.36);
  CTS.regular({Color color = Colors.black, TextDecoration decoration = TextDecoration.none, double fontSize = 24})
      : this(decoration: decoration, color: color, fontSize: fontSize, fontWeight: FontWeight.w300, height: 1.36);
  CTS.light({Color color = Colors.black, TextDecoration decoration = TextDecoration.none, double fontSize = 24})
      : this(decoration: decoration, color: color, fontSize: fontSize, fontWeight: FontWeight.w400, height: 1.36);
  CTS.medium({Color color = Colors.black, TextDecoration decoration = TextDecoration.none, double fontSize = 24})
      : this(decoration: decoration, color: color, fontSize: fontSize, fontWeight: FontWeight.w500, height: 1.36);
  CTS.bold({Color color = Colors.black, TextDecoration decoration = TextDecoration.none, double fontSize = 24})
      : this(decoration: decoration, color: color, fontSize: fontSize, fontWeight: FontWeight.w700, height: 1.36);
}
