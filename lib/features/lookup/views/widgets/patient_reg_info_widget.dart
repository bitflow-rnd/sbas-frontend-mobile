import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/lookup/models/epidemiological_report_model.dart';

class PatientRegInfo extends ConsumerWidget {
  const PatientRegInfo({
    super.key,
    required this.model,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = [
      '환자이름',
      '주민등록번호',
      '주소',
      '사망여부',
      '국적',
      '휴대전화번호',
      '전화번호',
      '보호자',
      '직업',
    ];
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (String e in list)
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '${list.indexOf(e) + 1}.$e',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          list.indexOf(e) > 5 ? '' : '*',
                          style: const TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    Gaps.v4,
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        hintText:
                            '$e${list.indexOf(e) == 0 || list.indexOf(e) == 9 ? '을' : '를'} 입력해주세요.',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade400,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 22,
                        ),
                      ),
                    ),
                    Gaps.v12,
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  final EpidemiologicalReportModel model;
}
