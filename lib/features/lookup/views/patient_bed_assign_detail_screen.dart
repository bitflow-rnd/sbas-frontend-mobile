import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/app_bar_widget.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/patient/models/patient_model.dart';

class PatientBedAssignDetailPage extends ConsumerWidget {
  const PatientBedAssignDetailPage({
    required this.patient,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Palette.white,
      appBar: SBASAppBar(
        title: '타임라인',
        actions: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 8.h,
            ),
            margin: EdgeInsets.only(right: 16.w),
            child: InkWell(
              // onTap: () {},
              child: Image.asset(
                "assets/common_icon/share_icon.png",
                color: Palette.greyText_30,
                height: 24.h,
                width: 24.w,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Divider(
            color: Colors.grey,
            height: 1,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  dateFragment("2023년 2월 28일"),
                  IntrinsicHeight(
                    child: Stack(children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.w),
                        child: Column(children: [
                          Expanded(
                            child: CustomPaint(
                                painter: DashedLineVerticalPainter(),
                                size: const Size(1, double.infinity)),
                          ),
                        ]),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // timeline_approved
                        // timeline_bed_assign_complete
                        // timeline_go_hospital_complete
                        // timeline_move_complete
                        // timeline_refused
                        children: [
                          moveCompleteCard(
                            title: "승인",
                            dateTime: "오후 2시 33분",
                            src: "timeline_approved",
                            by: "대구광역시 병상배정반 / 팀장 / 홍성수",
                            detail: "병상배정이 완료되었습니다.",
                          ),
                          moveCompleteCard(
                            title: "배정불가",
                            dateTime: "오후 2시 33분",
                            src: "timeline_refused",
                            by: "대구광역시 병상배정반 / 팀장 / 홍성수",
                            detail: "병상배정이 완료되었습니다.",
                          ),
                          moveCompleteCard(
                              title: "배정완료",
                              dateTime: "오후 2시 33분",
                              src: "timeline_bed_assign_complete",
                              by: "대구광역시 병상배정반 / 팀장 / 홍성수",
                              detail: "병상배정이 완료되었습니다."),
                          moveCompleteCard(
                            title: "이송완료",
                            dateTime: "오후 2시 33분",
                            src: "timeline_move_complete",
                            by: "대구광역시 병상배정반 / 팀장 / 홍성수",
                            detail: "병상배정이 완료되었습니다.",
                            isBlue: true,
                          ),
                          moveCompleteCard(
                            title: "입원완료",
                            dateTime: "오후 2시 33분",
                            src: "timeline_go_hospital_complete",
                            by: "대구광역시 병상배정반 / 팀장 / 홍성수",
                            detail: "병상배정이 완료되었습니다.",
                          ),
                        ],
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget moveCompleteCard(
      {required String title,
      required String dateTime,
      required String src,
      required String by,
      required String detail,
      bool isBlue = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.only(left: 16.w, right: 24.w),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Column(
              children: [imageIconFrag(imgSrc: "assets/common_icon/$src.png")],
            ),
            Expanded(
              flex: 7,
              child: Container(
                margin: EdgeInsets.only(left: 12.w),
                padding: EdgeInsets.only(
                    left: 12.w, top: 16.h, bottom: 16.h, right: 12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
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
                          title,
                          style: CTS.medium(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            dateTime,
                            style: CTS.medium(
                              color: Palette.greyText,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      by,
                      style: CTS(
                        color: Palette.greyText,
                        fontSize: 13,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8.h),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: isBlue
                            ? Palette.mainColor.withOpacity(0.16)
                            : const Color(0xff676a7a).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        detail,
                        style: CTS(
                          color: isBlue ? Palette.mainColor : Palette.greyText,
                          fontSize: 13,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget imageIconFrag({required String imgSrc}) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Image.asset(
                  imgSrc,
                  height: 32.w,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget dateFragment(String date) {
    return Container(
      padding: EdgeInsets.only(top: 20.h),
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            date,
            style: CTS.bold(color: Palette.black),
          ).c,
        ],
      ),
    );
  }

  final Patient patient;
}

class DashedLineVerticalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 2, dashSpace = 2, startY = 0;
    final paint = Paint()
      ..color = Palette.mainColor.withOpacity(0.4)
      ..strokeWidth = 1;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
