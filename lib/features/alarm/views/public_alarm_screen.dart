import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/notice/views/widgets/notice_header_widget.dart';
import 'package:sbas/features/notice/views/widgets/notice_list_widget.dart';

class PublicAlarmPage extends StatefulWidget {
  const PublicAlarmPage({super.key});

  @override
  State<PublicAlarmPage> createState() => PublicAlarmPageState();
}

class PublicAlarmPageState extends State<PublicAlarmPage> {
  List<String> dropdownList = ['최근1개월', '최근3개월', '최근1년'];
  String selectedDropdown = '최근1개월';
  bool hasAlarm = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.dividerGrey,
      appBar: AppBar(
        title: Text(
          "공지사항",
          style: CTS.medium(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        actions: [
          NoticeHeader(
            dropdownList: dropdownList,
            selectedDropdown: selectedDropdown,
            onDropdownChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedDropdown = value;
                });
              }
            },
          ),
        ],
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: hasAlarm
            ? _emptyPage()
            : SingleChildScrollView(
                child: NoticeListWidget(searchPeriod: selectedDropdown),
              ),
      ),
    );
  }

  _emptyPage() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/home/warn_icon.png',
                width: 100.w,
                // height: 200.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                '수신된 알림이 없습니다.',
                style: CTS.medium(
                  fontSize: 15,
                  color: Color(0xff676a7a),
                ),
              ),
              SizedBox(
                height: 100.h,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
