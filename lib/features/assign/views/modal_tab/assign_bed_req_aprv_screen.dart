import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/app_bar_widget.dart';
import 'package:sbas/constants/common.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/assign/model/available_hospital_model.dart';
import 'package:sbas/features/assign/presenters/assign_bed_presenter.dart';
import 'package:sbas/features/patient/models/patient_model.dart';
import 'package:sbas/features/lookup/presenters/patient_timeline_presenter.dart';
import 'package:sbas/features/lookup/views/widgets/patient_top_info_widget.dart';
import 'package:sbas/util.dart';

import '../../presenters/available_hospital_presenter.dart';

final searchDetailIsOpenProvider = StateProvider<bool>((ref) => false);
final selectedItemsProvider = StateProvider<List<String>>((ref) => []);
final searchHospListProvider = StateProvider<AvailableHospitalModel>((ref) => AvailableHospitalModel(count: 0, items: []));

class AssignBedReqAprvScreen extends ConsumerStatefulWidget {
  const AssignBedReqAprvScreen({
    super.key,
    required this.patient,
    required this.bdasSeq,
    required this.hospList,
  });
  final Patient patient;
  final int? bdasSeq;
  final AvailableHospitalModel hospList;

  @override
  ConsumerState<AssignBedReqAprvScreen> createState() => _AssignBedReqAprvScreenState();
}

