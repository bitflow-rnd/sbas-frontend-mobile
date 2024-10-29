import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/features/alarm/views/widgets/image_icon_frag_widget.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';

Widget reqBed(
    {required String dateTime,
      required String name,
      required String gender,
      required int age,
      required String detail}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.h),
    padding: EdgeInsets.symmetric(horizontal: 24.w),
    child: IntrinsicHeight(
      child: Row(
        children: [
          imageIconFrag(
              imgSrc: "assets/common_icon/req_icon_mask.png", text: "병상요청"),
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
                    style: CTS.medium(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Text(
                          'BO의 메시지 등록정보에 등록된 데이터가 그대로 노출됩니다. 이미지가 있는 경우 우측에 표시됩니다.',
                          style: CTS(
                            color: Palette.greyText,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: const Color(0xffecedef).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: const Text(
                            '\nDB\nImage',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff676a7a),
                              fontSize: 12,
                              fontFamily: 'SpoqaHanSansNeo',
                            ),
                          ),
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
    ),
  );
}