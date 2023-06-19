import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/alarm/views/alarm_screen.dart';
import 'package:sbas/features/alarm/views/public_alarm_screen.dart';
import 'package:sbas/features/main/views/service_policy_screen.dart';
import 'package:sbas/features/main/views/settings_screen.dart';
import 'package:sbas/features/main/views/user_data_handling_policy_screen.dart';
import 'package:sbas/features/messages/views/direct_message_screen.dart';

import '../features/assign/views/assign_bed_screen.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      backgroundColor: Palette.diabledGrey,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 28.h),
              color: Palette.white,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/message/doctor_icon.png',
                        height: 44.h,
                        width: 44.w,
                        alignment: Alignment.topLeft,
                      ),
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '홍길동',
                            style: CTS.bold(
                              color: Palette.black,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            '병상배정반 / 대구광역시',
                            style: CTS.bold(
                              color: Palette.greyText,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        borderRadius: BorderRadius.circular(100.r),
                        onTap: () => settingsPage(context),
                        child: Image.asset(
                          'assets/setting_icon.png',
                          height: 32.h,
                          width: 32.w,
                          alignment: Alignment.topLeft,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Container(color: Palette.dividerGrey, height: 1.h),
                  _drawerItem("병상요청", "assets/auth_group/selected_request.png", 0, "", context, const AssignBedScreen(automaticallyImplyLeading: false)),
                  _drawerItem("배정승인", "assets/auth_group/selected_request.png", 5, "", context, const AssignBedScreen(automaticallyImplyLeading: false)),
                  _drawerItem("이송", "assets/auth_group/selected_request.png", 3, "", context, const AssignBedScreen(automaticallyImplyLeading: false)),
                  _drawerItem("입·퇴원", "assets/auth_group/selected_request.png", 1, "", context, const AssignBedScreen(automaticallyImplyLeading: false)),
                  Container(color: Palette.dividerGrey, height: 1.h),
                  _drawerItem("공지사항", "assets/auth_group/selected_request.png", null, "", context, PublicAlarmPage()),
                  Container(color: Palette.dividerGrey, height: 1.h),
                  _drawerItem("내활동내역", "assets/auth_group/selected_request.png", null, "", context, const AssignBedScreen(automaticallyImplyLeading: false)),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith((states) => Palette.diabledGrey),
                  ),
                  onPressed: () => servicePolicy(context),
                  child: Text(
                    '서비스이용약관',
                    style: CTS(fontSize: 12, color: Palette.greyText_60),
                  ),
                ),
                Container(height: 10.h, width: 1.2.w, color: Palette.greyText_60),
                TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith((states) => Palette.diabledGrey),
                  ),
                  onPressed: () => userDataPolicy(context),
                  child: Text(
                    '개인정보처리방침',
                    style: CTS(
                      fontSize: 12,
                      color: Palette.greyText_60,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'ⓒ 2023 Lemon Healthcare Inc. All rights reserved.',
              style: CTS(fontSize: 10, color: Palette.greyText_60),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(String title, String iconPath, int? count, String route, BuildContext context, dynamic page) {
    return InkWell(
      child: Container(
        // padding: count == null ? EdgeInsets.symmetric(vertical: 8.h) : null,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              height: 28.h,
              width: 28.w,
            ),
            SizedBox(width: 12.w),
            Text(
              title,
              style: CTS.bold(color: Palette.black, fontSize: 14),
            ),
            count != null
                ? Container(
                    margin: EdgeInsets.only(left: 8.w),
                    padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Palette.mainColor,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Text(
                      count.toString(),
                      style: CTS.bold(
                        color: Palette.white,
                        fontSize: 9,
                      ),
                    ),
                  )
                : Container(),
            const Spacer(),
            Image.asset(
              "assets/home/right_arrow.png",
              height: 10.h,
              width: 10.w,
            ),
          ],
        ),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return page;
        }),
      ),
    );
  }

  void servicePolicy(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ServicePolicyScreen(),
        ),
      );
  Future userDataPolicy(BuildContext context) async => await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UserDataHandlingPolicyPage(),
      ));
  Future settingsPage(BuildContext context) async => await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingPage(),
      ));
}