class _AssignBedReqAprvScreenState extends ConsumerState<AssignBedReqAprvScreen> {
  @override
  Widget build(BuildContext context) {
    final isSearchDetailOpen = ref.watch(searchDetailIsOpenProvider);
    final selectedHospList = ref.watch(selectedItemsProvider);
    final searchHospList = ref.watch(searchHospListProvider);

    return Scaffold(
        backgroundColor: Palette.white,
        appBar: const SBASAppBar(
          title: '병상 요청 승인',
          elevation: 0.5,
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              PatientTopInfo(patient: widget.patient),
              Divider(color: Palette.greyText_20, height: 1),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    Gaps.v16,
                    Row(
                      children: [
                        Text('출발지', style: CTS.medium(color: Palette.greyText, fontSize: 13)),
                        Gaps.h20,
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: TextFormField(
                              initialValue: widget.patient.bascAddr,
                              style: CTS(
                                color: Palette.greyText,
                                fontSize: 13.sp,
                              ),
                              decoration: getInputDecoration(""),
                              validator: (value) {
                                return null;
                              },
                              autovalidateMode: AutovalidateMode.always,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              // maxLength: maxLength,
                            ),
                          ),
                        ),
                        Gaps.h8,
                        InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: Palette.mainColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
                            child: Text('주소검색', style: CTS.medium(color: Palette.white, fontSize: 13)),
                          ),
                        )
                      ],
                    ),
                    Gaps.v16,
                    Row(
                      children: [
                        Text('환자유형', style: CTS.medium(color: Palette.greyText, fontSize: 13)),
                        Gaps.h8,
                        Expanded(child: rowMultiSelectButton(ptTypeList, ptTypeCdList)),
                      ],
                    ),
                    ref.watch(searchDetailIsOpenProvider.notifier).state
                        ? Column(
                            children: [
                              Gaps.v8,
                              Divider(color: Palette.greyText_20, height: 1),
                              Gaps.v8,
                              Row(
                                children: [
                                  Text('중증도', style: CTS.medium(color: Palette.greyText, fontSize: 13)),
                                  Gaps.h20,
                                  Expanded(child: rowMultiSelectButton(severityTypeList, svrtTypeCdList)),
                                ],
                              ),
                              Gaps.v8,
                              Divider(color: Palette.greyText_20, height: 1),
                              Gaps.v8,
                              Row(
                                children: [
                                  Text('병상유형', style: CTS.medium(color: Palette.greyText, fontSize: 13)),
                                  Gaps.h8,
                                  Expanded(child: rowMultiSelectButton(bedTypeList, reqBedTypeCdList)),
                                ],
                              ),
                              Gaps.v8,
                              Divider(color: Palette.greyText_20, height: 1),
                              Gaps.v8,
                              Row(
                                children: [
                                  Text('장비정보', style: CTS.medium(color: Palette.greyText, fontSize: 13)),
                                  Gaps.h8,
                                  Expanded(child: rowMultiSelectButton(equipmentList, equipment)),
                                ],
                              ),
                              Gaps.v4,
                            ],
                          )
                        : Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          splashRadius: 14.r,
                          padding: EdgeInsets.zero, // 패딩 설정
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            ref.read(searchDetailIsOpenProvider.notifier).state = !isSearchDetailOpen;
                          },
                          icon: Icon(!isSearchDetailOpen ? Icons.arrow_drop_down : Icons.arrow_drop_up, size: 36.0,),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Gaps.v8,
              Divider(color: Palette.greyText_20, height: 1),
              Gaps.v16,
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: '총', style: CTS.bold(color: Colors.black)),
                              TextSpan(text: ' ${searchHospList.count}', style: CTS.bold(color: Palette.mainColor)),
                              TextSpan(text: '개', style: CTS.bold(color: Colors.black)),
                            ],
                          ),
                          style: CTS.bold(
                            color: Colors.black,
                          ),
                        ),
                        Gaps.v16,
                        // dropdownButton(
                        //   ['최신순', '등록순'],
                        //   '최신순',
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var i = 0; i < searchHospList.count!; i++)
                        Container(
                          // margin: EdgeInsets.only(top: 8.h, left: 12.w, right: 12.w),
                          margin: EdgeInsets.only(top: 8.h),
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
                          child: GestureDetector(
                            onTap: () {
                              String currentHospId = searchHospList.items[i].hospId!;
                              bool hasItem = selectedHospList.contains(currentHospId);
                              if (hasItem) {
                                setState(() {
                                  ref.watch(selectedItemsProvider.notifier).state.remove(currentHospId);
                                });
                              } else {
                                setState(() {
                                  ref.watch(selectedItemsProvider.notifier).state.add(currentHospId);
                                });
                              }
                              // print(selectedHospList);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  // flex: 6,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Text(
                                                '${searchHospList.items[i].hospNm}',
                                                style: CTS.medium(
                                                  color: Colors.black,
                                                  fontSize: 15.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 40.h,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Column(
                                            children: [
                                              Gaps.v8,
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        severityTypeList[0]['name']!,
                                                        style: CTS.medium(
                                                          color: Palette.greyText_80,
                                                          fontSize: 12,
                                                        ),
                                                        softWrap: true,
                                                      ),
                                                      Text(
                                                        '${searchHospList.items[i].gnbdIcu}',
                                                        style: CTS.medium(
                                                          color: Palette.googleColor,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Gaps.h8,
                                                  Column(
                                                    children: [
                                                      Text(
                                                        severityTypeList[1]['name']!,
                                                        style: CTS.medium(
                                                          color: Palette.greyText_80,
                                                          fontSize: 12,
                                                        ),
                                                        softWrap: true,
                                                      ),
                                                      Text(
                                                        '${searchHospList.items[i].npidIcu}',
                                                        style: CTS.medium(
                                                          color: Palette.googleColor,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Gaps.h8,
                                                  Column(
                                                    children: [
                                                      Text(
                                                        severityTypeList[2]['name']!,
                                                        style: CTS.medium(
                                                          color: Palette.greyText_80,
                                                          fontSize: 12,
                                                        ),
                                                        softWrap: true,
                                                      ),
                                                      Text(
                                                        '${searchHospList.items[i].gnbdSvrt}',
                                                        style: CTS.medium(
                                                          color: Palette.googleColor,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Gaps.h8,
                                                  Column(
                                                    children: [
                                                      Text(
                                                        severityTypeList[3]['name']!,
                                                        style: CTS.medium(
                                                          color: Palette.greyText_80,
                                                          fontSize: 12,
                                                        ),
                                                        softWrap: true,
                                                      ),
                                                      Text(
                                                        '${searchHospList.items[i].gnbdSmsv}',
                                                        style: CTS.medium(
                                                          color: Palette.googleColor,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Gaps.h8,
                                                  Column(
                                                    children: [
                                                      Text(
                                                        severityTypeList[4]['name']!,
                                                        style: CTS.medium(
                                                          color: Palette.greyText_80,
                                                          fontSize: 12,
                                                        ),
                                                        softWrap: true,
                                                      ),
                                                      Text(
                                                        '${searchHospList.items[i].gnbdModr}',
                                                        style: CTS.medium(
                                                          color: Palette.googleColor,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                            children: List.generate(
                                          searchHospList.items[i].tagList?.length ?? 0,
                                          (index) => Container(
                                            margin: EdgeInsets.only(right: 4.w),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2.h, horizontal: 6.w),
                                            decoration: BoxDecoration(
                                              color: Palette.greyText_20,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              '#${searchHospList.items[i].tagList![index]}',
                                              style: CTS(
                                                color: Palette.greyText_80,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        )),
                                      )
                                    ],
                                  ),
                                ),
                                // const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.location_on_sharp, color: Palette.mainColor, size: 20.h),
                                        Text('${searchHospList.items[i].distance}', style: CTS(color: Palette.mainColor, fontSize: 12)),
                                      ],
                                    ),
                                    Gaps.v8,
                                    Container(
                                        height: 24.h,
                                        width: 24.h,
                                        decoration: BoxDecoration(
                                            color: ref.watch(selectedItemsProvider.notifier).state.contains(searchHospList.items[i].hospId!)
                                                ? Palette.mainColor
                                                : Palette.white,
                                            borderRadius: BorderRadius.circular(4.r),
                                            border: !ref.watch(selectedItemsProvider.notifier).state.contains(searchHospList.items[i].hospId!)
                                                ? Border.all(color: Palette.greyText_20, width: 1)
                                                : null),
                                        child: ref.watch(selectedItemsProvider.notifier).state.contains(searchHospList.items[i].hospId!)
                                            ? Icon(
                                                Icons.check,
                                                color: Palette.white,
                                                size: 16.h,
                                              )
                                            : Container()),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
              Common.bottomer(
                lBtnText: "배정 불가",
                rBtnText: "병상 요청 승인",
                lBtnFunc: () {},
                rBtnFunc: () async {
                  if (selectedHospList.isEmpty) {
                    showToast('병원을 선택해주세요.');
                    return;
                  }
                  var msgRes = await Common.showBottomSheet(
                    context: context,
                    header: '승인 메시지 입력',
                  );
                  ref.watch(assignBedProvider.notifier).approveReq({
                    "ptId": widget.patient.ptId,
                    "bdasSeq": widget.bdasSeq,
                    "aprvYn": "Y",
                    "msg": msgRes,
                    "reqHospIdList": selectedHospList,
                  }).then((value) {
                    if (value) { // 승인성공
                      ref.watch(selectedItemsProvider.notifier).state = [];
                      ref.watch(patientTimeLineProvider.notifier).refresh(widget.patient.ptId, widget.bdasSeq);
                      ref.watch(assignBedProvider.notifier).reloadPatients(); // 리스트 갱신
                      Common.showModal(
                        context,
                        Common.commonModal(
                          context: context,
                          imageWidget: Image.asset(
                            "assets/auth_group/modal_check.png",
                            width: 44.h,
                          ),
                          imageHeight: 44.h,
                          mainText: "병상 요청이 승인되었습니다.",
                          button2Function: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        ),
                      );
                    }
                  });
                }
              )
            ],
          ),
        ));
  }

  Widget dropdownButton(List<String> dlist, String sel) {
    return SizedBox(
      height: 40.h,
      width: 88.w,
      child: DropdownButtonFormField(
        borderRadius: BorderRadius.circular(4.r),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(4.r),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(4.r),
              ),
            ),
            contentPadding: EdgeInsets.only(
              left: 18.w,
            )),
        value: sel,
        items: dlist.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: CTS.medium(fontSize: 11, color: Palette.greyText),
            ).c,
          );
        }).toList(),
        onChanged: (dynamic value) {
          // setState(() {
          //   selectedDropdown = value;
          // });
        },
      ),
    );
  }

  Widget rowMultiSelectButton(List<Map<String, String>> list, List<String> selectList) {
    return Row(
      children: [
        Expanded(
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                direction: Axis.horizontal,
                children: [
                  for (var item in list)
                    GestureDetector(
                    onTap: () {
                      if (selectList.contains(item['value'])) {
                        setState(() {
                          selectList.remove(item['value']);
                          if (ptTypeCdList.isEmpty && reqBedTypeCdList.isEmpty && svrtTypeCdList.isEmpty && equipment.isEmpty) {
                            ref.watch(searchHospListProvider.notifier).state = widget.hospList;
                          }
                        });
                      } else {
                        setState(() {
                          selectList.add(item['value']!);
                          ref.watch(availableHospitalProvider.notifier).getHospList(widget.patient.ptId!, widget.bdasSeq!,
                            ptTypeCdList, reqBedTypeCdList, svrtTypeCdList, equipment,
                          ).then((value) => ref.watch(searchHospListProvider.notifier).state = value);
                        });
                      }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 12.w),
                      decoration: BoxDecoration(
                        color: !selectList.contains(item['value'])
                            ? Colors.white
                            : Palette.mainColor,
                        border: Border.all(
                          color: Palette.greyText_20,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(13.5.r),
                      ),
                      child: Text(item['name']!,
                          style: CTS.bold(
                            fontSize: 11,
                            color: selectList.contains(item['value'])
                                ? Palette.white
                                : Palette.greyText_60,
                          )),
                    ),
                  )
                ],
              );
            },
          )
        ),
      ],
    );
  }

  InputDecoration getInputDecoration(String hintText) => InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(4.r),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(4.r),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(4.r),
          ),
        ),
        hintText: hintText,

        //hintStyle: CTS.regular(
        //   fontSize: 13.sp,
        //   color: Palette.greyText_60,
        // ),
        hintStyle: CTS.medium(
          fontSize: 11,
          color: Palette.greyText,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 12.w,
        ),
      );

  List<Map<String, String>> bedTypeList = [
    { 'name': '코호트격리', 'value': 'cohtBed' },
    { 'name': '음압격리', 'value': 'emrgncyNgtvIsltnBed' },
    { 'name': '일반격리', 'value': 'emrgncyNrmlIsltnBed' },
    { 'name': '소아음압격리', 'value': 'ngtvIsltnChild' },
    { 'name': '소아일반격리', 'value': 'nrmlIsltnChild' },
  ];

  List<Map<String, String>> severityTypeList = [
    { 'name': '중환자실', 'value': 'gnbdIcu' },
    { 'name': '중환자실내음압격리', 'value': 'npidIcu' },
    { 'name': '중증', 'value': 'gnbdSvrt' },
    { 'name': '준중증', 'value': 'gnbdSmsv' },
    { 'name': '중등증', 'value': 'gnbdModr' },
  ];

  List<Map<String, String>> ptTypeList = [
    { 'name': '분만', 'value': 'childBirthMed' },
    { 'name': '투석', 'value': 'dialysisMed' },
    { 'name': '소아', 'value': 'childMed' },
    { 'name': '요양병원', 'value': 'nursingHospitalMed' },
    { 'name': '정신질환자', 'value': 'mentalPatientMed' },
    { 'name': '음압수술', 'value': 'negativePressureRoomYn' },
  ];

  List<Map<String, String>> equipmentList = [
    { 'name': '인공호흡기', 'value': 'ventilator' },
    { 'name': '인공호흡기(조산아)', 'value': 'ventilatorPreemie' },
    { 'name': '인큐베이터', 'value': 'incubator' },
    { 'name': 'ECMO', 'value': 'ecmo' },
    { 'name': '고압산소', 'value': 'highPressureOxygen' },
    { 'name': 'CT', 'value': 'ct' },
    { 'name': 'MRI', 'value': 'mri' },
    { 'name': '혈관촬영기', 'value': 'bloodVesselImaging' },
    { 'name': '중심체온조절유도기', 'value': 'bodyTemperatureControl' },
  ];

  List<String> ptTypeCdList = [];
  List<String> reqBedTypeCdList = [];
  List<String> svrtTypeCdList = [];
  List<String> equipment = [];
}
