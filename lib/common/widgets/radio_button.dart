import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/common/bitflow_theme.dart';

Widget radioButton(WidgetRef ref, String text1, String text2, bool isSelected,
        int flex, Function function) =>
    Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffecedef).withOpacity(0.6),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => function(),
              child: Container(
                height: 35.h,
                width: 40.w,
                decoration: isSelected
                    ? BoxDecoration(
                        color: Palette.mainColor,
                        borderRadius: BorderRadius.circular(6),
                      )
                    : null,
                child: Center(
                  child: Text(
                    text1,
                    style: CTS.bold(
                      color: isSelected ? Colors.white : Palette.greyText_60,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => function(),
              child: Container(
                height: 35.h,
                width: 40.w,
                decoration: !isSelected
                    ? BoxDecoration(
                        color: Palette.mainColor,
                        borderRadius: BorderRadius.circular(6),
                      )
                    : null,
                child: Center(
                  child: Text(
                    text2,
                    style: CTS.bold(
                      color: !isSelected ? Colors.white : Palette.greyText_60,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
