import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/common.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/assign/model/assign_item_model.dart';
import 'package:sbas/features/assign/presenters/assign_bed_presenter.dart';
import 'package:sbas/features/assign/presenters/available_hospital_presenter.dart';

import 'package:sbas/features/assign/views/widgets/detail_page/assign_bed_approve_move.dart';
import 'package:sbas/features/assign/views/widgets/detail_page/assign_bed_cancel_screen.dart';
import 'package:sbas/features/assign/views/widgets/detail_page/assign_bed_find_screen.dart';
import 'package:sbas/features/assign/views/widgets/detail_page/assign_bed_go_home.dart';
import 'package:sbas/features/lookup/models/patient_model.dart';
import 'package:sbas/features/lookup/models/patient_timeline_model.dart';
import 'package:sbas/features/lookup/presenters/patient_timeline_presenter.dart';
import 'package:sbas/util.dart';

class AssignBedDetailTimeLine extends ConsumerWidget {
  const AssignBedDetailTimeLine({
    super.key,
    required this.patient,
    required this.assignItem,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeLine = ref.watch(patientTimeLineProvider.notifier).getAsync(patient.ptId, assignItem.bdasSeq); // Provider에서 timeLine 상태를 가져옵니다.
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  dateFragment(getDateTimeFormatDay(assignItem.updtDttm!)),
                  IntrinsicHeight(
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32.w),
                          child: Column(
                            children: [
                              Expanded(
                                child: CustomPaint(
                                  painter: DashedLineVerticalPainter(),
                                  size: const Size(1, double.infinity),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // timeline_approved
                          // timeline_bed_assign_complete
                          // timeline_go_hospital_complete
                          // timeline_move_complete
                          // timeline_refused
                          // timeline_go_home
                          //
                          //timeline_suspend //  원형 점
                          children: [
                            FutureBuilder(
                                future:
                                    ref.watch(patientTimeLineProvider.notifier).getAsync(patient.ptId, assignItem.bdasSeq), // Provider에서 timeLine 상태를 가져옵니다.
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    if (assignItem.bedStatCdNm == '승인대기') {
                                      return Column(
                                        children: [
                                          for (var i = 0; i < snapshot.data!.count!; i++) timeLineBody(snapshot.data!.items[i]),
                                        ],
                                      );
                                    }
                                  }
                                  return Container();
                                }
                                // if (assignItem.bedStatCdNm == '배정대기')
                                // return  Column(
                                //     children: [
                                //       for (var i = 0; i < timeLine.count!; i++) timeLineBody(timeLine.items[i]),
                                //     ],
                                //   );
                                // if (assignItem.bedStatCdNm == '이송대기')
                                //   Column(
                                //     children: [
                                //       for (var i = 0; i < timeLine.count!; i++) timeLineBody(timeLine.items[i]),
                                //     ],
                                //   ),
                                // if (assignItem.bedStatCdNm == '이송중')
                                //   Column(
                                //     children: [
                                //       for (var i = 0; i < timeLine.count!; i++) timeLineBody(timeLine.items[i]),
                                //     ],
                                //   ),
                                // if (assignItem.bedStatCdNm == '입원')
                                //   return Column(
                                //     children: [
                                //       for (var i = 0; i < timeLine.count!; i++) timeLineBody(timeLine.items[i]),
                                //     ],
                                //   );
                                //     );
                                //   },
                                ),

                            // Column(
                            //   children: [
                            //     completeCard(
                            //       title: "승인",
                            //       dateTime: "오후 2시 33분",
                            //       src: "timeline_approved",
                            //       by: "대구광역시 병상배정반 / 팀장 / 홍성수",
                            //       detail: "병상배정이 완료되었습니다.",
                            //     ),
                            //     completeCard(
                            //       title: "배정불가",
                            //       dateTime: "오후 2시 33분",
                            //       src: "timeline_refused",
                            //       by: "대구광역시 병상배정반 / 팀장 / 홍성수",
                            //       detail: "가능한 음압격리 병실이 없습니다.",
                            //     ),
                            //     completeCard(
                            //         title: "배정완료",
                            //         dateTime: "오후 2시 33분",
                            //         src: "timeline_bed_assign_complete",
                            //         by: "대구의료원 / 신경내과 / 강성일",
                            //         detail: "도착 5분전 전화 주시면 나가 있겠습니다."),
                            //     completeCard(
                            //         title: "이송완료",
                            //         dateTime: "오후 2시 33분",
                            //         src: "timeline_move_complete",
                            //         by: "대구광역시 중부 대명 구급 / 신채호 외 2명",
                            //         detail: "128라5431 / 128km / 예상 24분"),
                            //     completeCard(
                            //       title: "입원완료",
                            //       dateTime: "오후 2시 33분",
                            //       src: "timeline_go_hospital_complete",
                            //       by: "대구광역시 병상배정반 / 팀장 / 홍성수",
                            //       detail: "병상배정이 완료되었습니다.",
                            //     ),
                            //     completeCard(
                            //         title: "귀가요청",
                            //         dateTime: "오후 2시 33분",
                            //         src: "timeline_go_home",
                            //         by: "대구광역시 병상배정반 / 팀장 / 홍성수",
                            //         detail: "강한 귀가 의사를 표현하여 재택 회송 요청드립니다 보호자 편에 귀가 가능합니다..",
                            //         isBlue: true,
                            //         isSelected: true),
                            //   ],
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _whichBottomer(patient.bedStatNm ?? '', context, ref), //patient.bedStatNm ?? ''
        ],
      ),
    );
  }

  Widget _whichBottomer(String type, BuildContext context, WidgetRef ref) {
    print("_whichBottomer >>>>>>>>>>>> ${patient.bedStatNm}");
    switch (type) {
      case '승인대기':
        return _bottomer(
            lBtnText: "배정 불가",
            rBtnText: "승인",
            lBtnFunc: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AssignBedCancelScreen(
                    patient: patient,
                  ),
                ),
              );
            },
            rBtnFunc: () async {
              String? res = await _showBottomSheet(
                context: context,
              );
              if (res != null && context.mounted) {
                //제대로된 msg res 가 리턴된 케이스 (페이지라우트)

                var postRes = await ref.watch(assignBedProvider.notifier).approveReq({
                  "ptId": patient.ptId,
                  "bdasSeq": assignItem.bdasSeq,
                  "aprvYn": "Y",
                  // "negCd": null,//불가사유 String
                  "msg": res,
                  "reqHospIdList": [
                    // "HP00002944",
                    // "HP00065860",
                    // "HP00013438",
                  ]
                });
                if (postRes) {
                  //승인성공
                  await ref.watch(patientTimeLineProvider.notifier).getAsync(assignItem.ptId, assignItem.bdasSeq);
                  await ref.watch(assignBedProvider.notifier).reloadPaitents(); // 리스트 갱신
                }
              }
            });
      case '배정대기':
        return _bottomer(
            lBtnText: "배정 불가",
            rBtnText: "배정 승인",
            lBtnFunc: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AssignBedCancelScreen(
                    patient: patient,
                  ),
                ),
              );
            },
            rBtnFunc: () async {
              dynamic res = await _showBottomSheet(
                context: context,
              );
              var hospList = await ref.watch(availableHospitalProvider.notifier).getAsync(patient.ptId, assignItem.bdasSeq); //병상요청시 가능한 병원 목록 조회
              if (res != null && context.mounted) {
                //제대로된 msg res 가 리턴된 케이스 (페이지라우트)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AssignBedFindScreen(
                        patient: patient,
                        bdasSeq: assignItem.bdasSeq,
                        // hospList: AvailableHospitalModel(items: [],ㅋ count: 0),
                        hospList: hospList
                        // hospList: AvailableHospitalModel(items: [], count: 0),
                        ),
                  ),
                );
              }
            });
      case '이송대기':
        return Common.bottomer(
            isOneBtn: true,
            rBtnText: "이송 처리",
            lBtnFunc: () {},
            rBtnFunc: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AssignBedApproveMoveScreen(
                    patient: patient,
                  ),
                ),
              );
            });
      case '이송중':
        return Common.bottomer(
            isOneBtn: true,
            rBtnText: "입퇴원 처리",
            lBtnFunc: () {},
            rBtnFunc: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AssignBedGoHome(
                    patient: patient,
                  ),
                ),
              );
            });
      case '입원':
        return _msgBottomer();
      default:
        return Container();
    }
  }

  _showBottomSheet({required BuildContext context, String header = '배정 승인', String hintText = '메시지 입력', String btnText = '승인'}) async {
    TextEditingController textEditingController = TextEditingController();
    final focusNode = FocusNode();

    // Call requestFocus() on the focus node when the bottom sheet is displayed
    WidgetsBinding.instance.addPostFrameCallback((_) => focusNode.requestFocus());
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        // <-- SEE HERE
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.r),
        ),
      ),
      isScrollControlled: false,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                currentFocus.focusedChild?.unfocus();
              }
            },
            child: Container(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 20.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          header,
                          style: CTS.medium(
                            fontSize: 15,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            weight: 24.h,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: TextField(
                              focusNode: focusNode,
                              controller: textEditingController,
                              decoration: InputDecoration(
                                hintText: hintText,
                                enabledBorder: _outlineInputBorder,
                                focusedBorder: _outlineInputBorder,
                                errorBorder: _outlineInputBorder,
                              )),
                        ),
                        Gaps.h8,
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              child: Text(
                                btnText,
                                style: CTS(color: Palette.white, fontSize: 13),
                              ),
                            ),
                            onPressed: () {
                              String text = textEditingController.text;
                              // Perform action with the entered text here
                              return Navigator.pop(context, text);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _bottomer({String lBtnText = '배정 불가', String rBtnText = "승인", required Function lBtnFunc, required Function rBtnFunc}) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              lBtnFunc();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 11.h),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Palette.greyText_20,
                  width: 0.25,
                ),
              ),
              child: Text(
                lBtnText,
                style: CTS(
                  color: Palette.greyText_80,
                  fontSize: 16,
                ),
              ).c,
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              rBtnFunc();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: const BoxDecoration(
                color: Palette.mainColor,
              ),
              child: Text(
                rBtnText,
                style: CTS(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ).c,
            ),
          ),
        ),
      ],
    );
  }

  Widget _msgBottomer() {
    return Container(
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
    );
  }

  Widget timeLineBody(TimeLine timeLine) {
    switch (timeLine.timeLineStatus) {
      case "complete":
        return completeCard(
            title: timeLine.title ?? '',
            dateTime: getTimeLineDateFormat(timeLine.updtDttm ?? ''),
            src: getImageSrcBy(timeLine.title ?? ''),
            by: timeLine.by ?? '',
            detail: timeLine.msg);
      case "suspend":
        return suspendCard(title: timeLine.title!, src: getImageSrcBy(timeLine.title!), detail: timeLine.by);
      case "closed":
        return closedCard(title: timeLine.title!, src: getImageSrcBy(timeLine.title!));
      default:
        return Container();
    }
  }

  String getImageSrcBy(String title) {
    String src = "timeline_suspend";

    if (title.contains('병상요청')) {
      src = "timeline_approved";
    }

    switch (title) {
      case "병상배정":
      case "승인":
      case "배정완료":
        src = "timeline_bed_assign_complete";
        break;
      case "배정거절":
        src = "timeline_refused";
        break;
      case "이송":
      case "이송완료":
        src = "timeline_move_complete";
        break;
      case "입원":
        src = "timeline_go_hospital_complete";
        break;
      case "귀가요청":
        src = "timeline_go_home";
        break;
    }

    return "assets/common_icon/$src.png";
  }

  Widget closedCard({
    required String title,
    required String src,
  }) =>
      Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.only(left: 16.w, right: 24.w),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Column(
                children: [
                  imageIconFrag(imgSrc: src),
                ],
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 12.w),
                  padding: EdgeInsets.only(
                    left: 12.w,
                    top: 16.h,
                    bottom: 16.h,
                    right: 12.w,
                  ),
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
  Widget suspendCard({
    required String title,
    required String src,
    String? detail,
    bool isSelected = true,
  }) =>
      Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.only(left: 16.w, right: 24.w),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Column(
                children: [imageIconFrag(imgSrc: src)],
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
  Widget completeCard({
    required String title,
    required String dateTime,
    required String src,
    required String by,
    String? detail,
    bool isBlue = false,
    bool isSelected = false,
  }) =>
      Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.only(left: 16.w, right: 24.w),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Column(
                children: [imageIconFrag(imgSrc: src)],
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
                      if (detail != null)
                        Container(
                          margin: EdgeInsets.only(top: 8.h),
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: isBlue ? Palette.mainColor.withOpacity(0.16) : const Color(0xff676a7a).withOpacity(0.12),
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
  Widget imageIconFrag({
    required String imgSrc,
  }) =>
      Expanded(
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
  Widget dateFragment(String date) => Container(
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

  final Patient patient;
  final AssignItemModel assignItem;
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

InputBorder get _outlineInputBorder => OutlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: Colors.grey.shade300,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(4.r),
      ),
    );
