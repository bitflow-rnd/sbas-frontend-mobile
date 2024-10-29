import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';

Widget internalFrag(String title, String body) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: Palette.greyText.withOpacity(0.12),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Text(
          title,
          style: CTS(
            color: Palette.greyText,
            fontSize: 12,
          ),
        ),
      ),
      SizedBox(width: 8.w),
      Text(
        body,
        style: CTS(
          color: Palette.greyText,
          fontSize: 12,
          fontFamily: 'SpoqaHanSansNeo',
        ),
      ),
    ],
  );
}