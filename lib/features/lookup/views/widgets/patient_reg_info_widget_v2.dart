import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/field_error_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/authentication/blocs/agency_region_bloc.dart';
import 'package:sbas/features/lookup/blocs/patient_register_bloc.dart';
import 'package:sbas/util.dart';
import 'package:sbas/constants/palette.dart';

class PatientRegInfoV2 extends ConsumerStatefulWidget {
  PatientRegInfoV2({
    required this.formKey,
    super.key,
  });
  final list = [
    '환자이름',
    '주민등록번호',
    '주소',
    '사망여부',
    '국적',
    '휴대전화번호',
    '전화번호',
    '보호자 이름',
    '직업',
  ];
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => PatientRegInfoV2State();

  final GlobalKey<FormState> formKey;
}

class PatientRegInfoV2State extends ConsumerState<PatientRegInfoV2> {
  bool init = true;

  @override
  Widget build(BuildContext context) {
    final vm = ref.read(patientRegProvider.notifier);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: widget.formKey,
        autovalidateMode: AutovalidateMode.always,
        child: SingleChildScrollView(
          child: ref.watch(patientRegProvider).when(
                loading: () => const SBASProgressIndicator(),
                error: (error, stackTrace) => Center(
                  child: Text(
                    error.toString(),
                    style: CTS(
                      color: Palette.mainColor,
                    ),
                  ),
                ),
                data: (report) => Column(
                  children: [
                    for (int i = 0; i < widget.list.length; i++)
                      Column(
                        children: [
                          i != 3
                              ? getSubTitlt(
                                  '${widget.list[i]}',
                                  i > 5,
                                )
                              : Container(),
                          Gaps.v4,
                          if (i == 2) addrInput(),
                          if (i == 3) isAlive(),
                          if (i == 4) nation(),
                          if (i == 4 && report.natiCd != 'KR') Gaps.v8,
                          if (i != 1 && i != 3 && i != 4)
                            TextFormField(
                              decoration: getInputDecoration(
                                i == 8 ? '직업을 알 수 있는 경우 기재' : '${widget.list[i]} 입력',
                              ),
                              controller: TextEditingController(
                                text: vm.getTextEditingController(i, report),
                              ),
                              onSaved: (newValue) => vm.setTextEditingController(i, newValue),
                              onChanged: (value) => ref.read(patientRegProvider.notifier).setTextEditingController(i, value),
                              validator: (value) => vm.isValid(i, value),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(vm.getRegExp(i)),
                                ),
                                FilteringTextInputFormatter.singleLineFormatter,
                              ],
                              keyboardType: vm.getKeyboardType(i),
                              autovalidateMode: AutovalidateMode.always,
                              maxLength: vm.getMaxLength(i),
                            ),
                          Gaps.v12,
                          if (i == 1)
                            Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        decoration: getInputDecoration(
                                          '${widget.list[i]}  입력',
                                        ),
                                        controller: TextEditingController(
                                          text: vm.getTextEditingController(i, report),
                                        ),
                                        onSaved: (newValue) => vm.setTextEditingController(i, newValue),
                                        onChanged: (value) => ref.read(patientRegProvider.notifier).setTextEditingController(i, value),
                                        validator: (value) => vm.isValid(i, value),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp(vm.getRegExp(i)),
                                          ),
                                          FilteringTextInputFormatter.singleLineFormatter,
                                        ],
                                        keyboardType: vm.getKeyboardType(i),
                                        autovalidateMode: AutovalidateMode.always,
                                        maxLength: vm.getMaxLength(i),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 24.h),
                                      height: 1.h,
                                      width: 4.w,
                                      color: Palette.greyText_60,
                                    ),
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: TextFormField(
                                              decoration: getInputDecoration(
                                                '${widget.list[i]} 입력',
                                              ),
                                              controller: TextEditingController(
                                                text: vm.getTextEditingController(i, report),
                                              ),
                                              onSaved: (newValue) => vm.setTextEditingController(i, newValue),
                                              onChanged: (value) => ref.read(patientRegProvider.notifier).setTextEditingController(i, value),
                                              validator: (value) => vm.isValid(i, value),
                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(
                                                  RegExp(vm.getRegExp(i)),
                                                ),
                                                FilteringTextInputFormatter.singleLineFormatter,
                                              ],
                                              keyboardType: vm.getKeyboardType(i),
                                              autovalidateMode: AutovalidateMode.always,
                                              maxLength: vm.getMaxLength(i),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              for (var k = 0; k < 5; k++)
                                                Container(
                                                  height: 8.h,
                                                  width: 8.w,
                                                  margin: EdgeInsets.only(
                                                    top: 20.h,
                                                    left: 8.w,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius: BorderRadius.circular(
                                                      99,
                                                    ),
                                                  ),
                                                ),
                                              Gaps.h32
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Gaps.v14,
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          getSubTitlt('성별', true),
                                          Gaps.v8,
                                          Container(
                                            padding: EdgeInsets.only(left: 20.w, top: 12.h, bottom: 12.h),
                                            decoration: BoxDecoration(
                                              color: Color(0xffecedef).withOpacity(0.2),
                                              border: Border.all(
                                                color: Palette.greyText_20,
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(4.r),
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "남자",
                                                  style: CTS(fontSize: 13),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Gaps.h8,
                                    Expanded(
                                      child: Column(
                                        children: [
                                          getSubTitlt('나이', true),
                                          Gaps.v8,
                                          Container(
                                            padding: EdgeInsets.only(left: 20.w, top: 12.h, bottom: 12.h, right: 12.w),
                                            decoration: BoxDecoration(
                                              color: Color(0xffecedef).withOpacity(0.2),
                                              border: Border.all(
                                                color: Palette.greyText_20,
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(4.r),
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "42",
                                                  style: CTS(fontSize: 13),
                                                ),
                                                Spacer(),
                                                Text(
                                                  '세',
                                                  style: CTS(
                                                    color: Palette.greyText,
                                                    fontSize: 13,
                                                    fontFamily: 'SpoqaHanSansNeo',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Gaps.v32,
                              ],
                            ),
                        ],
                      ),
                    Gaps.v20
                  ],
                ),
              ),
        ),
      ),
    );
  }

