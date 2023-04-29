import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/lookup/models/patient_info_model.dart';

class AssignBedDetailTimeLine extends ConsumerWidget {
  const AssignBedDetailTimeLine({
    super.key,
    required this.patient,
  });
  final Patient patient;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Column(
        children: [
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
                            child: CustomPaint(painter: DashedLineVerticalPainter(), size: const Size(1, double.infinity)),
                          ),
                        ]),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // timeline_approved
                        // timeline_bed_assign_complete
                        // timeline_go_hosipital_complete
                        // timeline_move_complete
                        // timeline_refused
                        // timeline_go_home
                        //
                        //timeline_suspend
                        children: [
                          if (patient.bedStatNm == '승인대기')
                            Column(
                              children: [
                                completeCard(
                                  title: "승인",
                                  dateTime: "오후 2시 33분",
                                  src: "timeline_approved",
                                  by: "대구광역시 병상배정반 / 팀장 / 홍성수",
                                  detail: "병상배정이 완료되었습니다.",
                                ),
                                suspendCard(
                                  title: "승인대기",
                                  src: "timeline_suspend",
                                  detail: "대구광역시 병상배정반",
                                ),
                                closedCard(
                                  title: "승인대기",
                                  src: "timeline_bed_assign_complete",
                                ),
                                closedCard(
                                  title: "이송",
                                  src: "timeline_bed_assign_complete",
                                ),
                                closedCard(
                                  title: "입원",
                                  src: "timeline_bed_assign_complete",
                                ),
                              ],
                            ),
                          if (patient.bedStatNm == '배정대기')
                            Column(
                              children: [
                                completeCard(
                                  title: "승인",
                                  dateTime: "오후 2시 33분",
                                  src: "timeline_approved",
                                  by: "대구광역시 병상배정반 / 팀장 / 홍성수",
                                  detail: "병상배정이 완료되었습니다.",
                                ),
                                completeCard(
                                  title: "배정불가",
                                  dateTime: "오후 2시 33분",
                                  src: "timeline_refused",
                                  by: "대구광역시 병상배정반 / 팀장 / 홍성수",
                                  detail: "병상배정이 완료되었습니다.",
                                ),
                                suspendCard(
                                  title: "배정대기(읍압격리)",
                                  src: "timeline_suspend",
                                  detail: "대구 칠곡경북대병원/감염내과/김감염",
                                ),
                                closedCard(
                                  title: "이송",
                                  src: "timeline_bed_assign_complete",
                                ),
                                closedCard(
                                  title: "입원",
                                  src: "timeline_bed_assign_complete",
                                ),
                              ],
                            ),
                          if (patient.bedStatNm == '이송대기')
                            Column(
                              children: [
                                completeCard(
                                  title: "승인",
                                  dateTime: "오후 2시 33분",
                                  src: "timeline_approved",
                                  by: "대구광역시 병상배정반 / 팀장 / 홍성수",
                                  detail: "병상배정이 완료되었습니다.",
                                ),
                                completeCard(
                                  title: "배정불가",
                                  dateTime: "오후 2시 33분",
                                  src: "timeline_refused",
                                  by: "대구광역시 병상배정반 / 팀장 / 홍성수",
                                  detail: "가능한 음압격리 병실이 없습니다.",
                                ),
                                completeCard(
                                    title: "배정완료",
                                    dateTime: "오후 2시 33분",
                                    src: "timeline_bed_assign_complete",
                                    by: "대구의료원 / 신경내과 / 강성일",
                                    detail: "도착 5분전 전화 주시면 나가 있겠습니다."),
                                suspendCard(
                                  title: "이송대기",
                                  src: "timeline_suspend",
                                  // detail: "",
                                ),
                                closedCard(
                                  title: "입원",
                                  src: "timeline_go_hosipital_complete",
                                ),
                              ],
                            ),
                          if (patient.bedStatNm == '이송중')
                            Column(
                              children: [
                                completeCard(
                                  title: "승인",
                                  dateTime: "오후 2시 33분",
                                  src: "timeline_approved",
                                  by: "대구광역시 병상배정반 / 팀장 / 홍성수",
                                  detail: "병상배정이 완료되었습니다.",
                                ),
                                completeCard(
                                  title: "배정불가",
                                  dateTime: "오후 2시 33분",
                                  src: "timeline_refused",
                                  by: "대구광역시 병상배정반 / 팀장 / 홍성수",
                                  detail: "가능한 음압격리 병실이 없습니다.",
                                ),
                                completeCard(
                                    title: "배정완료",
                                    dateTime: "오후 2시 33분",
                                    src: "timeline_bed_assign_complete",
                                    by: "대구의료원 / 신경내과 / 강성일",
                                    detail: "도착 5분전 전화 주시면 나가 있겠습니다."),
                                completeCard(
                                    title: "이송중",
                                    dateTime: "오후 2시 33분",
                                    src: "timeline_suspend",
                                    by: "대구광역시 중부 대명 구급 / 신채호 외 2명",
                                    isBlue: true,
                                    isSelected: true,
                                    detail: "128라5431 / 128km / 예상 24분"),
                                suspendCard(
                                  title: "입원",
                                  detail: "대구 칠곡경북대병원 / 감염내과 / 김감염",
                                  src: "timeline_go_hosipital_complete",
                                  isSelected: false,
                                ),
                              ],
                            ),
                          if (patient.bedStatNm == '입원')
                            Column(
                              children: [
                                completeCard(
                                  title: "승인",
                                  dateTime: "오후 2시 33분",
                                  src: "timeline_approved",
                                  by: "대구광역시 병상배정반 / 팀장 / 홍성수",
                                  detail: "병상배정이 완료되었습니다.",
                                ),
                                completeCard(
                                  title: "배정불가",
                                  dateTime: "오후 2시 33분",
                                  src: "timeline_refused",
                                  by: "대구광역시 병상배정반 / 팀장 / 홍성수",
                                  detail: "가능한 음압격리 병실이 없습니다.",
                                ),
                                completeCard(
                                    title: "배정완료",
                                    dateTime: "오후 2시 33분",
                                    src: "timeline_bed_assign_complete",
                                    by: "대구의료원 / 신경내과 / 강성일",
                                    detail: "도착 5분전 전화 주시면 나가 있겠습니다."),
                                completeCard(
                                    title: "이송완료",
                                    dateTime: "오후 2시 33분",
                                    src: "timeline_move_complete",
                                    by: "대구광역시 중부 대명 구급 / 신채호 외 2명",
                                    detail: "128라5431 / 128km / 예상 24분"),
                                completeCard(
                                  title: "입원완료",
                                  dateTime: "오후 2시 33분",
                                  src: "timeline_go_hosipital_complete",
                                  by: "대구광역시 병상배정반 / 팀장 / 홍성수",
                                  detail: "병상배정이 완료되었습니다.",
                                ),
                                completeCard(
                                    title: "귀가요청",
                                    dateTime: "오후 2시 33분",
                                    src: "timeline_go_home",
                                    by: "대구광역시 병상배정반 / 팀장 / 홍성수",
                                    detail: "강한 귀가 의사를 표현하여 재택 회송 요청드립니다 보호자 편에 귀가 가능합니다..",
                                    isBlue: true,
                                    isSelected: true),
                              ],
                            ),
                        ],
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 50.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: Palette.greyText_20,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  color: Palette.greyText_20,
                  margin: EdgeInsets.all(2.r),
                  child: Image.asset("assets/auth_group/image_location_small.png", width: 42.h),
                ),
                Expanded(
                    child: TextField(
                  // controller: _messageController,
                  onChanged: (value) {
                    // setState(() {});
                  },
                  decoration: InputDecoration(hintText: '메세지 입력', border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 12.w)),
                )),
                InkWell(
                  onTap: () {},
                  child: Container(
                    color: Palette.mainColor,
                    padding: EdgeInsets.all(12.r),
                    margin: EdgeInsets.all(2.r),
                    child: Icon(
                      Icons.send,
                      color: Palette.white,
                      size: 20.h,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget closedCard({required String title, required String src}) {
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
              child: Container(
                margin: EdgeInsets.only(left: 12.w),
                padding: EdgeInsets.only(left: 12.w, top: 16.h, bottom: 16.h, right: 12.w),
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

  Widget suspendCard({required String title, required String src, String? detail, bool isSelected = true}) {
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
              child: Container(
                margin: EdgeInsets.only(left: 12.w),
                padding: EdgeInsets.only(left: 12.w, top: 16.h, bottom: 16.h, right: 12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: isSelected
                      ? Border.all(
                          color: Palette.mainColor,
                          width: 2,
                        )
                      : null,
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
                      ],
                    ),
                    SizedBox(height: detail != null ? 8.h : 0),
                    detail != null
                        ? Text(
                            detail,
                            style: CTS(
                              color: Palette.greyText,
                              fontSize: 13,
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget completeCard(
      {required String title,
      required String dateTime,
      required String src,
      required String by,
      required String detail,
      bool isBlue = false,
      bool isSelected = false}) {
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
              child: Container(
                margin: EdgeInsets.only(left: 12.w),
                padding: EdgeInsets.only(left: 12.w, top: 16.h, bottom: 16.h, right: 12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: isSelected
                      ? Border.all(
                          color: Palette.mainColor,
                          width: 2,
                        )
                      : null,
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
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: isBlue ? Palette.mainColor.withOpacity(0.16) : Color(0xff676a7a).withOpacity(0.12),
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
