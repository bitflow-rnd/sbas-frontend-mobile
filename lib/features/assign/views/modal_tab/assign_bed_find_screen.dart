import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/common.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/assign/model/available_hospital_model.dart';
import 'package:sbas/features/assign/presenters/assign_bed_presenter.dart';
import 'package:sbas/features/lookup/models/patient_model.dart';
import 'package:sbas/features/lookup/presenters/patient_timeline_presenter.dart';
import 'package:sbas/features/lookup/views/widgets/patient_top_info_widget.dart';

final searchDetailIsOpenProvider = StateProvider<bool>((ref) => false);

class AssignBedFindScreen extends ConsumerStatefulWidget {
  const AssignBedFindScreen({
    super.key,
    required this.patient,
    required this.bdasSeq,
    required this.hospList,
  });
  final Patient patient;
  final int? bdasSeq;
  final AvailableHospitalModel hospList;

  @override
  ConsumerState<AssignBedFindScreen> createState() => _AssignBedFindScreenState();
}

class _AssignBedFindScreenState extends ConsumerState<AssignBedFindScreen> {
  @override
  Widget build(BuildContext context) {
    final isSearchDetailOpen = ref.watch(searchDetailIsOpenProvider);
    final selectedHospList = ref.watch(HospList.provider.notifier);
    return Scaffold(
        backgroundColor: Palette.white,
        appBar: AppBar(
          title: Text(
            "병상 배정",
            style: CTS.medium(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
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
                        Expanded(child: rowMultiSelectButton(['임산부', '음압격리', '투석'], ['임산부'])),
                      ],
                    ),
                    ref.watch(searchDetailIsOpenProvider.notifier).state
                        ? Column(
                            children: [
                              Gaps.v16,
                              Row(
                                children: [
                                  Text('                 ', style: CTS.medium(color: Palette.greyText, fontSize: 13)),
                                  Gaps.h8,
                                  Expanded(child: rowMultiSelectButton(['인공호흡', '신생아', '어린이', '수술'], ['어린이'])),
                                ],
                              ),
                              Gaps.v16,
                              Row(
                                children: [
                                  Text('기저질환', style: CTS.medium(color: Palette.greyText, fontSize: 13)),
                                  Gaps.h8,
                                  Expanded(child: rowMultiSelectButton(['고혈압', '정신질환', '관절염'], ['고혈압', '관절염'])),
                                ],
                              ),
                              Gaps.v16,
                              Row(
                                children: [
                                  Text('중증도    ', style: CTS.medium(color: Palette.greyText, fontSize: 13)),
                                  Gaps.h8,
                                  Expanded(child: rowMultiSelectButton(['중증', '준중증', '준등중', '미분류'], ['준등중'])),
                                ],
                              ),
                              Gaps.v16,
                              Row(
                                children: [
                                  Text('병상유형', style: CTS.medium(color: Palette.greyText, fontSize: 13)),
                                  Gaps.h8,
                                  Expanded(child: rowMultiSelectButton(['음압격리', '일반격리', '기타'], ['음압격리', '일반격리'])),
                                ],
                              ),
                            ],
                          )
                        : Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          splashRadius: 10.r,
                          padding: EdgeInsets.zero, // 패딩 설정
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            ref.read(searchDetailIsOpenProvider.notifier).state = !isSearchDetailOpen;
                          },
                          icon: Icon(!isSearchDetailOpen ? Icons.arrow_drop_down : Icons.arrow_drop_up),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
                              TextSpan(text: ' ${widget.hospList.count}', style: CTS.bold(color: Palette.mainColor)),
                              TextSpan(text: '개', style: CTS.bold(color: Colors.black)),
                            ],
                          ),
                          style: CTS.bold(
                            color: Colors.black,
                          ),
                        ),
                        const Spacer(),
                        dropdownButton(
                          ['최신순', '등록순'],
                          '최신순',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var i = 0; i < widget.hospList.count!; i++)
                        Container(
                          // margin: EdgeInsets.only(top: 8.h, left: 12.w, right: 12.w),
                          margin: EdgeInsets.only(top: 8.h),
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
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
                              String currentHospId = widget.hospList.items[i].hospId!;
                              bool hasItem = selectedHospList.contains(currentHospId);
                              if (hasItem) {
                                ref.watch(HospList.provider.notifier).removeHosp(currentHospId);
                                print("removed");
                              } else {
                                ref.watch(HospList.provider.notifier).addHosp(currentHospId);
                                print("selected");
                              }
                              // print(selectedHospList);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset("assets/message/hospital_icon.png", width: 36.w, height: 36.h),
                                Gaps.h8,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${widget.hospList.items[i].hospNm}',
                                          style: CTS.medium(
                                            color: Colors.black,
                                            fontSize: 15.sp,
                                          ),
                                        ),
                                        // Gaps.h8,
                                        // Container(
                                        //   padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                                        //   decoration: BoxDecoration(
                                        //     color: Palette.red.withOpacity(0.12),
                                        //     borderRadius: BorderRadius.circular(11),
                                        //   ),
                                        //   child: Text(
                                        //     'AI추천',
                                        //     style: CTS.medium(
                                        //       color: Palette.red,
                                        //       fontSize: 12,
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    // Gaps.v8,
                                    SizedBox(
                                      width: 180.w,
                                      height: 30.h,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            Text(
                                              '${widget.hospList.items[i].addr}',
                                              style: CTS(
                                                color: Palette.greyText_80,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Gaps.v4,
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 4.w),
                                          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 6.w),
                                          decoration: BoxDecoration(
                                            color: Palette.greyText_20,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            '#임산부',
                                            style: CTS(
                                              color: Palette.greyText_80,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 4.w),
                                          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 6.w),
                                          decoration: BoxDecoration(
                                            color: Palette.greyText_20,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            '#음압격리',
                                            style: CTS(
                                              color: Palette.greyText_80,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.location_on_sharp, color: Palette.mainColor, size: 20.h),
                                        Text('${widget.hospList.items[i].distance}', style: CTS(color: Palette.mainColor, fontSize: 12)),
                                      ],
                                    ),
                                    Gaps.v8,
                                    Container(
                                        height: 24.h,
                                        width: 24.h,
                                        decoration: BoxDecoration(
                                            color: selectedHospList.contains(widget.hospList.items[i].hospId!) ? Palette.mainColor : Palette.white,
                                            borderRadius: BorderRadius.circular(4.r),
                                            border: !selectedHospList.contains(widget.hospList.items[i].hospId!)
                                                ? Border.all(color: Palette.greyText_20, width: 1)
                                                : null),
                                        child: selectedHospList.contains(widget.hospList.items[i].hospId!)
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
                  lBtnFunc: () {},
                  rBtnFunc: () async {
                    var msgRes = await Common.showBottomSheet(
                      context: context,
                      header: '배정요청',
                    );
                    if (msgRes != null && msgRes != '') {
                      bool postRes = await ref.watch(assignBedProvider.notifier).approveReq({
                        "ptId": widget.patient.ptId,
                        "bdasSeq": widget.bdasSeq,
                        "aprvYn": "Y",
                        "msg": msgRes.toString(),
                        // "chrgInstId": widget.hospList.items[selectedIdx!].chrgInstId,
                        "reqHospIdList": ["HP00002944"],
                      });
                      if (postRes) {
                        //승인성공
                        await ref.watch(patientTimeLineProvider.notifier).refresh(widget.patient.ptId, widget.bdasSeq);
                        await ref.watch(assignBedProvider.notifier).reloadPatients(); // 리스트 갱신
                        // ignore: use_build_context_synchronously
                        Common.showModal(
                          context,
                          // ignore: use_build_context_synchronously
                          Common.commonModal(
                            context: context,
                            imageWidget: Image.asset(
                              "assets/auth_group/modal_check.png",
                              width: 44.h,
                            ),
                            imageHeight: 44.h,
                            mainText: "배정 요청이 완료되었습니다.",
                            button2Function: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),
                        );
                      }
                    }
                  },
                  lBtnText: "배정 불가",
                  rBtnText: '배정 요청')
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

  Widget rowMultiSelectButton(list, selectList) {
    return Row(
      children: [
        Expanded(
          child: Wrap(
            spacing: 10.w,
            runSpacing: 12.h,
            direction: Axis.horizontal,
            children: [
              for (var i in list)
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: !selectList.contains(i) ? Colors.white : Palette.mainColor,
                    border: Border.all(
                      color: Palette.greyText_20,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(13.5.r),
                  ),
                  child: Text(i,
                      style: CTS.bold(
                        fontSize: 13,
                        color: selectList.contains(i) ? Palette.white : Palette.greyText_60,
                      )),
                )
            ],
          ),
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

        ///hintStyle: CTS.regular(
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
}

class HospList extends StateNotifier<List<String>> {
  HospList() : super([]);

  static final provider = StateNotifierProvider<HospList, List<String>>((ref) => HospList());

  void addHosp(String item) {
    state.add(item);
  }

  void removeHosp(String item) {
    state.remove(item);
  }

  bool contains(String item) => state.contains(item);
}
