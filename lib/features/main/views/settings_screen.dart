import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/main/views/alert_settings_page.dart';
import 'package:sbas/features/main/views/app_permission_setting_screen.dart';
import 'package:sbas/features/main/views/user_data_handling_policy_screen.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      appBar: Bitflow.getAppBar(
        '설정',
        true,
        0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(children: [
            autoLoginRow(),
            Container(height: 1.h, color: Palette.diabledGrey),
            defaultRow('알림 수신', () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AlertSettingPage(),
                  ));
            }),
            Container(height: 1.h, color: Palette.diabledGrey),
            defaultRow('앱 권한 설정', () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AppPermissionSettingPage(),
                  ));
            }),
            Container(height: 1.h, color: Palette.diabledGrey),
            appVersionRow(),
            Container(height: 1.h, color: Palette.diabledGrey),
            defaultRow('오픈소스 라이선스', () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserDataHandlingPolicyPage(),
                  ));
            }),
          ]),
        ),
      ),
    );
  }

  Widget autoLoginRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Text(
            '자동 로그인',
            style: CTS(
              color: Palette.black,
              fontSize: 13,
            ),
          ),
          const Spacer(),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: Switch(
              key: ValueKey<bool>(true),
              value: true,
              onChanged: (value) {},
              activeColor: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }

  Widget defaultRow(String title, void Function()? function) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: InkWell(
        onTap: function,
        child: Row(
          children: [
            Text(
              title,
              style: CTS(
                color: Palette.black,
                fontSize: 13,
              ),
            ),
            const Spacer(),
            Image.asset(
              "assets/home/right_arrow.png",
              height: 12.h,
            )
          ],
        ),
      ),
    );
  }

  Widget appVersionRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Row(
        children: [
          Text(
            '앱 버전',
            style: CTS(
              color: Palette.black,
              fontSize: 13,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            margin: EdgeInsets.only(left: 10.w),
            decoration: BoxDecoration(
              color: Color(0xff538ef5).withOpacity(0.12),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              'v 1.2.2',
              style: CTS(
                color: Colors.blueAccent,
                fontSize: 13,
              ),
            ),
          ),
          const Spacer(),
          Text(
            '최신 버전 입니다.',
            style: CTS(
              color: Palette.greyText_80,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
