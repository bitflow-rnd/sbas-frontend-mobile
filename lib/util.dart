import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/authentication/views/find_id_screen.dart';
import 'package:sbas/features/authentication/views/set_password_screen.dart';
import 'package:sbas/features/lookup/models/patient_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showErrorSnack(
  BuildContext context,
  Object? error,
) {
  String message = '';

  switch (error) {
    default:
      if (kDebugMode) {
        print(error);
      }
      break;
  }
  if (message.isNotEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(
          milliseconds: 1750,
        ),
        content: Text(
          message,
        ),
      ),
    );
  }
}

void showToast(String msg) => Fluttertoast.showToast(
      msg: msg,
      backgroundColor: const Color(0xCF696969),
      fontSize: 14,
      toastLength: Toast.LENGTH_SHORT,
    );
void findId(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FindIdScreen(),
      ),
    );
Future setPassword(BuildContext context) async => await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const SetPasswordScreen(),
    ));

Color getStateColor(String? code) {
  switch (code) {
    case 'BAST0007':
      return const Color(0xFF00FF00);
    case 'BAST0006':
      return const Color(0xFF0000FF);
    case 'BAST0003':
      return const Color(0xFF00BFFF);
    case 'BAST0004':
      return const Color(0xFF000080);
    case 'BAST0005':
      return const Color(0xFF696969);
  }
  return const Color(0xFF8B8000);
}

int getAge(Patient? patient) {
  final birth = int.tryParse(patient?.rrno1?.substring(0, 2) ?? '') ?? 0;

  final year = (int.tryParse(patient?.rrno2 ?? '') ?? 0) > 2 ? 2000 : 1900;

  return DateTime.now().year - year - birth + 1;
}

String getPhoneFormat(String? mpno) {
  if (mpno == null || mpno.isEmpty) {
    return '';
  }
  return mpno.replaceRange(3, 3, '-').replaceRange(8, 8, '-').replaceRange(4, 8, '****');
}

String getDateTimeFormatFull(String dt) {
  final dateTime = DateTime.tryParse(dt)?.add(const Duration(
    hours: 9,
  ));
  return DateFormat('yyyy년 MM월 dd일 HH시 mm분').format(dateTime ?? DateTime.now());
}

String getDateTimeFormatDay(String dt) {
  final dateTime = DateTime.tryParse(dt)?.add(const Duration(
    hours: 9,
  ));
  return DateFormat('yyyy년 MM월 dd일').format(dateTime ?? DateTime.now());
}

//TODO 함수명 변경...
String getTimeLineDateFormat(String dt) {
  final dateTime = DateTime.tryParse(dt)?.add(const Duration(
    hours: 9,
  ));
  return DateFormat('aa h시 mm분').format(dateTime ?? DateTime.now());
}

String format(int remainingTime) => Duration(seconds: remainingTime).toString().substring(2, 7);

String toJson(Map<String, dynamic> map) => jsonEncode(map);

Map<String, dynamic> fromJson(String body) => jsonDecode(body);

Map<String, dynamic>? authToken;

Row getSubTitlt(String subTitle, bool isRequired) => Row(
      children: [
        Text(
          subTitle,
          style: CTS.medium(
            color: Colors.grey.shade600,
            fontSize: 13,
          ),
        ),
        Text(
          isRequired ? '' : '(필수)',
          style: CTS.medium(color: Palette.mainColor, fontSize: 13),
        ),
      ],
    );
InputDecoration getInputDecoration(String hintText) => InputDecoration(
      counterText: "",
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(4.r),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(4.r),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(4.r),
        ),
      ),
      hintText: hintText,
      hintStyle: CTS.regular(
        fontSize: 13.sp,
        color: Palette.greyText_60
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 22,
      ),
    );
const json = {'Content-Type': 'application/json'};

late SharedPreferences prefs;
