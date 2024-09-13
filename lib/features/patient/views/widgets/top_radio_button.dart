import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';

Widget topRadioButton() => Expanded(
  flex: 2,
  child: Row(
    children: [
      Expanded(
        child: Stack(
          children: [
            Positioned(
              right: 0,
              child: Container(
                height: 40.h,
                width: 52.w,
                decoration: BoxDecoration(
                  color: const Color(0xffecedef).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '   전체',
                  style: CTS.bold(
                    color: Palette.greyText_60,
                    fontSize: 11,
                  ),
                ).c,
              ),
            ),
            Container(
              height: 40.h,
              width: 52.w,
              decoration: BoxDecoration(
                color: Palette.mainColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '내조직',
                style: CTS.bold(
                  color: Colors.white,
                  fontSize: 11,
                ),
              ).c,
            ),
          ],
        ),
      ),
    ],
  ),
);