  Widget nation() {
    return Column(
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                //국적선택 로직
              },
              child: Container(
                margin: EdgeInsets.only(right: 7.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Palette.greyText_20,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 16.h),
                child: Text(
                  "대한민국",
                  style: CTS(
                    fontSize: 13,
                    color: Palette.greyText,
                  ),
                ),
              ),
            ),
            Expanded(child: _getTextInputField(hint: "직접입력")),
          ],
        ),
        Gaps.v10
      ],
    );
    ;
  }

  Widget addrInput() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _getTextInputField(hint: "기본주소 입력")),
            InkWell(
              onTap: () {
                //주소검색 로직
              },
              child: Container(
                margin: EdgeInsets.only(left: 7.w),
                decoration: BoxDecoration(
                  color: Palette.mainColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 16.h),
                child: Text(
                  "주소검색",
                  style: CTS(
                    fontSize: 13,
                    color: Palette.white,
                  ),
                ),
              ),
            )
          ],
        ),
        Gaps.v10
      ],
    );
  }

  Widget isAlive() {
    return Column(
      children: [
        Row(
          children: [
            getSubTitlt(widget.list[3], false),
            Spacer(),
            sliderRow(),
          ],
        ),
        Gaps.v12
      ],
    );
  }

  final oneList = ['생존', '사망'];
  int oneListSelected = 0;
  Widget sliderRow() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xffe4e4e4),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              for (var i in oneList)
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 10.h),
                      child: Text(i, style: CTS.bold(fontSize: 11, color: Colors.transparent)),
                    ),
                    Gaps.h1,
                  ],
                )
            ],
          ),
        ),
        Row(
          children: [
            for (var i in oneList)
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: oneList[oneListSelected] == i ? Color(0xff538ef5) : Colors.transparent,
                        borderRadius: oneList[oneListSelected] == i ? BorderRadius.circular(6) : null),
                    padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 10.h),
                    child: Text(i,
                        style: CTS.bold(
                          fontSize: 11,
                          color: oneList[oneListSelected] == i ? Palette.white : Palette.greyText_60,
                        )),
                  ),
                  i != '기타'
                      ? Container(
                          height: 12,
                          width: 1,
                          decoration: BoxDecoration(
                            color: Color(0xff676a7a).withOpacity(0.2),
                          ),
                        )
                      : Container(),
                ],
              )
          ],
        ),
      ],
    );
  }

  Widget _getTextInputField({required String hint, TextInputType type = TextInputType.text, int? maxLines, List<TextInputFormatter>? inputFormatters}) {
    return TextFormField(
      decoration: getInputDecoration(hint),
      controller: TextEditingController(
          // text: vm.init(i, widget.report),
          ),
      // onSaved: (newValue) => vm.setTextEditingController(i, newValue),
      // onChanged: (value) => vm.setTextEditingController(i, value),
      validator: (value) {
        return null;
      },
      inputFormatters: inputFormatters,
      autovalidateMode: AutovalidateMode.always,
      keyboardType: type,
      maxLines: maxLines,
      // maxLength: maxLength,
    );
  }

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
        counterText: "",
        contentPadding: const EdgeInsets.all(0),
      );
}
