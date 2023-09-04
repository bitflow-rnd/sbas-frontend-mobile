import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => AlarmPageState();
}

class AlarmPageState extends State<AlarmPage> {
  List<String> dropdownList = ['최근1개월', '최근3개월', '최근1년'];
  String selectedDropdown = '최근1개월';
  bool hasAlarm = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.dividerGrey,
      appBar: AppBar(
        title: Text(
          "알림함",
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
        child: hasAlarm
            ? _emptyPage()
            : SingleChildScrollView(
                child: IntrinsicHeight(
                  child: Stack(children: [
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 14.w),
                    //   child: Column(children: [
                    //     Expanded(
                    //       child: CustomPaint(painter: DashedLineVerticalPainter(), size: const Size(1, double.infinity)),
                    //     ),
                    //   ]),
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 150.h,
                          child: Center(
                            child: Text("알림이 없습니다"),
                          ),
                        )
                        // dateFragment("2023년 2월"),
                        // moveCompleteCard(
                        //     dateTime: "02. 07 (화) 오전 11시 27분",
                        //     name: "김희순",
                        //     gender: "남",
                        //     age: 88,
                        //     departure: "영남대병원 (2/7  08:12)",
                        //     arrival: "칠곡경북대병원 (2/7  08:12)",
                        //     moveBy: "이동국 (대구 제2구급대)"),
                        // reqBed(
                        //     dateTime: "02. 07 (화) 오전 11시 27분",
                        //     name: "김희순",
                        //     gender: "남",
                        //     age: 88,
                        //     detail: "BO의 메세지 등록정보에 등록된 데이터가 그대로 노출됩니다. 이미지가 있는 경우 우측에 표시됩니다."),
                        // dateFragment("2023년 1월"),
                        // otherFrag(
                        //     dateTime: "02. 07 (화) 오전 11시 27분",
                        //     name: "김희순",
                        //     gender: "남",
                        //     age: 88,
                        //     detail: "BO의 메세지 등록정보에 등록된 데이터가 그대로 노출됩니다. 이미지가 있는 경우 우측에 표시됩니다.",
                        //     isApp: true),
                        // otherFrag(
                        //     dateTime: "02. 07 (화) 오전 11시 27분",
                        //     name: "김희순",
                        //     gender: "남",
                        //     age: 88,
                        //     detail: "BO의 메세지 등록정보에 등록된 데이터가 그대로 노출됩니다. 이미지가 있는 경우 우측에 표시됩니다.",
                        //     isApp: false),
                      ],
                    ),
                  ]),
                ),
              ),
      ),
    );
  }

  Widget otherFrag({required String dateTime, required String name, required String gender, required int age, required String detail, required bool isApp}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: IntrinsicHeight(
        child: Row(
          children: [
            if (isApp)
              imageIconFrag(imgSrc: "assets/common_icon/check_complete_icon.png", text: "배정승인")
            else
              // imageIconFrag(imgSrc: "assets/common_icon/check_complete_icon.png", text: "배정승인"),
              imageIconFrag(imgSrc: "assets/common_icon/to_hospital_icon.png", text: "    입원    "),
            Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.only(left: 12.w, top: 16.h, bottom: 16.h, right: 12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(12.r), bottomRight: Radius.circular(12.r)),
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
                            'BO의 메세지 등록정보에 등록된 데이터가 그대로 노출됩니다. 이미지가 있는 경우 우측에 표시됩니다.',
                            style: CTS(
                              color: Palette.greyText,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(),
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

  Widget reqBed({required String dateTime, required String name, required String gender, required int age, required String detail}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: IntrinsicHeight(
        child: Row(
          children: [
            imageIconFrag(imgSrc: "assets/common_icon/req_icon_mask.png", text: "병상요청"),
            Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.only(left: 12.w, top: 16.h, bottom: 16.h, right: 12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(12.r), bottomRight: Radius.circular(12.r)),
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
                            'BO의 메세지 등록정보에 등록된 데이터가 그대로 노출됩니다. 이미지가 있는 경우 우측에 표시됩니다.',
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

  Widget moveCompleteCard(
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
                children: [imageIconFrag(imgSrc: "assets/common_icon/req_icon_mask.png", text: "이송완료")],
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.only(left: 12.w, top: 16.h, bottom: 16.h, right: 12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(12.r), bottomRight: Radius.circular(12.r)),
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
                    internalFrag("출발", departure),
                    SizedBox(height: 6.h),
                    internalFrag("도착", arrival),
                    SizedBox(height: 6.h),
                    internalFrag("이송", moveBy)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget internalFrag(String title, String body) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: Palette.greyText.withOpacity(0.12),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Text(
            title,
            style: CTS(
              color: Palette.greyText,
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          body,
          style: CTS(
            color: Palette.greyText,
            fontSize: 12,
            fontFamily: 'SpoqaHanSansNeo',
          ),
        ),
      ],
    );
  }

  Widget _emptyPage() {
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
                  color: Palette.greyText,
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

  Widget dateFragment(String date) {
    return Container(
      padding: EdgeInsets.only(top: 18.h),
      margin: EdgeInsets.only(bottom: 6.h),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 9.w, right: 8.w),
            height: 10.w,
            width: 10.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.r),
              border: Border.all(
                color: Palette.greyText,
                width: 1.r,
              ),
            ),
          ),
          Image.asset(
            "assets/common_icon/calender_icon.png",
            height: 16.h,
            width: 16.w,
          ),
          SizedBox(width: 4.w),
          Text(
            date,
            style: CTS.medium(fontSize: 13, color: Palette.black),
          ),
        ],
      ),
    );
  }

  Widget imageIconFrag({required String imgSrc, required String text}) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
              decoration: BoxDecoration(
                  color: Palette.mainColor.withOpacity(0.06),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12.r), bottomLeft: Radius.circular(12.r))),
              child: Column(
                children: [
                  Image.asset(
                    imgSrc,
                    height: 28.w,
                  ),
                  SizedBox(height: 4.h),
                  Stack(
                    children: [
                      Text(
                        text,
                        style: CTS.medium(
                          color: Colors.black,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        "입원입원",
                        style: CTS.medium(
                          color: Colors.transparent,
                          fontSize: 11,
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
    );
  }
}

class DashedLineVerticalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 3, startY = 0;
    final paint = Paint()
      ..color = Palette.greyText.withOpacity(0.4)
      ..strokeWidth = 1;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
