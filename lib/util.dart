import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/authentication/views/find_id_screen.dart';
import 'package:sbas/features/authentication/views/set_password_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension FutureExtension<T> on Future<T> {
  Future<T> load(BuildContext context) async {
    // showDialog(
    //   context: context,
    //   builder: (context) => const Center(
    //     child: SBASProgressIndicator(),
    //   ),
    //   barrierDismissible: false,
    // );
    // showDialog(context: context, builder: builder)

    final route = DialogRoute(
        context: context,
        builder: (_) => const Center(
              child: SBASProgressIndicator(),
            ),
        barrierDismissible: false);

    Navigator.of(context).push(route);
    then((value) => Navigator.of(context).removeRoute(route));
// close dialog

    return this;
    //   try {
    //     final result = await this;
    //     Navigator.pop(context); // Close the loading dialog
    //     return result;
    //   } catch (e) {
    //     Navigator.pop(context); // Close the loading dialog on error
    //     // Handle the error as needed
    //     throw e;
    //   } finally {
    //     Navigator.pop(context); // Close the loading dialog on error
    //     return this;
    //   }
    // }
  }
}

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

void showNotiSnack(ScaffoldMessengerState? state, String? title, String? body) {
  // switch (error) {
  //   default:
  //     if (kDebugMode) {
  //       print(error);
  //     }
  //     break;
  // }
  if (state == null) return;
  if (title != "" && title != null && body != null && body != "") {
    state.showSnackBar(SnackBar(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // 컨텐츠의 높이를 최소화하여 상하로 배치되도록 합니다.
        children: [
          Text(
            title,
            style: CTS(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0.h), // Title과 Body 사이의 간격 조정
          Text(body),
        ],
      ),
    ));
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

String getPhoneFormat(String? mpno) {
  if (mpno == null || mpno.isEmpty) {
    return '';
  }
  return mpno
      .replaceRange(3, 3, '-')
      .replaceRange(8, 8, '-')
      .replaceRange(4, 8, '****');
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

String format(int remainingTime) =>
    Duration(seconds: remainingTime).toString().substring(2, 7);

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

String getPtTypeCdNm(String ptTypeCd) {
  switch(ptTypeCd) {
    case 'PTTP0001':
      return '일반';
    case 'PTTP0002' :
      return '소아';
    case 'PTTP0003':
      return '투석';
    case 'PTTP0004':
      return '산모';
    case 'PTTP0005':
      return '수술';
    case 'PTTP0006':
      return '인공호흡기 사용';
    case 'PTTP0007':
      return '적극적 치료요청';
    case 'PTTP0008':
      return '신생아';
  }

  return '';
}

String formatDateTime(String dateTimeString) {
  final dateTime = DateTime.parse(dateTimeString);
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays > 0) {
    final formatter = DateFormat('yyyy.MM.dd');
    return formatter.format(dateTime);
  } else if (difference.inHours > 0) {
    return '${difference.inHours}시간 전';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes}분 전';
  } else {
    return '방금 전';
  }
}

String formatDateTimeForActivity(String dateTimeString) {
  final dateTime = DateTime.parse(dateTimeString);
  final formatter = DateFormat('yyyy년 M월 d일, a h시 m분', 'ko_KR');
  return formatter.format(dateTime);
}

String midMasking(String? userNm) {
  // 사용자 이름 첫 글자
  if (userNm == null) return "";
  String frsName = userNm.substring(0, 1);

  // 사용자 이름 중간 글자
  String midName = userNm.substring(1, userNm.length - 1);

  // 사용자 이름 중간 글자 마스킹
  String cnvMidName = '';
  for (int i = 0; i < midName.length; i++) {
    cnvMidName += '*'; // 중간 글자 수만큼 '*'로 표시
  }

  // 사용자 이름 마지막 글자
  String lstName = userNm.substring(userNm.length - 1);

  // 마스킹 완성된 사용자 이름
  String maskingName = frsName + cnvMidName + lstName;

  return maskingName;
}

String markTimeAgo(String? dtStr) {
  if (dtStr != null) {
    final dt = DateTime.tryParse(dtStr);

    if (dt != null) {
      final difference = DateTime.now().difference(dt);

      if (difference.inDays > 0) {
        return '${difference.inDays}일전';
      }
      if (difference.inHours > 0) {
        return '${difference.inHours}시간전';
      }
      if (difference.inMinutes > 0) {
        return '${difference.inMinutes}분전';
      }
      if (difference.inSeconds > 0) {
        return '${difference.inSeconds}초전';
      }
    }
  }
  return '';
}

const json = {'Content-Type': 'application/json'};

late SharedPreferences prefs;
