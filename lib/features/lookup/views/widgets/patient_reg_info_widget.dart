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
                          TextFormField(
                            decoration: getInputDecoration(
                              '${widget.list[i]}${i == 0 || i == 9 ? '을' : '를'} 입력해주세요.',
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
