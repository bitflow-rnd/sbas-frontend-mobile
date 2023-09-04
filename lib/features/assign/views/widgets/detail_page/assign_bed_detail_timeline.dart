import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/common.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/assign/model/assign_item_model.dart';
import 'package:sbas/features/assign/presenters/assign_bed_presenter.dart';
import 'package:sbas/features/assign/presenters/available_hospital_presenter.dart';
import 'package:sbas/features/assign/views/modal_tab/assign_bed_approve_move.dart';
import 'package:sbas/features/assign/views/modal_tab/assign_bed_approve_screen.dart';
import 'package:sbas/features/assign/views/modal_tab/assign_bed_cancel_screen.dart';
import 'package:sbas/features/assign/views/modal_tab/assign_bed_find_screen.dart';
import 'package:sbas/features/assign/views/modal_tab/assign_bed_go_home.dart';
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
  static final asgnBdMoveKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: ref.watch(patientTimeLineProvider).when(
          loading: () => const SBASProgressIndicator(),
          error: (error, stackTrace) => Center(
                child: Text(
                  error.toString(),
                  style: const TextStyle(
                    color: Palette.mainColor,
                  ),
                ),
              ),
          data: (timeLine) {
            final titleOrder = {
              "병상요청 (전원요청)": -2,
              "병상요청 (원내배정)": -2,
              "승인대기": -1, //병상배정반 승인대기
              "승인": 0, //병상배정반 승인
              "배정대기": 1, //의료진 승인 대기
              "원내배정": 2, //원내배정 케이스
              "이송대기": 4, //의료진 승인 후 이송 요청 전.
              "이송중": 5, //이송 요청 이후
              "이송완료": 6, //이송 완료
              "입원": 7,
              "입원완료": 8,
              "퇴원": 9,
              "재택회송": 9,
              "귀가요청": 10,
            };

            timeLine.items.sort((a, b) {
              if (titleOrder[a.title] == null || titleOrder[b.title] == null) {
                return 0;
              }
              final titleComparison = titleOrder[a.title]!.compareTo(titleOrder[b.title]!);
              if (titleComparison != 0) {
                return titleComparison;
              } else {
                if (a.updtDttm == null && b.updtDttm == null) {
                  return 0;
                } else if (a.updtDttm == null) {
                  return 1;
                } else if (b.updtDttm == null) {
                  return -1;
                } else {
                  return a.updtDttm!.compareTo(b.updtDttm!);
                }
              }
            });

            return Column(
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
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                // timeline_approved
                                // timeline_bed_assign_complete
                                // timeline_go_hospital_complete
                                // timeline_move_complete
                                // timeline_refused
                                // timeline_go_home
                                //
                                //timeline_suspend //  원형 점

                                children: [
                                  for (var i = 0; i < timeLine.count!; i++)
                                    timeLineBody(timeLine.items[i], isVisible: !timeLine.items.map((e) => e.title == "배정불가").toList().contains(true)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _whichBottomer(assignItem.bedStatCdNm ?? '', context, ref, timeLine),
              ],
            );
          }),
    );
  }

  Widget _whichBottomer(String type, BuildContext context, WidgetRef ref, PatientTimelineModel timeLine) {
    switch (type) {
      case '승인대기':
        return _bottomer(
            lBtnText: "배정 불가",
            rBtnText: "승인",
            lBtnFunc: () async {
              var res = await Common.showModal(
                  context,
                  Common.commonModal(
                    context: context,
                    imageWidget: Image.asset(
                      "assets/auth_group/modal_check.png",
                      width: 44.h,
                    ),
                    imageHeight: 44.h,
                    mainText: "배정 불가 처리하시겠습니까?",
                    button1Text: "취소",
                    button2Text: "확인",
                    button1Function: () {
                      Navigator.pop(context, false);
                    },
                    button2Function: () {
                      Navigator.pop(context, true);
                    },
                  ));
              if (res ?? false) {
                //병상 배정 불가 처리.
                var postRes = await ref.watch(assignBedProvider.notifier).rejectReq({
                  "ptId": patient.ptId,
                  "bdasSeq": assignItem.bdasSeq,
                  "aprvYn": "N",
                  // "msg": res.toString(),
                });
                if (postRes) {
                  await ref.watch(patientTimeLineProvider.notifier).refresh(assignItem.ptId, assignItem.bdasSeq);
                  await ref.watch(assignBedProvider.notifier).reloadPatients(); // 리스트 갱신
                  Navigator.pop(context);
                }
              }
            },
            rBtnFunc: () async {
              if (context.mounted) {
                bool postRes;
                //원내배정
                if (assignItem.inhpAsgnYn == "Y") {
                  String? res = await _showBottomSheet(
                    context: context,
                  );
                  //원내배정
                  postRes = await ref.watch(assignBedProvider.notifier).approveReq({
                    "ptId": patient.ptId,
                    "bdasSeq": assignItem.bdasSeq,
                    "aprvYn": "Y",
                    "msg": res.toString(),
                  });

                  if (postRes) {
                    //승인성공
                    await ref.watch(patientTimeLineProvider.notifier).refresh(assignItem.ptId, assignItem.bdasSeq);
                    await ref.watch(assignBedProvider.notifier).reloadPatients(); // 리스트 갱신
                    await Future.delayed(Duration(microseconds: 1500));
                    Navigator.pop(context);

                    Navigator.pop(context);
                  }
                }
                //원외배정
                else {
                  await ref.watch(availableHospitalProvider.notifier).getAsync(patient.ptId, assignItem.bdasSeq).then((value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AssignBedFindScreen(patient: patient, bdasSeq: assignItem.bdasSeq, hospList: value),
                      ))); //병상요청시 가능한 병원 목록 조회
                }
              }
            });
      case '배정대기':
      case "원내배정":
        return _bottomer(
            lBtnText: "배정 불가",
            rBtnText: "배정 승인",
            lBtnFunc: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AssignBedCancelScreen(
                    patient: patient,
                    assignItem: assignItem,
                    timeLine: timeLine.items
                        .where((element) => (element.chrgInstId != null && element.asgnReqSeq != null && element.timeLineStatus == "suspend"))
                        .first,
                  ),
                ),
              );
            },
            rBtnFunc: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AsgnBdDoctorApproveScreen(
                    patient: patient,
                    assignItem: assignItem,
                    timeLine: timeLine.items
                        .where((element) => (element.chrgInstId != null && element.asgnReqSeq != null && element.timeLineStatus == "suspend"))
                        .first, //TODO:: Timeline 에서 현재 사용자의 chrgInstId 가 있는 데이터를 가져오도록 추후구현
                  ),
                ),
              );
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
                    formKey: asgnBdMoveKey,
                    bdasSeq: assignItem.bdasSeq,
                    // timeLine: timeLine.items.where((element) => (element.chrgInstId != null && element.asgnReqSeq != null)).first,
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
                    assignItem: assignItem,
                    timeLine: timeLine.items.where((element) => (element.title == "입원")).first,
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

    WidgetsBinding.instance.addPostFrameCallback((_) => focusNode.requestFocus());
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.r),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              // FocusScopeNode currentFocus = FocusScope.of(context);
              // if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
              //   currentFocus.focusedChild?.unfocus();
              // }
            },
            child: Container(
              height: 400.h,
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 20.h),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
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

  Widget timeLineBody(TimeLine timeLine, {bool? isVisible = true}) {
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
        return isVisible ?? true ? closedCard(title: timeLine.title!, src: getImageSrcBy(timeLine.title!)) : Container();
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
      case "배정불가":
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
