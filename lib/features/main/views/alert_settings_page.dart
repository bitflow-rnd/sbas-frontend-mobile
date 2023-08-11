import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';
class AlertSettingPage extends StatefulWidget {
  const AlertSettingPage({super.key});

  @override
  State<AlertSettingPage> createState() => _AlertSettingPageState();
}

class _AlertSettingPageState extends State<AlertSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.dividerGrey,
      appBar: Bitflow.getAppBar(
        '알림 수신',
        true,
        0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(children: [
          Container(
            height: 1.h,
            color: Color(0xff676a7a).withOpacity(0.2),
          ),
          alertDefaultRow(),
          Container(
            height: 1.h,
            color: Color(0xff676a7a).withOpacity(0.2),
          ),
          alertDefaultRow2(),
          Container(
            height: 1.h,
            color: Color(0xff676a7a).withOpacity(0.2),
          ),
        ]),
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
                  activeColor: Palette.mainColor,
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
                  activeColor: Palette.mainColor,
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
