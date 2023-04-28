import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/bottom_sub_position_btn_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/messages/views/direct_message_screen.dart';

class ContactDetailScreen extends StatefulWidget {
  final Contract contact;

  const ContactDetailScreen({
    Key? key,
    required this.contact,
  }) : super(key: key);

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  // @override
  // void initState() {
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 243, 243, 243),

      body: Stack(
        children: [
          AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
            ),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            foregroundColor: Colors.transparent,
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () => print('asdf'),
                icon: const Icon(
                  Icons.star_border_sharp,
                  color: Color(0xFF696969),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Image.asset("assets/message/hospital_image.png"),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/message/doctor_icon.png",
                      height: 44.h,
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.contact.name,
                          style: CTS.bold(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        Gaps.v6,
                        Text(
                          widget.contact.organization,
                          style: CTS(
                            color: Palette.greyText_80,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Divider(thickness: 1, height: 1, color: Palette.greyText_20),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '휴대폰번호',
                          style: CTS.medium(
                            color: Palette.greyText_80,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          widget.contact.phone,
                          style: CTS(
                            color: Palette.black,
                            fontSize: 13,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                                padding: EdgeInsets.all(5.r),
                                margin: EdgeInsets.only(right: 8.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Palette.greyText_20,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Icon(Icons.message_rounded, color: Palette.black, size: 16.r)),
                            Container(
                              padding: EdgeInsets.all(5.r),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Palette.greyText_20,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Icon(Icons.phone, color: Palette.greyText_80, size: 16.r),
                            ),
                          ],
                        )
                      ],
                    ),
                    Gaps.v20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '직장전화번호',
                          style: CTS.medium(
                            color: Palette.greyText_80,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          widget.contact.phone,
                          style: CTS(
                            color: Palette.black,
                            fontSize: 13,
                          ),
                        ),
                        Row(
                          children: [
                            Gaps.h48,
                            Container(
                              padding: EdgeInsets.all(5.r),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Palette.greyText_20,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Icon(Icons.phone, color: Palette.greyText_80, size: 16.r),
                            ),
                          ],
                        )
                      ],
                    ),
                    Gaps.v20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '담당환자 유형',
                          style: CTS.medium(
                            color: Palette.greyText_80,
                            fontSize: 13,
                          ),
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Palette.greyText_20,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(13.5.r),
                                  ),
                                  child: Text(
                                    '임산부',
                                    style: CTS(
                                      color: Palette.greyText,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Gaps.h10,
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Palette.greyText_20,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(13.5.r),
                              ),
                              child: Text(
                                '신생아',
                                style: CTS(
                                  color: Palette.greyText,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Gaps.h10,
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Palette.greyText_20,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(13.5.r),
                              ),
                              child: Text(
                                '응급',
                                style: CTS(
                                  color: Palette.greyText,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Gaps.v20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '세부권한',
                          style: CTS.medium(
                            color: Palette.greyText_80,
                            fontSize: 13,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Palette.greyText_20,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(13.5.r),
                              ),
                              child: Text(
                                '일반',
                                style: CTS(
                                  color: Palette.greyText,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SafeArea(
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                          vertical: 13.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Palette.greyText_80,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          "반려",
                          style: CTS.bold(
                            color: Palette.greyText_80,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  )),
                  Expanded(
                      child: BottomPositionedSubmitButton(
                          function: () {
                            Navigator.pop(context, widget.contact);
                          },
                          text: "승인")),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
