import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';

Widget ImageIconFrag({required String imgSrc, required String text}) {
  return Expanded(
    flex: 2,
    child: Column(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            decoration: BoxDecoration(
                color: Palette.mainColor.withOpacity(0.06),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    bottomLeft: Radius.circular(12.r))),
            child: Column(
              children: [
                Image.asset(
                  imgSrc,
                  height: 28.w,
                ),
                SizedBox(height: 4.h),
                Stack(
                  children: [
                    Text(
                      text,
                      style: CTS.medium(
                        color: Colors.black,
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      "입원입원",
                      style: CTS.medium(
                        color: Colors.transparent,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}