import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/common/widgets/app_bar_widget.dart';
import 'package:sbas/constants/common.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/assign/model/assign_item_model.dart';
import 'package:sbas/features/assign/presenters/assign_bed_cancel_presenter.dart';
import 'package:sbas/features/lookup/models/patient_model.dart';
import 'package:sbas/features/lookup/models/patient_timeline_model.dart';
import 'package:sbas/features/lookup/views/widgets/patient_top_info_widget.dart';

final selectedItem = StateProvider<BaseCodeModel>((ref) => BaseCodeModel());

class AssignBedCancelScreen extends ConsumerStatefulWidget {
  const AssignBedCancelScreen({
    super.key,
    required this.patient,
    required this.assignItem,
    required this.timeLine,
  });

  final Patient patient;
  final TimeLine timeLine;
  final AssignItemModel assignItem;

  @override
  ConsumerState<AssignBedCancelScreen> createState() =>
      _AssignBedCancelScreenState();
}

class _AssignBedCancelScreenState extends ConsumerState<AssignBedCancelScreen> {
  List<String> list = ['의료기관명', '메시지'];
  List<String> hintList = ['칠곡경북대병원', '메시지 입력'];

  // 이부분 의료기관명 readonly 로 들어갈부분.
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(asgnBdCancelProvider.notifier).init(
          bdasSeq: widget.assignItem.bdasSeq,
          ptId: widget.patient.ptId,
          hospId: widget.timeLine.chrgInstId,
          asgnReqSeq: widget.timeLine.asgnReqSeq);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.white,
        appBar: const SBASAppBar(
          title: '배정 불가',
          elevation: 0.5,
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
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children: [
                        Gaps.v20,
                        Column(
                          children: [
                            _getTitle(list[0], false),
                            Gaps.v16,
                            _getTextInputField(
                                hint: widget.timeLine.chrgInstNm ?? "",
                                isFixed: true),
                            Gaps.v28,
                            _getTitle('불가 사유', true),
                            Gaps.v16,
                            ref.watch(asgnBdCancelProvider).when(
                                  data: (data) => rowMultiSelectButton(data),
                                  loading: () => const Center(
                                      child: CircularProgressIndicator()),
                                  error: (e, s) =>
                                      Center(child: Text(e.toString())),
                                ),
                            Gaps.v28,
                            _getTitle(list[1], true),
                            Gaps.v16,
                            _getTextInputField(hint: hintList[1]),
                            Gaps.v28,
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Common.bottomer(
                rBtnText: "불가 처리",
                isOneBtn: true,
                lBtnFunc: () {},
                rBtnFunc: () async {
                  if (ref.watch(asgnBdCancelProvider.notifier).validate()) {
                    var res = await ref
                        .watch(asgnBdCancelProvider.notifier)
                        .asgnBdCancelPost();
                    if (res) {
                      // showToast("불가 처리 되었습니다.");
                      ref.watch(selectedItem.notifier).state = BaseCodeModel();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  }
                },
              )
            ],
          ),
        ));
  }

  Widget rowMultiSelectButton(List<BaseCodeModel> list) {
    return Row(
      children: [
        Expanded(
          child: Wrap(
            spacing: 11.w,
            runSpacing: 12.h,
            direction: Axis.horizontal,
            children: [
              for (var i in list)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      ref
                          .watch(asgnBdCancelProvider.notifier)
                          .setBNRN(i.cdId ?? "");
                    });
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: i.cdId !=
                              ref.watch(asgnBdCancelProvider.notifier).getNegCd
                          ? Colors.white
                          : Palette.mainColor,
                      border: Border.all(
                        color: Palette.greyText_20,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(13.5.r),
                    ),
                    child: Text(i.cdNm ?? "",
                        style: CTS.bold(
                          fontSize: 13,
                          color: i.cdId ==
                                  ref
                                      .watch(asgnBdCancelProvider.notifier)
                                      .getNegCd
                              ? Palette.white
                              : Palette.greyText_60,
                        )),
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }

  Widget _getTextInputField(
      {bool isFixed = false,
      required String hint,
      TextInputType type = TextInputType.text,
      int? maxLines,
      List<TextInputFormatter>? inputFormatters}) {
    return TextFormField(
      style: isFixed
          ? CTS(
              color: Palette.greyText_60,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500)
          : CTS(color: Palette.black, fontSize: 13.sp),
      decoration: !isFixed
          ? getInputDecoration(hint)
          : InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade300,
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
      controller: TextEditingController(
          text:
              isFixed ? hint : ref.watch(asgnBdCancelProvider.notifier).getMsg),
      onSaved: (newValue) =>
          ref.watch(asgnBdCancelProvider.notifier).setMsg(newValue ?? ""),
      onChanged: (newValue) =>
          ref.watch(asgnBdCancelProvider.notifier).setMsg(newValue),
      validator: (value) {
        return null;
      },
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
            title == '의료기관명' ? '' : '(필수)',
            style: CTS.medium(
              fontSize: 13,
              color: !isRequired ? Colors.grey.shade600 : Palette.mainColor,
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
          fontSize: 13.sp,
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
        borderRadius: const BorderRadius.all(
          Radius.circular(
            8,
          ),
        ),
      );

  InputDecoration get _inputDecoration => InputDecoration(
        enabledBorder: _inputBorder,
        focusedBorder: _inputBorder,
        contentPadding: const EdgeInsets.all(0),
      );
}
