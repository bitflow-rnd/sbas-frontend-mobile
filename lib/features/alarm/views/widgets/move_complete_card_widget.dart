import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/features/alarm/views/widgets/image_icon_frag_widget.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';
import 'internal_frag_widget.dart';

Widget MoveCompleteCard(
    {required String dateTime,
      required String name,
      required String gender,
      required int age,
      required String departure,
      required String arrival,
      required String moveBy}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.h),
    padding: EdgeInsets.symmetric(horizontal: 24.w),
    child: IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                ImageIconFrag(
                    imgSrc: "assets/common_icon/req_icon_mask.png",
                    text: "이송완료"),
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: EdgeInsets.only(
                  left: 12.w, top: 16.h, bottom: 16.h, right: 12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12.r),
                    bottomRight: Radius.circular(12.r)),
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
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Text(
                              '바로가기',
                              style: CTS.medium(
                                color: Palette.mainColor,
                                fontSize: 12,
                              ),
                            ),
                            Image.asset(
                              "assets/home/righ_arrow_prime_icon.png",
                              height: 16.w,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '$name ($gender/$age세)',
                    style: CTS(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'SpoqaHanSansNeo',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  InternalFrag("출발", departure),
                  SizedBox(height: 6.h),
                  InternalFrag("도착", arrival),
                  SizedBox(height: 6.h),
                  InternalFrag("이송", moveBy)
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}