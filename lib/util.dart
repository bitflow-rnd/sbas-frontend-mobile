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

void showNotiSnack(BuildContext context, String? error) {
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

//
Color getStateColor(String? code) {
  switch (code) {
    case 'BAST0003':
      return const Color(0xFF67ccaa);
    case 'BAST0004':
      return const Color(0xFF4caff1);
    case 'BAST0005':
    case 'BAST0006':
      return const Color(0xFF4caff1);
    case 'BAST0007':
    case 'BAST0008':
      return const Color(0xFFff666e);
  }
  return const Color(0xFF8B8000);
}

// "승인대기":
// cdId: BAST0003
// cdNm: 승인대기
// rmk: 병상요청후 배정반 승인대기
//============================
// "배정대기":
// cdId: BAST0004
// cdNm: 배정대기
// rmk: 의료진 승인 대기
//============================
// "이송대기":
// cdId: BAST0005
// cdNm: 이송대기
// rmk: 없음
// "이송중":
// cdId: BAST0006
// cdNm: 이송중
// rmk: 입퇴원처리대기
//============================
// "완료":
// cdId: BAST0007
// cdNm: 완료
// rmk: 입퇴원처리완료

// "배정불가":
// cdId: BAST0008
// cdNm: 배정불가
// rmk: 배정불가처리완료

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
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Colors.red.shade300,
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
          color: Colors.red.shade300,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(4.r),
        ),
      ),
      hintText: hintText,
      hintStyle: CTS.regular(fontSize: 13.sp, color: Palette.greyText_60),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 14,
      ),
    );
const json = {'Content-Type': 'application/json'};

late SharedPreferences prefs;
