import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/common.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/assign/model/assign_item_model.dart';
import 'package:sbas/features/assign/presenters/asgn_bed_hospital_presenter.dart';
import 'package:sbas/features/assign/presenters/assign_bed_presenter.dart';
import 'package:sbas/features/lookup/models/patient_model.dart';
import 'package:sbas/features/lookup/models/patient_timeline_model.dart';
import 'package:sbas/features/lookup/presenters/patient_timeline_presenter.dart';
import 'package:sbas/features/lookup/views/widgets/patient_top_info_widget.dart';

class AssignBedGoHome extends ConsumerWidget {
  const AssignBedGoHome({
    super.key,
    required this.patient,
    required this.assignItem,
    required this.timeLine,
  });
  final Patient patient;
  final AssignItemModel assignItem;
  final TimeLine timeLine;

  final List<String> list = const ['의료기관명', '병실', '진료과', '병실', '담당의', '연락처', '메시지'];
  final List<String> hintList = const ['칠곡경북대병원', '병실번호', '진료과 입력', '병실번호 입력', '담당의 이름', '의료진 연락처 입력', '입원/퇴원/회송 사유 입력'];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Palette.white,
      appBar: AppBar(
        title: Text(
          "입·퇴원 처리",
          style: CTS.medium(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.close,
              color: Palette.greyText,
              weight: 24.h,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        elevation: 0.5,
        centerTitle: true,
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        automaticallyImplyLeading: false,
      ),
      body: ref.watch(asgnBdHospProvider).when(
            loading: () => const SBASProgressIndicator(),
            error: (error, stackTrace) => Center(
              child: Text(
                error.toString(),
                style: const TextStyle(
                  color: Palette.mainColor,
                ),
              ),
            ),
            data: (_) => GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                children: [
                  PatientTopInfo(patient: patient),
                  Divider(
                    color: Palette.greyText_20,
                    height: 1,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          children: [
                            Gaps.v20,
                            _getTitle("입·퇴원 상태", true),
                            Gaps.v16,
                            rowSelectButton(['입원', '퇴원', '자택귀가'], ref),
                            Gaps.v28,
                            for (var i = 0; i < list.length; i++)
                              Column(
                                children: [
                                  _getTitle(list[i], false),
                                  Gaps.v16,
                                  _getTextInputField(ref: ref, i: i, hint: hintList[i], isFixed: i == 0),
                                  Gaps.v28,
                                ],
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Common.bottomer(
                    rBtnText: "처리 완료",
                    isOneBtn: true,
                    lBtnFunc: () {},
                    rBtnFunc: () async {
                      // var confirm = await Common.showModal(
                      //     context,
                      //     Common.commonModal(
                      //       context: context,
                      //       mainText: "배정 승인 하시겠습니까?",
                      //       imageWidget: Image.asset(
                      //         "assets/auth_group/modal_check.png",
                      //         width: 44.h,
                      //       ),
                      //       button1Function: () {
                      //         Navigator.pop(context, false);
                      //       },
                      //       button2Function: () {
                      //         Navigator.pop(context, true);
                      //       },
                      //       imageHeight: 44.h,
                      //     ));

                      // if (confirm == true) {
                      if (true) {
                        //제대로된 msg res 가 리턴된 케이스 (페이지라우트)
                        ref
                            .watch(asgnBdHospProvider.notifier)
                            .init(assignItem.ptId ?? "", "Y", assignItem.bdasSeq ?? -1, timeLine.asgnReqSeq ?? -1, timeLine.chrgInstId ?? "");
                        if (ref.watch(asgnBdHospProvider.notifier).isValid() == true) {
                          await ref.watch(asgnBdHospProvider.notifier).aprvDocReq();
                          await Future.delayed(Duration(milliseconds: 1500));
                          await ref.watch(patientTimeLineProvider.notifier).refresh(assignItem.ptId, assignItem.bdasSeq);
                          await ref.watch(assignBedProvider.notifier).reloadPatients(); // 리스트 갱신

                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        }
                      }
                      // } else {
                      //   return;
                      // }
                    },
                  )
                ],
              ),
            ),
          ),
    );
  }

  Widget _getTextInputField(
      {required int i,
      bool isFixed = false,
      String? hint,
      String? initalValue,
      TextInputType type = TextInputType.text,
      int? maxLines,
      List<TextInputFormatter>? inputFormatters,
      required WidgetRef ref}) {
    final bdDoc = ref.watch(asgnBdHospProvider.notifier);
    return TextFormField(
      // textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
      style: CTS.regular(
        fontSize: 12.sp,
        color: isFixed ? Palette.greyText_60 : Palette.black,
      ),
      enabled: !isFixed,
      decoration: !isFixed
          ? getInputDecoration(hint ?? "")
          : InputDecoration(
              filled: true,
              fillColor: Palette.disabledTextField,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 20.h,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(4.r),
                ),
              ),
            ),
      onSaved: (newValue) => bdDoc.setTextByIndex(i, newValue),
      onChanged: (value) => bdDoc.setTextByIndex(i, value),
      validator: (value) {
        return null;
      },
      initialValue: initalValue,
      readOnly: isFixed,

      inputFormatters: inputFormatters,
      autovalidateMode: AutovalidateMode.always,
      keyboardType: type,
      maxLines: maxLines,
      // maxLength: maxLength,
    );
  }

  Widget _getTitle(String title, bool isRequired) => Row(
        children: [
          Text(
            title,
            style: CTS.medium(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),
          Text(
            isRequired ? '(필수)' : '(선택)',
            style: CTS.medium(
              fontSize: 13,
              color: !isRequired ? Colors.grey.shade600 : Palette.mainColor,
            ),
          ),
        ],
      );

  Widget dropdownButton(List<String> dlist, String sel) {
    return SizedBox(
      height: 48.h,
      child: DropdownButtonFormField(
        borderRadius: BorderRadius.circular(4.r),
        decoration: Common.getInputDecoration(""),
        value: sel,
        items: dlist.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: CTS(fontSize: 10, color: Palette.black),
            ),
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

  Widget rowSelectButton(List<String> list, WidgetRef ref) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xffe4e4e4),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              for (var i in list)
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(i, style: CTS.bold(fontSize: 11, color: Colors.transparent)),
                      ),
                      Gaps.h1,
                    ],
                  ),
                ),
            ],
          ),
        ),
        Row(
          children: [
            for (var i in list)
              Expanded(
                child: InkWell(
                  onTap: () {
                    print(i);
                    ref.watch(gotoTargetProvider.notifier).update((state) => list.indexOf(i));

                    // setState(() {
                    //   selectedRadio = list.indexOf(i);
                    // });
                  },
                  child: Consumer(
                      builder: (context, r, child) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: list.indexOf(i) == r.watch(gotoTargetProvider.notifier).state ? const Color(0xff538ef5) : Colors.transparent,
                                      borderRadius: list.indexOf(i) == r.watch(gotoTargetProvider.notifier).state ? BorderRadius.circular(6) : null),
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: Text(i,
                                      style: CTS.bold(
                                        fontSize: 11,
                                        color: list.indexOf(i) == r.watch(gotoTargetProvider.notifier).state ? Palette.white : Palette.greyText_60,
                                      )),
                                ),
                              ),
                              i != list.last
                                  ? Container(
                                      height: 12,
                                      width: 1,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff676a7a).withOpacity(0.2),
                                      ),
                                    )
                                  : Container(),
                            ],
                          )),
                ),
              )
          ],
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
        hintStyle: CTS.regular(
          fontSize: 12.sp,
          color: Palette.greyText_60,
        ),
        contentPadding: hintText == ""
            ? EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 14.h,
              )
            : const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 22,
              ),
      );
}
