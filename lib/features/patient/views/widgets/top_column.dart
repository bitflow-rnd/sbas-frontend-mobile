import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';

Widget topColumn(int length) => Container(
  padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
  child: Column(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                style: CTS.bold(color: Palette.black),
                text: '조회결과 ',
                children: [
                  TextSpan(
                    text: ' $length',
                    style: CTS.bold(
                      color: const Color(0xFF00BFFF),
                    ),
                    children: [
                      TextSpan(
                        text: '명',
                        style: CTS.bold(
                          color: const Color(0xFF000000),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 32.h,
              width: 100.w,
              child: DropdownButtonFormField(
                borderRadius: BorderRadius.circular(4.r),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.greyText_30, width: 1),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.greyText_30, width: 1),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.greyText_30, width: 1),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                value: selectedDropdown,
                items: dropdownList
                    .map(
                      (item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: CTS(fontSize: 11, color: Palette.black),
                    ),
                  ),
                )
                    .toList(),
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      ),
    ],
  ),
);

const String selectedDropdown = '최근등록순';
final List<String> dropdownList = [
  '최근등록순',
  '최근3개월',
  '최근1년',
];