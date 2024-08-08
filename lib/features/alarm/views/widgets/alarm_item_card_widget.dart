import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';

Widget AlarmItemCard({
  required String title,
  required String body,
  required String dateTime,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.h),
    padding: EdgeInsets.symmetric(horizontal: 24.w),
    child: IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Container(
              padding: EdgeInsets.only(
                  left: 12.w, top: 16.h, bottom: 16.h, right: 12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1a645c5c),
                    offset: Offset(0, 3),
                    blurRadius: 12,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        dateTime,
                        style: CTS.medium(
                          color: Palette.greyText,
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '$title $body',
                    style: CTS(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'SpoqaHanSansNeo',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}