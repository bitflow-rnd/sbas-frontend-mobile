import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kpostal/kpostal.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/lookup/blocs/patient_register_bloc.dart';
import 'package:sbas/features/lookup/models/patient_reg_info_model.dart';
import 'package:sbas/util.dart';
import 'package:sbas/constants/palette.dart';

class PatientRegInfoV2 extends ConsumerStatefulWidget {
  PatientRegInfoV2({
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
  final oneList = [
    '생존',
    '사망',
  ];
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      PatientRegInfoV2State();
}

class PatientRegInfoV2State extends ConsumerState<PatientRegInfoV2> {
  Widget _inputResidentRegistrationNumber(
    PatientRegisterPresenter vm,
    PatientRegInfoModel report,
    int index,
  ) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              decoration: getInputDecoration(
                '${widget.list[index]} 입력',
              ),
              controller: TextEditingController(
                text: vm.getTextEditingController(index, report),
              ),
              onSaved: (newValue) =>
                  vm.setTextEditingController(index, newValue),
              onChanged: (value) => ref
                  .read(patientRegProvider.notifier)
                  .setTextEditingController(index, value),
              validator: (value) => vm.isValid(index, value),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(vm.getRegExp(index)),
                ),
                FilteringTextInputFormatter.singleLineFormatter,
              ],
              keyboardType: vm.getKeyboardType(index),
              autovalidateMode: AutovalidateMode.always,
              maxLength: vm.getMaxLength(index),
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
                    decoration: getInputDecoration(''),
                    controller: TextEditingController(
                      text: vm.getTextEditingController(index + 100, report),
                    ),
                    onSaved: (newValue) =>
                        vm.setTextEditingController(index + 100, newValue),
                    onChanged: (value) => ref
                        .read(patientRegProvider.notifier)
                        .setTextEditingController(index + 100, value),
                    validator: (value) => vm.isValid(index + 100, value),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(vm.getRegExp(index + 100)),
                      ),
                      FilteringTextInputFormatter.singleLineFormatter,
                    ],
                    keyboardType: vm.getKeyboardType(index + 100),
                    autovalidateMode: AutovalidateMode.always,
                    maxLength: vm.getMaxLength(index + 100),
                  ),
                ),
                Row(
                  children: [
                    for (var k = 0; k < 6; k++)
                      Container(
                        height: 8.h,
                        width: 8.w,
                        margin: EdgeInsets.only(
                          top: 20.h,
                          left: 7.w,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(
                            99,
                          ),
                        ),
                      ),
                    Gaps.h16,
                  ],
                )
              ],
            ),
          ),
        ],
      );
  Widget _inputGender(PatientRegisterPresenter vm) => Column(
        children: [
          getSubTitlt('성별', true),
          Gaps.v8,
          Container(
            padding: EdgeInsets.only(left: 20.w, top: 12.h, bottom: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xffecedef).withOpacity(0.2),
              border: Border.all(
                color: Palette.greyText_20,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Row(
              children: [
                Text(
                  vm.sex ?? '',
                  style: CTS(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      );
  Widget _inputAge(PatientRegisterPresenter vm) => Column(
        children: [
          getSubTitlt('나이', true),
          Gaps.v8,
          Container(
            padding: EdgeInsets.only(
                left: 20.w, top: 12.h, bottom: 12.h, right: 12.w),
            decoration: BoxDecoration(
              color: const Color(0xffecedef).withOpacity(0.2),
              border: Border.all(
                color: Palette.greyText_20,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Row(
              children: [
                Text(
                  vm.age,
                  style: CTS(fontSize: 13),
                ),
                const Spacer(),
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
      );
  Widget _addrInput(PatientRegisterPresenter vm) => Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: getInputDecoration("주소검색을 이용하여 입력"),
                  controller: TextEditingController(text: vm.address),
                  validator: (value) => null,
                  readOnly: true,
                  maxLines: 1,
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => KpostalView(
                      kakaoKey: dotenv.env['KAKAO'] ?? '',
                      callback: (postal) => vm.setAddress(postal),
                    ),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 7.w),
                  decoration: BoxDecoration(
                    color: Palette.mainColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 28.w, vertical: 15.h),
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
  Widget _sliderRow(PatientRegisterPresenter vm) => Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffe4e4e4),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                for (var i in widget.oneList)
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 28.w, vertical: 10.h),
                        child: Text(i,
                            style: CTS.bold(
                              fontSize: 11,
                              color: Colors.transparent,
                            )),
                      ),
                      Gaps.h1,
                    ],
                  )
              ],
            ),
          ),
          Row(
            children: [
              for (var i in widget.oneList)
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => vm.setSurvivalStatus(i),
                      child: Container(
                        decoration: BoxDecoration(
                            color: widget.oneList[vm.isSurvivalStatus] == i
                                ? const Color(0xff538ef5)
                                : Colors.transparent,
                            borderRadius:
                                widget.oneList[vm.isSurvivalStatus] == i
                                    ? BorderRadius.circular(6)
                                    : null),
                        padding: EdgeInsets.symmetric(
                            horizontal: 28.w, vertical: 10.h),
                        child: Text(i,
                            style: CTS.bold(
                              fontSize: 11,
                              color: widget.oneList[vm.isSurvivalStatus] == i
                                  ? Palette.white
                                  : Palette.greyText_60,
                            )),
                      ),
                    ),
                    i != '기타'
                        ? Container(
                            height: 12,
                            width: 1,
                            decoration: BoxDecoration(
                              color: const Color(0xff676a7a).withOpacity(0.2),
                            ),
                          )
                        : Container(),
                  ],
                ),
            ],
          ),
        ],
      );
  Widget _isAlive(PatientRegisterPresenter vm) => Column(
        children: [
          Row(
            children: [
              getSubTitlt(widget.list[3], false),
              const Spacer(),
              _sliderRow(vm),
            ],
          ),
          Gaps.v12
        ],
      );
  Widget _nation(PatientRegInfoModel report, PatientRegisterPresenter vm) =>
      Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => vm.setNation(report),
                child: Container(
                  margin: EdgeInsets.only(right: 7.w),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Palette.greyText_20,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 28.w, vertical: 13.5.h),
                  child: Text(
                    vm.getTextEditingController(4, report),
                    style: CTS(
                      fontSize: 13,
                      color: Palette.greyText,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  decoration:
                      getInputDecoration(report.natiCd == 'NATI0001' ? '' : '직접입력'),
                  controller: TextEditingController(
                    text: vm.getTextEditingController(104, report),
                  ),
                  onSaved: (newValue) =>
                      vm.setTextEditingController(104, newValue),
                  onChanged: (value) => vm.setTextEditingController(104, value),
                  validator: (value) {
                    return null;
                  },
                  inputFormatters: null,
                  autovalidateMode: AutovalidateMode.always,
                  keyboardType: TextInputType.streetAddress,
                  maxLines: 1,
                  readOnly: report.natiCd == 'NATI0001',
                ),
              ),
            ],
          ),
          Gaps.v10
        ],
      );
  @override
  Widget build(BuildContext context) {
    final vm = ref.read(patientRegProvider.notifier);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
          ),
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
                                  widget.list[i],
                                  i > 5,
                                )
                              : Container(),
                          Gaps.v4,
                          if (i == 2) _addrInput(vm),
                          if (i == 3) _isAlive(vm),
                          if (i == 4) _nation(report, vm),
                          if (i == 4 && report.natiCd != 'NATI0001') Gaps.v8,
                          if (i != 1 && i != 3 && i != 4)
                            TextFormField(
                              decoration: getInputDecoration(
                                i == 8
                                    ? '직업을 알 수 있는 경우 기재'
                                    : i == 2
                                        ? '나머지 ${widget.list[i]} 입력'
                                        : '${widget.list[i]} 입력',
                              ),
                              controller: TextEditingController(
                                text: vm.getTextEditingController(i, report),
                              ),
                              onSaved: (newValue) =>
                                  vm.setTextEditingController(i, newValue),
                              onChanged: (value) => ref
                                  .read(patientRegProvider.notifier)
                                  .setTextEditingController(i, value),
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
                                _inputResidentRegistrationNumber(vm, report, i),
                                Gaps.v14,
                                Row(
                                  children: [
                                    Expanded(
                                      child: _inputGender(vm),
                                    ),
                                    Gaps.h8,
                                    Expanded(
                                      child: _inputAge(vm),
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
}
