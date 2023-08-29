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
import 'package:sbas/features/assign/presenters/asgn_bed_doc_approve_presenter.dart';
import 'package:sbas/features/assign/presenters/assign_bed_presenter.dart';
import 'package:sbas/features/lookup/models/patient_model.dart';
import 'package:sbas/features/lookup/models/patient_timeline_model.dart';
import 'package:sbas/features/lookup/presenters/patient_timeline_presenter.dart';
import 'package:sbas/features/lookup/views/widgets/patient_top_info_widget.dart';

class AsgnBdDoctorApproveScreen extends ConsumerWidget {
  const AsgnBdDoctorApproveScreen({
    super.key,
    required this.patient,
    required this.assignItem,
    required this.timeLine,
  });
  final Patient patient;
  final AssignItemModel assignItem;
  final TimeLine timeLine;

  final List<String> list = const ['의료기관명', '병실', '진료과', '담당의', '연락처', '메시지'];
  final List<String> hintList = const ['칠곡경북대병원', '병실번호', '진료과 이름', '담당의 이름', '의료진 연락처 입력', '메시지 입력'];
  // 이부분 의료기관명 readonly 로 들어갈부분.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        child: Scaffold(
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
      body: ref.watch(asgnBdDocProvider).when(
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
                            for (var i = 0; i < list.length; i++)
                              Column(
                                children: [
                                  _getTitle(list[i], i == 0 ? null : false),
                                  Gaps.v16,
                                  i == 0
                                      ? _getTextInputField(i: i, initalValue: timeLine.chrgInstId ?? "", isFixed: true, ref: ref)
                                      : _getTextInputField(i: i, hint: hintList[i], ref: ref),
                                  Gaps.v28,
                                ],
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Common.bottomer(
                    rBtnText: "배정 승인",
                    isOneBtn: true,
                    lBtnFunc: () {},
                    rBtnFunc: () async {
                      var confirm = await Common.showModal(
                          context,
                          Common.commonModal(
                            context: context,
                            mainText: "배정 승인 하시겠습니까?",
                            imageWidget: Image.asset(
                              "assets/auth_group/modal_check.png",
                              width: 44.h,
                            ),
                            button1Function: () {
                              Navigator.pop(context, false);
                            },
                            button2Function: () {
                              Navigator.pop(context, true);
                            },
                            imageHeight: 44.h,
                          ));

                      if (confirm == true) {
                        //제대로된 msg res 가 리턴된 케이스 (페이지라우트)
                        ref
                            .watch(asgnBdDocProvider.notifier)
                            .init(assignItem.ptId ?? "", "Y", assignItem.bdasSeq ?? -1, timeLine.asgnReqSeq ?? -1, timeLine.chrgInstId ?? "");
                        if (ref.watch(asgnBdDocProvider.notifier).isValid() == true) {
                          bool aprvDocRes = await ref.watch(asgnBdDocProvider.notifier).aprvDocReq();

                          if (aprvDocRes) {
                            await ref.watch(patientTimeLineProvider.notifier).refresh(assignItem.ptId, assignItem.bdasSeq);
                            await ref.watch(assignBedProvider.notifier).reloadPatients(); // 리스트 갱신
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          }
                        }
                      } else {
                        return;
                      }
                    },
                  )
                ],
              ),
            ),
          ),
    ));
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
    final bdDoc = ref.watch(asgnBdDocProvider.notifier);
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

  Widget _getTitle(String title, bool? isRequired) => Row(
        children: [
          Text(
            title,
            style: CTS.medium(
              color: Colors.grey.shade600,
              fontSize: 13.sp,
            ),
          ),
          Text(
            isRequired == null
                ? ""
                : isRequired
                    ? "(필수)"
                    : "(선택)",
            style: CTS.medium(
              fontSize: 13,
              color: !(isRequired ?? false) ? Colors.grey.shade600 : Palette.mainColor,
            ),
          ),
        ],
      );

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

  InputBorder get _inputBorder => OutlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            8.r,
          ),
        ),
      );
  InputDecoration get _inputDecoration => InputDecoration(
        enabledBorder: _inputBorder,
        focusedBorder: _inputBorder,
        contentPadding: const EdgeInsets.all(0),
      );
}
