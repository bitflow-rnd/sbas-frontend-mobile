import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/assign/views/widgets/detail_page/assign_bed_detail_disease_info.dart';
import 'package:sbas/features/assign/views/widgets/detail_page/assign_bed_detail_move_detail.dart';
import 'package:sbas/features/assign/views/widgets/detail_page/assign_bed_detail_paitent_info.dart';
import 'package:sbas/features/assign/views/widgets/detail_page/assign_bed_detail_timeline.dart';
import 'package:sbas/features/assign_request/view/assign_request_critical_attack_input.dart';
import 'package:sbas/features/assign_request/view/assign_request_departure_info_input.dart';
import 'package:sbas/features/assign_request/view/assign_request_disease_info_input.dart';

import 'package:sbas/features/lookup/models/patient_info_model.dart';
import 'package:sbas/features/lookup/views/widgets/patient_reg_info_widget.dart';
import 'package:sbas/features/lookup/views/widgets/patient_reg_info_widget_v2.dart';

import '../lookup/views/widgets/patient_reg_report_widget.dart';

class AssignBedRequestScreen extends StatefulWidget {
  const AssignBedRequestScreen({
    super.key,
  });
  @override
  State<AssignBedRequestScreen> createState() => _AssignBedRequestState();
}

class _AssignBedRequestState extends State<AssignBedRequestScreen> {
  List<String> headerList = ["역학조사서", "환자정보", "감염병정보", "중증정보", "출발정보"];
  int _selectedIndex = 0;
  bool isRight = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.white,
        appBar: AppBar(
          title: Text(
            "병상요청",
            style: CTS.medium(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          actions: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 8.h,
              ),
              margin: EdgeInsets.only(right: 16.w),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/common_icon/close_button_png.png",
                    height: 13.h,
                    width: 13.w,
                  ),
                ),
              ),
            )
          ],
          elevation: 0.5,
          centerTitle: true,
          backgroundColor: Colors.white,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              _header("홍길동", "(남 / 88세 / 대구 북구 / 010-8833-1234"),
              Divider(
                color: Palette.greyText_20,
                height: 1,
              ),
              Padding(
                padding: EdgeInsets.only(right: 2.w),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                            child: Padding(
                              padding: EdgeInsets.only(top: 6.h),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: List.generate(
                                    5,
                                    (index) => InkWell(
                                      // onTap:
                                      // () {
                                      // setState(() {
                                      //   _selectedIndex = index;
                                      // });
                                      //상단 버튼 눌러서 이동 하는 로직 비활성화 .
                                      // },
                                      child: SizedBox(
                                        width: 0.22.sw,
                                        child: Text(
                                          headerList[index],
                                          style: CTS.medium(
                                            color: Colors.black,
                                            fontSize: 13,
                                          ),
                                        ).c,
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 16.w),
                                height: 6.h,
                                width: 0.22.sw * 5,
                                decoration: BoxDecoration(
                                  color: Color(0xffecedef),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                              AnimatedContainer(
                                padding: EdgeInsets.only(left: 0.22.sw * _selectedIndex + 16.w),
                                duration: const Duration(
                                  milliseconds: 200,
                                ),
                                child: Container(
                                  width: 0.22.sw,
                                  height: 6.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      30,
                                    ),
                                    color: Palette.mainColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (_selectedIndex == 0) //역학조사서
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 24.h),
                    child: const PatientRegReport(),
                  ),
                ),
              if (_selectedIndex == 1) //환자정보
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 24.h),
                  child: PatientRegInfoV2(formKey: GlobalKey<FormState>()),
                )),
              if (_selectedIndex == 2) AssignReqDiseaseInfoInputScreen(), //감염병정보
              if (_selectedIndex == 3) AssignReqCriticalAttackInputScreen(), //중증정보
              if (_selectedIndex == 4) AssignReqDepatureInfoInputScreen(), //출발정보
              _bottomer(),
            ],
          ),
        ));
  }

  Widget _bottomer() {
    return Row(
      children: [
        _selectedIndex != 0
            ? Expanded(
                child: InkWell(
                  onTap: () {
                    if (_selectedIndex == 0) {
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        _selectedIndex--;
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 11.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Palette.greyText_80,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      '이전',
                      style: CTS(
                        color: Palette.greyText_80,
                        fontSize: 16,
                      ),
                    ).c,
                  ),
                ),
              )
            : Container(),
        Expanded(
          child: InkWell(
            onTap: () {
              if (_selectedIndex == 4) {
                //모두 작성 완료시 로직처리.
              } else {
                setState(() {
                  _selectedIndex++;
                });
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: const BoxDecoration(
                color: Palette.mainColor,
              ),
              child: Text(
                _selectedIndex == 4 ? '요청 완료' : '다음',
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

  Widget _header(String name, String detail) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 14.h,
        horizontal: 16.w,
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/patient.png',
            height: 36.h,
            width: 36.h,
          ),
          Gaps.h8,
          tempPaitent == null //신규환자등록 or 역학조사서로부터 환자정보 가져온 케이스 구분
              ? Text(
                  '신규 환자 등록',
                  style: CTS.bold(
                    fontSize: 16,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: name,
                        style: CTS.bold(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: detail, //TODO :: MaxLines 관리및 디자인 협의필요 04.28하진우.
                            style: CTS(
                              color: Color(0xff333333),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gaps.v4,
                    const Text(
                      '#temp',
                      style: TextStyle(
                        color: Palette.mainColor,
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }

  Patient tempPaitent = Patient(
    rgstUserId: "cyberprophet",
    rgstDttm: "2023-04-11T06:12:03.709296Z",
    updtUserId: "cyberprophet",
    updtDttm: "2023-04-11T08:31:22.296640Z",
    id: "PT00000055",
    ptNm: "달나라",
    gndr: "F",
    rrno1: "310301",
    rrno2: "2",
    dstr1Cd: "50",
    dstr2Cd: "5013",
    addr: "제주특별자치도 서귀포시 아우성",
    telno: "04580808080",
    natiCd: "KR",
    picaVer: "",
    dethYn: "N",
    nokNm: "나라고",
    mpno: "01021210909",
    job: "머라고",
    attcId: null,
    bedStatCd: "BAST0001",
    bedStatNm: "병상요청",
  );
}
