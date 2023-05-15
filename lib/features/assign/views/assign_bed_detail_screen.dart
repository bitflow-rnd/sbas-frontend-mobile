import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/assign/model/assign_item_model.dart';
import 'package:sbas/features/assign/views/widgets/detail_page/assign_bed_detail_move_detail.dart';
import 'package:sbas/features/assign/views/widgets/detail_page/assign_bed_detail_paitent_info.dart';
import 'package:sbas/features/assign/views/widgets/detail_page/assign_bed_detail_timeline.dart';
import 'package:sbas/features/lookup/models/patient_model.dart';

import 'widgets/detail_page/assign_bed_detail_disease_info.dart';

class AssignBedDetailScreen extends StatefulWidget {
  const AssignBedDetailScreen({
    super.key,
    required this.model,
  });
  final AssignItemModel model;

  @override
  State<AssignBedDetailScreen> createState() => _AssignBedDetailState();
}

class _AssignBedDetailState extends State<AssignBedDetailScreen> {
  List<String> headerList = ["타임라인", "환자정보", "질병정보", "이송정보"];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.white,
        appBar: AppBar(
          title: Text(
            "병상 배정 상세",
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
                onTap: () {},
                child: Image.asset(
                  "assets/common_icon/share_icon.png",
                  height: 24.h,
                  width: 24.w,
                ),
              ),
            )
          ],
          elevation: 0.5,
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
          child: Column(
            children: [
              _header(widget.model.ptNm ?? '',
                  "(${widget.model.gndr} / ${widget.model.age}세 / 대구 북구 / 010-8833-1234)"), //pnum 등 분리필요
              Divider(
                color: Palette.greyText_20,
                height: 1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                // child: const AssignDetailTopNavbar(),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 10.h),
                      child: Padding(
                        padding: EdgeInsets.only(top: 6.h),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                              4,
                              (index) => InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedIndex = index;
                                    //update screen
                                  });
                                },
                                child: Text(
                                  headerList[index],
                                  style: CTS.medium(
                                    color: Colors.black,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 6.h,
                          decoration: BoxDecoration(
                            color: const Color(0xffecedef),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        AnimatedAlign(
                          alignment: Alignment(
                            -1 + (_selectedIndex * 2) / 3,
                            0,
                          ),
                          duration: const Duration(
                            milliseconds: 200,
                          ),
                          child: Container(
                            width: (1.sw - 40.w) / 4,
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
              ),
              if (_selectedIndex == 0)
                AssignBedDetailTimeLine(
                  model: widget.model,
                ),
              if (_selectedIndex == 1)
                AssignBedDetailPaitentInfo(
                  patient: tempPaitent,
                ),
              if (_selectedIndex == 2)
                AssignBedDetailDiseaseInfo(
                  patient: tempPaitent,
                ),
              if (_selectedIndex == 3)
                const AssignBedMoveDetialInfo(
                    type: "병원-집") //집-병원 또는 null 로 하면 집-병원 으로 젼환가능
            ],
          ),
        ));
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
          Column(
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
                        color: const Color(0xff333333),
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
          ),
        ],
      ),
    );
  }

  Patient tempPaitent = Patient(
    rgstUserId: "cyberprophet",
    rgstDttm: "2023-04-11T06:12:03.709296Z",
    updtUserId: "cyberprophet",
    updtDttm: "2023-04-11T08:31:22.296640Z",
    ptId: "PT00000055",
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
