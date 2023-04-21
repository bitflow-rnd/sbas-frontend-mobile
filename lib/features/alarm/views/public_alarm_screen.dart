import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/main/views/user_data_handling_policy_screen.dart';

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
          Container(
            margin: EdgeInsets.only(right: 16.w, top: 3.h, bottom: 3.h),
            height: 40.h,
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
              items: dropdownList.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: CTS(fontSize: 11, color: Palette.black),
                  ),
                );
              }).toList(),
              onChanged: (dynamic value) {
                setState(() {
                  selectedDropdown = value;
                });
              },
            ),
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: hasAlarm
              ? _emptyPage()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 6.h),
                      alertCard(
                          "제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.",
                          "내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및...",
                          "공지",
                          "2023.03.03",
                          true,
                          true),
                      alertCard(
                          "제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.",
                          "내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및...",
                          "뉴스",
                          "2023.03.03",
                          true,
                          true),
                      alertCard(
                          "제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.",
                          "내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및...",
                          "뉴스",
                          "2023.03.03",
                          false,
                          false),
                      alertCard(
                          "제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.",
                          "내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및...",
                          "공지",
                          "2023.03.03",
                          true,
                          false),
                      alertCard(
                          "제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.",
                          "내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및...",
                          "공지",
                          "2023.03.03",
                          false,
                          true),
                      alertCard(
                          "제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.",
                          "내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및...",
                          "공지",
                          "2023.03.03",
                          false,
                          true),
                      alertCard(
                          "제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.",
                          "내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및...",
                          "공지",
                          "2023.03.03",
                          false,
                          true),
                      alertCard(
                          "제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.",
                          "내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및...",
                          "공지",
                          "2023.03.03",
                          false,
                          true),
                      alertCard(
                          "제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.",
                          "내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및...",
                          "공지",
                          "2023.03.03",
                          false,
                          true),
                      alertCard(
                          "제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.",
                          "내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및...",
                          "공지",
                          "2023.03.03",
                          false,
                          true),
                    ],
                  ),
                ),
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

  Widget alertCard(String title, String body, String type, String datetime, bool isRead, bool hasFile) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1a645c5c),
                offset: Offset(0, 3),
                blurRadius: 12,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: CTS.bold(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      body,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: CTS(
                        color: Color(0xff676a7a),
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: Color(0xff676a7a).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            type,
                            style: CTS(
                              color: Color(0xff676a7a),
                              fontSize: 13,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          datetime,
                          style: CTS(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        hasFile
                            ? Padding(
                                padding: EdgeInsets.only(left: 6.r),
                                child: Image.asset("assets/home/paper-clip-icon-18.jpg", width: 13.w, height: 13.h),
                              )
                            : Container(),
                        SizedBox(width: 8.w),
                        Text(
                          isRead ? "NEW" : "",
                          style: CTS.medium(
                            color: Color(0xff538ef5),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20.w),
              Image.asset("assets/home/right_arrow.png"),
            ],
          ),
        ),
      ),
    );
  }
}
