import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/constants/palette.dart';

class Bitflow {
  static final defaultRadius = 9.2.r; //border radius
  static final radius_4 = 4.r; //border radius

  static MaterialColor myCustomMaterialColor = MaterialColor(Palette.mainColor.value, Palette.myCustomColorShades);

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
      primarySwatch: myCustomMaterialColor,
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
          style: CTS.medium(
            fontSize: 15,
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
      double? fontSize = 14,
      double? height = 1.36,
      FontWeight? fontWeight = FontWeight.w400})
      : super(color: color, fontFamily: fontFamily, fontSize: fontSize!.sp, height: height, fontWeight: fontWeight, decoration: decoration);

  CTS.thin({Color color = Colors.black, TextDecoration decoration = TextDecoration.none, double fontSize = 14, height})
      : this(decoration: decoration, color: color, fontSize: fontSize, fontWeight: FontWeight.w100, height: height);
  CTS.regular({Color color = Colors.black, TextDecoration decoration = TextDecoration.none, double fontSize = 14, height})
      : this(decoration: decoration, color: color, fontSize: fontSize, fontWeight: FontWeight.w300, height: height);
  CTS.light({Color color = Colors.black, TextDecoration decoration = TextDecoration.none, double fontSize = 14, height})
      : this(decoration: decoration, color: color, fontSize: fontSize, fontWeight: FontWeight.w400, height: height);
  CTS.medium({Color color = Colors.black, TextDecoration decoration = TextDecoration.none, double fontSize = 14, height})
      : this(decoration: decoration, color: color, fontSize: fontSize, fontWeight: FontWeight.w500, height: height);
  CTS.bold({Color color = Colors.black, TextDecoration decoration = TextDecoration.none, double fontSize = 14, height})
      : this(decoration: decoration, color: color, fontSize: fontSize, fontWeight: FontWeight.w700, height: height);
}
