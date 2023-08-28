import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/assign/views/widgets/detail_page/assign_bed_detail_disease_info.dart';
import 'package:sbas/features/assign/views/widgets/detail_page/assign_bed_detail_move_detail.dart';
import 'package:sbas/features/assign/views/widgets/detail_page/assign_bed_detail_patient_info.dart';
import 'package:sbas/features/assign/views/widgets/detail_page/assign_bed_detail_timeline.dart';
import 'package:sbas/features/lookup/models/patient_model.dart';
import 'package:sbas/features/lookup/presenters/patient_timeline_presenter.dart';
import 'package:sbas/features/lookup/views/widgets/patient_top_info_widget.dart';
import 'package:sbas/util.dart';

import '../../lookup/models/patient_disease_info_model.dart';
import '../model/assign_item_model.dart';

class AssignBedDetailScreen extends ConsumerStatefulWidget {
  AssignBedDetailScreen({
    super.key,
    required this.patient,
    required this.assignItem,
    required this.diseaseInfo,
  });
  final Patient patient;
  final AssignItemModel assignItem;

  final PatientDiseaseInfoModel diseaseInfo;
  final headerList = [
    "타임라인",
    "환자정보",
    "질병정보",
    "이송정보",
  ];
  @override
  ConsumerState<AssignBedDetailScreen> createState() => _AssignBedDetailState();
}

class _AssignBedDetailState extends ConsumerState<AssignBedDetailScreen> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(patientTimeLineProvider.notifier).refresh(widget.assignItem.ptId, widget.assignItem.bdasSeq);
    });

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
            PatientTopInfo(patient: widget.patient),
            Divider(
              color: Palette.greyText_20,
              height: 1,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 6.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          4,
                          (index) => InkWell(
                            onTap: () => setState(() {
                              _selectedIndex = index;
                            }),
                            child: Text(
                              widget.headerList[index],
                              style: CTS.medium(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
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
              AssignBedDetailTimeLine(patient: widget.patient, assignItem: widget.assignItem)
            else if (_selectedIndex == 1)
              AssignBedDetailPatientInfo(patient: widget.patient)
            else if (_selectedIndex == 2)
              AssignBedDetailDiseaseInfo(ptId: widget.patient.ptId, diseaseInfo: widget.diseaseInfo)
            else if (_selectedIndex == 3)
              /*집-병원 또는 null 로 하면 집-병원 으로 젼환가능*/
              const AssignBedMoveDetialInfo(type: "병원-집")
          ],
        ),
      ),
    );
  }

  int _selectedIndex = 0;
}
