import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/widgets/field_error_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/authentication/blocs/agency_region_bloc.dart';
import 'package:sbas/features/lookup/blocs/patient_register_bloc.dart';
import 'package:sbas/util.dart';
import 'package:sbas/constants/palette.dart';

class PatientRegInfo extends ConsumerStatefulWidget {
  PatientRegInfo({
    required this.formKey,
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
  ConsumerState<ConsumerStatefulWidget> createState() => PatientRegInfoState();

  final GlobalKey<FormState> formKey;
}

class PatientRegInfoState extends ConsumerState<PatientRegInfo> {
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
                    style: const TextStyle(
                      color: Palette.mainColor,
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
                          if (i == 2)
                            ref.watch(agencyRegionProvider).when(
                                  loading: () => const SBASProgressIndicator(),
                                  error: (error, stackTrace) => Center(
                                    child: Text(
                                      error.toString(),
                                      style: const TextStyle(
                                        color: Palette.mainColor,
                                      ),
                                    ),
                                  ),
                                  data: (region) => Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: FormField(
                                          builder: (field) => SizedBox(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                InputDecorator(
                                                  decoration: _inputDecoration,
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
                                                        items: region
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
                                                        value: vm.findPatientAddress(region, report.dstr1Cd),
                                                        onChanged: (value) {
                                                          final selectedRegion = region.firstWhere((e) => e.cdNm == value);

                                                          vm.updatePatientRegion(selectedRegion);

                                                          ref.read(agencyRegionProvider.notifier).selectTheCounty(selectedRegion);

                                                          field.didChange(value);
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Gaps.v8,
                                                if (field.hasError)
                                                  FieldErrorText(
                                                    field: field,
                                                  )
                                              ],
                                            ),
                                          ),
                                          initialValue: report.dstr1Cd,
                                          autovalidateMode: AutovalidateMode.always,
                                          validator: (value) => value == null || value.isEmpty ? '\'시/도\'를 선택해주세요.' : null,
                                        ),
                                      ),
                                      Gaps.h8,
                                      Expanded(
                                        flex: 1,
                                        child: FormField(
                                          autovalidateMode: AutovalidateMode.always,
                                          builder: (field) => SizedBox(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                InputDecorator(
                                                  decoration: _inputDecoration,
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
                                                        value: vm.findPatientAddress(region, report.dstr2Cd),
                                                        items: region
                                                            .where((e) => e.id != null && e.id?.cdGrpId != null && e.id!.cdGrpId!.length > 4)
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
                                                        onChanged: (value) {
                                                          final selectedRegion = region.firstWhere((e) => e.cdNm == value);

                                                          vm.updatePatientCounty(selectedRegion);

                                                          field.didChange(value);
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Gaps.v8,
                                                if (field.hasError)
                                                  FieldErrorText(
                                                    field: field,
                                                  ),
                                              ],
                                            ),
                                          ),
                                          initialValue: report.dstr2Cd,
                                          validator: (value) =>
                                              value == null || value.isEmpty || !ref.read(agencyRegionProvider.notifier).list.any((e) => e.cdNm == value)
                                                  ? '\'시/구/군\'을 선택해주세요.'
                                                  : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () => vm.updatePatientCrossroadsOfLife('N'),
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
                                        onTap: () => vm.updatePatientCrossroadsOfLife('Y'),
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
                                    report.dethYn == 'N' ? -1 : 1,
                                    0,
                                  ),
                                  duration: const Duration(
                                    milliseconds: 500,
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    width: MediaQuery.of(context).size.width * 0.5 - 24,
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
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () => vm.updatePatientNationality('KR'),
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
                                        onTap: () => vm.updatePatientNationality(''),
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
                                    width: MediaQuery.of(context).size.width * 0.5 - 24,
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
                          if (i != 3 && i != 4 || i == 4 && report.natiCd != 'KR')
                            TextFormField(
                              decoration: getInputDecoration(
                                '${widget.list[i]}${i == 0 || i == 4 || i == 9 ? '을' : '를'} 입력해주세요.',
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
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: () => vm.uploadPatientGender('남'),
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
                                            onTap: () => vm.uploadPatientGender('여'),
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
                                        report.gndr == '남' ? -1 : 1,
                                        0,
                                      ),
                                      duration: const Duration(
                                        milliseconds: 500,
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
                                        width: MediaQuery.of(context).size.width * 0.5 - 24,
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
