import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/lookup/blocs/patient_register_bloc.dart';
import 'package:sbas/features/lookup/models/patient_reg_info_model.dart';
import 'package:sbas/util.dart';

class PatientRegInfo extends ConsumerStatefulWidget {
  PatientRegInfo({
    super.key,
  });
  int? getMaxLength(int index) {
    switch (index) {
      case 0:
      case 7:
        return 7;

      case 1:
        return 6;

      case 5:
      case 6:
        return 11;

      case 4:
      case 8:
        return 9;
    }
    return null;
  }

  String getTextEditingController(
    int index,
    PatientRegInfoModel report,
  ) {
    switch (index) {
      case 0:
        return report.ptNm ?? '';

      case 1:
        return report.rrno1 ?? '';

      case 2:
        return report.addr ?? '';

      case 3:
        return report.dethYn ?? '';

      case 5:
        return report.mpno ?? '';

      case 8:
        return report.job ?? '';

      default:
        return '';
    }
  }

  String? isValid(int index, String? value) {
    switch (index) {
      case 0:
        if (value == null ||
            value.length < 2 ||
            RegExp(
                  r'[\uac00-\ud7af]',
                  unicode: true,
                ).allMatches(value).length !=
                value.length) {
          return '본인 이름을 정확히 입력하세요.';
        }
        break;

      case 1:
        if (value == null ||
            value.length != 6 ||
            !RegExp(r'^\d{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])$')
                .hasMatch(value)) {
          return '본인 생년월일을 정확히 입력하세요.';
        }
        break;

      case 2:
        if (value == null || value.isEmpty) {
          return '주소를 정확히 입력하세요.';
        }
        break;

      case 5:
        if (value == null || value.length != 11) {
          return '휴대전화번호를 정확히 입력하세요.';
        }
        break;
    }
    return null;
  }

  String getRegExp(int index) {
    switch (index) {
      case 0:
      case 7:
      case 8:
        return r'[가-힝|ㄱ-ㅎ|ㆍ|ᆢ]';

      case 2:
        return r'[A-Z|a-z|0-9|()-|가-힝|ㄱ-ㅎ|ㆍ|ᆢ]';

      case 4:
        return r'[A-Z|a-z|-|가-힝|ㄱ-ㅎ|ㆍ|ᆢ]';

      case 1:
      case 5:
      case 6:
        return r'[0-9]';

      default:
        return '';
    }
  }

  TextInputType getKeyboardType(int index) {
    switch (index) {
      case 0:
      case 7:
      case 8:
        return TextInputType.text;

      case 2:
      case 4:
        return TextInputType.streetAddress;

      case 1:
      case 5:
      case 6:
        return TextInputType.number;

      default:
        return TextInputType.none;
    }
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PatientRegInfoState();

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
}

class _PatientRegInfoState extends ConsumerState<PatientRegInfo> {
  @override
  Widget build(BuildContext context) => GestureDetector(
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
                                text:
                                    widget.getTextEditingController(i, report),
                              ),
                              onSaved: (newValue) => ref
                                  .read(patientRegProvider.notifier)
                                  .setTextEditingController(i, newValue),
                              onChanged: (value) => ref
                                  .read(patientRegProvider.notifier)
                                  .setTextEditingController(i, value),
                              validator: (value) => widget.isValid(i, value),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(widget.getRegExp(i)),
                                ),
                                FilteringTextInputFormatter.singleLineFormatter,
                              ],
                              keyboardType: widget.getKeyboardType(i),
                              autovalidateMode: AutovalidateMode.always,
                              maxLength: widget.getMaxLength(i),
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
  final formKey = GlobalKey<FormState>();
}
