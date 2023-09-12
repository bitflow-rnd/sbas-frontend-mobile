import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/alarm/views/public_alarm_screen.dart';
import 'package:sbas/features/assign/presenters/assign_bed_presenter.dart';
import 'package:sbas/features/assign/views/assign_bed_screen.dart';
import 'package:sbas/features/authentication/blocs/login_bloc.dart';
import 'package:sbas/features/authentication/blocs/user_detail_presenter.dart';
import 'package:sbas/features/main/views/service_policy_screen.dart';
import 'package:sbas/features/main/views/settings_screen.dart';
import 'package:sbas/features/main/views/user_data_handling_policy_screen.dart';
import 'package:sbas/features/messages/providers/talk_rooms_provider.dart';
import 'package:sbas/features/messages/views/direct_message_screen.dart';

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
                            ref.watch(userDetailProvider.notifier).userNm ?? "",
                            style: CTS.bold(
                              color: Palette.black,
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            ref.watch(userDetailProvider.notifier).instNm ?? "",
                            style: CTS.bold(
                              color: Palette.greyText,
                              fontSize: 13.sp,
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
                  _drawerItem("병상요청", "assets/auth_group/selected_request.png", ref.watch(assignCountProvider.notifier).state[0], "", context,
                      const AssignBedScreen(automaticallyImplyLeading: false), ref),
                  _drawerItem("배정승인", "assets/auth_group/selected_request.png", ref.watch(assignCountProvider.notifier).state[1], "", context,
                      const AssignBedScreen(automaticallyImplyLeading: false), ref),
                  _drawerItem("이송", "assets/auth_group/selected_request.png", ref.watch(assignCountProvider.notifier).state[2], "", context,
                      const AssignBedScreen(automaticallyImplyLeading: false), ref),
                  _drawerItem("입·퇴원", "assets/auth_group/selected_request.png", ref.watch(assignCountProvider.notifier).state[3], "", context,
                      const AssignBedScreen(automaticallyImplyLeading: false), ref),
                  Container(color: Palette.dividerGrey, height: 1.h),
                  _drawerItem("공지사항", "assets/auth_group/selected_request.png", null, "", context, PublicAlarmPage(), ref),
                  Container(color: Palette.dividerGrey, height: 1.h),
                  _drawerItem(
                      "내활동내역", "assets/auth_group/selected_request.png", null, "", context, const AssignBedScreen(automaticallyImplyLeading: false), ref),
                ],
              ),
            ),
            const Spacer(),
            TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith((states) => Palette.diabledGrey),
              ),
              onPressed: () async {
                // await ref.read(talkRoomsProvider.notifier).disconnect();
                await ref.read(loginProvider.notifier).logout(context);
                final container = ProviderContainer();
                container.dispose();
                // ref.invalidate(talkRoomsProvider);
                // ref.read(selecteTabProvider.notifier).state = 0;
              },
              child: Text(
                '로그아웃',
                style: CTS(fontSize: 12, color: Palette.greyText_60),
              ),
            ),
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
            Gaps.v24,
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(String title, String iconPath, int? count, String route, BuildContext context, dynamic page, WidgetRef ref) {
    return InkWell(
      onTap: count != null
          ? () async {
              int x = 0;
              switch (title) {
                case "병상요청":
                  x = 0;
                  break;
                case "배정승인":
                  x = 1;
                  break;
                case "이송":
                  x = 2;
                  break;
                case "입·퇴원":
                  x = 3;
                  break;
              }
              ref.read(assignBedProvider.notifier).setTopNavItem(x).then((value) => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => page),
                  ));
            }
          : () {
              //count 의 값이 Null 이 아닐 경우 병상 배정 페이지로 이동.

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return page;
                }),
              );
            },
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
            count != null && count != 0
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
