import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/main/views/user_data_handling_policy_screen.dart';

class AppPermissionSettingPage extends StatefulWidget {
  const AppPermissionSettingPage({super.key});

  @override
  State<AppPermissionSettingPage> createState() => _AppPermissionSettingPageState();
}

class _AppPermissionSettingPageState extends State<AppPermissionSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.dividerGrey,
      appBar: Bitflow.getAppBar(
        '앱 권한 설정',
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
                                color: Palette.mainColor,
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
                            activeColor: Palette.mainColor,
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
                                color: Palette.mainColor,
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
                            activeColor: Palette.mainColor,
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
}
