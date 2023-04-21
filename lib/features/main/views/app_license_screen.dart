import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/main/views/user_data_handling_policy_screen.dart';

class AppLicensePage extends StatefulWidget {
  const AppLicensePage({super.key});

  @override
  State<AppLicensePage> createState() => _AppLicensePageState();
}

class _AppLicensePageState extends State<AppLicensePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.dividerGrey,
      appBar: Bitflow.getAppBar(
        '오픈소스 라이선스',
        true,
        0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 1.h, color: Color(0xff676a7a).withOpacity(0.2)),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 42.h, horizontal: 50.w),
                child: Image.asset("assets/login_logo.png"),
              ),
              Text(
                "어플리케이션 권한 설정",
                style: CTS.medium(fontSize: 13, color: Palette.black),
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
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
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '저장소 접근',
                              style: CTS.medium(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              '허용',
                              style: CTS(
                                color: Colors.blueAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
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
                    Container(margin: EdgeInsets.symmetric(vertical: 20.h), height: 1.h, color: Color(0xff676a7a).withOpacity(0.2)),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '저장소 접근',
                              style: CTS.medium(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              '허용',
                              style: CTS(
                                color: Colors.blueAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
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
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                '※ 모두 허용해 주셔야 원활한 사용이 가능합니다',
                style: CTS(
                  color: Colors.black,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget alertDefaultRow() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
      color: Palette.white,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '앱 Push 알림',
                style: CTS(
                  color: Palette.black,
                  fontSize: 15,
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
          Row(
            children: [
              Text(
                '공지사항 및 병장 배정 관련 알림을 받을 수 있습니다.',
                style: CTS.medium(
                  color: Palette.greyText_80,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Image.asset(
                "assets/settings/alert_settings_info_icon.png",
                width: 12.w,
              ),
              Text(
                ' 2023. 03. 15 19:33',
                style: CTS.medium(
                  color: Palette.greyText_80,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              Text(
                '앱 Push 알림에 대한 수신동의',
                style: CTS.medium(
                  color: Palette.greyText_80,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget alertDefaultRow2() {
    return Container(
      color: Palette.white,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '문자 수신 동의',
                style: CTS(
                  color: Palette.black,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '문자(SMS) 수신 동의',
                style: CTS.medium(
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
          SizedBox(height: 12.h),
          Row(
            children: [
              Image.asset(
                "assets/settings/alert_settings_info_icon.png",
                width: 12.w,
              ),
              Text(
                ' 2023. 03. 15 19:33',
                style: CTS.medium(
                  color: Palette.greyText_80,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              Text(
                '문자 수신 동의',
                style: CTS.medium(
                  color: Palette.greyText_80,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
