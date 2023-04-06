import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/lookup/blocs/patient_register_bloc.dart';
import 'package:sbas/util.dart';

class PatientRegInfo extends ConsumerStatefulWidget {
  PatientRegInfo({
    super.key,
  });
  final list = [
    '환자이름',
    '생년월일',
    '주소',
    '사망여부',
    '국적',
    '휴대전화번호',
    '전화번호',
    '보호자',
    '직업',
  ];
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PatientRegInfoState();
}

class _PatientRegInfoState extends ConsumerState<PatientRegInfo> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.read(patientRegProvider.notifier);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.always,
        child: SingleChildScrollView(
          child: ref.watch(patientRegProvider).when(
                loading: () => const SBASProgressIndicator(),
                error: (error, stackTrace) => Center(
                  child: Text(
                    error.toString(),
                    style: const TextStyle(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ),
                data: (report) => Column(
                  children: [
                    for (int i = 0; i < widget.list.length; i++)
                      Column(
                        children: [
                          getSubTitlt(
                            '${i + 1}.${widget.list[i]}',
                            i > 5,
                          ),
                          Gaps.v4,
                          /*
                          if (i == 2)
                            FormField(
                initialValue: ref.watch(selectedRegionProvider).cdNm,
                autovalidateMode: AutovalidateMode.always,
                validator: (value) =>
                    value == null || value.isEmpty ? '\'시/도\'를 선택해주세요.' : null,
                builder: (field) => SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputDecorator(
                        decoration: widget.inputDecoration,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 8,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: const SizedBox(
                                width: 150,
                                child: Text(
                                  '시/도 선택',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              isDense: true,
                              isExpanded: true,
                              value: ref.watch(selectedRegionProvider).cdNm,
                              items: data
                                  .where((e) => e.id?.cdGrpId == 'SIDO')
                                  .map(
                                    (e) => DropdownMenuItem(
                                      alignment: Alignment.center,
                                      value: e.cdNm,
                                      child: SizedBox(
                                        width: 150,
                                        child: Text(
                                          e.cdNm ?? '',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) => setState(
                                () {
                                  final model =
                                      ref.read(selectedRegionProvider);

                                  final selectedModel =
                                      data.firstWhere((e) => value == e.cdNm);

                                  ref.read(selectedCountyProvider).cdNm = null;

                                  model.cdGrpNm = selectedModel.cdGrpNm;
                                  model.cdNm = selectedModel.cdNm;
                                  model.cdSeq = selectedModel.cdSeq;
                                  model.cdVal = selectedModel.cdVal;
                                  model.id = selectedModel.id;
                                  model.rgstDttm = selectedModel.rgstDttm;
                                  model.rgstUserId = selectedModel.rgstUserId;
                                  model.rmk = selectedModel.rmk;
                                  model.updtDttm = selectedModel.updtDttm;
                                  model.updtUserId = selectedModel.updtUserId;

                                  ref
                                      .read(agencyRegionProvider.notifier)
                                      .exchangeTheCounty();

                                  field.didChange(selectedModel.cdNm);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (field.hasError) Gaps.v12,
                      if (field.hasError)
                        FieldErrorText(
                          field: field,
                        )
                    ],
                  ),
                ),
              ),
            ),
            Gaps.h14,
            Expanded(
              flex: 1,
              child: FormField(
                autovalidateMode: AutovalidateMode.always,
                initialValue: ref.watch(selectedCountyProvider).cdNm,
                validator: (value) => value == null ||
                        value.isEmpty ||
                        ref.watch(selectedCountyProvider).cdNm == null
                    ? '\'시/구/군\'을 선택해주세요.'
                    : null,
                builder: (field) => SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputDecorator(
                        decoration: widget.inputDecoration,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 8,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: const SizedBox(
                                width: 150,
                                child: Text(
                                  '시/구/군 선택',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              isDense: true,
                              isExpanded: true,
                              value: ref.watch(selectedCountyProvider).cdNm,
                              items: data
                                  .where((e) =>
                                      e.id != null &&
                                      e.id?.cdGrpId != null &&
                                      e.id!.cdGrpId!.length > 4)
                                  .map(
                                    (e) => DropdownMenuItem(
                                      alignment: Alignment.center,
                                      value: e.cdNm,
                                      child: SizedBox(
                                        width: 150,
                                        child: Text(
                                          e.cdNm ?? '',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) => setState(
                                () {
                                  final model =
                                      ref.read(selectedCountyProvider);

                                  final selectedModel =
                                      data.firstWhere((e) => value == e.cdNm);

                                  final agency =
                                      ref.watch(selectedAgencyProvider);

                                  agency.instNm = null;
                                  agency.id = null;

                                  model.cdGrpNm = selectedModel.cdGrpNm;
                                  model.cdNm = selectedModel.cdNm;
                                  model.cdSeq = selectedModel.cdSeq;
                                  model.cdVal = selectedModel.cdVal;
                                  model.id = selectedModel.id;
                                  model.rgstDttm = selectedModel.rgstDttm;
                                  model.rgstUserId = selectedModel.rgstUserId;
                                  model.rmk = selectedModel.rmk;
                                  model.updtDttm = selectedModel.updtDttm;
                                  model.updtUserId = selectedModel.updtUserId;

                                  ref
                                      .read(agencyDetailProvider.notifier)
                                      .exchangeTheAgency();

                                  field.didChange(selectedModel.cdNm);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (field.hasError) Gaps.v12,
                      if (field.hasError)
                        FieldErrorText(
                          field: field,
                        ),
                    ],
                  ),
                ),
              ) */
                          if (i == 3)
                            Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDCDCDC),
                                    borderRadius: BorderRadius.circular(
                                      24,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () => vm
                                            .uploadPatientCrossroadsOfLife('Y'),
                                        child: const Text(
                                          '  생존  ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => vm
                                            .uploadPatientCrossroadsOfLife('N'),
                                        child: const Text(
                                          '  사망  ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                AnimatedAlign(
                                  heightFactor: 1.2,
                                  alignment: Alignment(
                                    report.dethYn == 'Y' ? -1 : 1,
                                    0,
                                  ),
                                  duration: const Duration(
                                    milliseconds: 500,
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                            0.5 -
                                        24,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        24,
                                      ),
                                      color: const Color(0x7C00BFFF),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          else if (i == 4)
                            Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDCDCDC),
                                    borderRadius: BorderRadius.circular(
                                      24,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () =>
                                            vm.uploadPatientNationality('KR'),
                                        child: const Text(
                                          '대한민국',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () =>
                                            vm.uploadPatientNationality(''),
                                        child: const Text(
                                          ' 외국인 ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                AnimatedAlign(
                                  heightFactor: 1.2,
                                  alignment: Alignment(
                                    report.natiCd == 'KR' ? -1 : 1,
                                    0,
                                  ),
                                  duration: const Duration(
                                    milliseconds: 500,
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                            0.5 -
                                        24,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        24,
                                      ),
                                      color: const Color(0x7C00BFFF),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if (i == 4 && report.natiCd != 'KR') Gaps.v8,
                          if (i != 3 && i != 4 ||
                              i == 4 && report.natiCd != 'KR')
                            TextFormField(
                              decoration: getInputDecoration(
                                '${widget.list[i]}${i == 0 || i == 4 || i == 9 ? '을' : '를'} 입력해주세요.',
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
                                getSubTitlt(
                                  ' 성별',
                                  true,
                                ),
                                Gaps.v4,
                                Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFDCDCDC),
                                        borderRadius: BorderRadius.circular(
                                          24,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: () =>
                                                vm.uploadPatientGender('M'),
                                            child: const Text(
                                              '   남   ',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () =>
                                                vm.uploadPatientGender('F'),
                                            child: const Text(
                                              '   여   ',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    AnimatedAlign(
                                      heightFactor: 1.2,
                                      alignment: Alignment(
                                        report.gndr == 'M' ? -1 : 1,
                                        0,
                                      ),
                                      duration: const Duration(
                                        milliseconds: 500,
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                    0.5 -
                                                24,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            24,
                                          ),
                                          color: const Color(0x7C00BFFF),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Gaps.v14,
                              ],
                            ),
                        ],
                      ),
                  ],
                ),
              ),
        ),
      ),
    );
  }

  final formKey = GlobalKey<FormState>();
}
