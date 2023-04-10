import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/bottom_sub_position_btn_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/lookup/blocs/patient_lookup_bloc.dart';
import 'package:sbas/features/lookup/models/patient_info_model.dart';
import 'package:sbas/features/lookup/views/widgets/patient_reg_top_nav_widget.dart';

class PatientLookupDetailScreen extends ConsumerWidget {
  PatientLookupDetailScreen({
    required this.patient,
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: Bitflow.getAppBar('환자등록', true, 0),
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/patient.png',
                        height: 42,
                      ),
                      Gaps.h8,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: '${patient.ptNm}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: '[${getPatientInfo(patient)}]',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gaps.v4,
                          const Text(
                            '#temp',
                            style: TextStyle(
                              color: Colors.lightBlue,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.share_outlined,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: PatientRegTopNav(
                    x: 1,
                    items: [
                      '환자정보',
                      '병상배정이력',
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int i = 0; i < list.length; i++)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 14,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${i + 1}.${list[i]}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                getConvertPatientInfo(i, patient),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 18,
              left: 18,
              right: 18,
              child: BottomPositionedSubmitButton(
                text: '수정',
                function: () {},
              ),
            ),
          ],
        ),
      );
  final List<String> list = [
    '환자이름',
    '주민등록번호',
    '주소',
    '사망여부',
    '국적',
    '휴대전화번호',
    '전화번호',
    '보호자이름',
    '직업',
    '기저질환',
  ];
  final Patient patient;
}
