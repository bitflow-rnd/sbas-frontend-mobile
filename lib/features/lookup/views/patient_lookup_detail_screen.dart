import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/bottom_sub_position_btn_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/lookup/blocs/patient_lookup_bloc.dart';
import 'package:sbas/features/lookup/blocs/patient_lookup_detail_bloc.dart';
import 'package:sbas/features/lookup/models/patient_info_model.dart';
import 'package:sbas/features/lookup/views/hospital_bed_request_screen.dart';
import 'package:sbas/features/lookup/views/patient_register_screen.dart';
import 'package:sbas/features/lookup/views/widgets/patient_reg_top_nav_widget.dart';
import 'package:sbas/constants/palette.dart';

class PatientLookupDetailScreen extends ConsumerWidget {
  PatientLookupDetailScreen({
    required this.patient,
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(patientProgressProvider);

    return Scaffold(
      appBar: Bitflow.getAppBar('환자  등록', true, 0),
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
                            color: Palette.mainColor,
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                child: PatientRegTopNav(
                  x: progress == 0 ? 1 : -1,
                  items: const [
                    '환자정보',
                    '병상배정이력',
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: progress == 0
                      ? Column(
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
                        )
                      : ref.watch(patientDetailProvider).when(
                            loading: () => const SBASProgressIndicator(),
                            error: (error, stackTrace) => Center(
                              child: Text(
                                error.toString(),
                                style: const TextStyle(
                                  color: Palette.mainColor,
                                ),
                              ),
                            ),
                            data: (history) => Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/lookup/history_icon.png',
                                    height: 128.h,
                                  ),
                                  const AutoSizeText(
                                    '병상 배정 이력이 없습니다.',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                    maxLines: 1,
                                    maxFontSize: 22,
                                  ),
                                ],
                              ),
                            ),
                          ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 18,
            left: 18,
            right: 18,
            child: BottomPositionedSubmitButton(
              text: progress == 0 ? '다음' : '신규 병상 요청',
              function: () => progress == 0
                  ? ref.read(patientProgressProvider.notifier).state++
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HospitalBedRequestScreen(
                          patient: patient,
                        ),
                      ),
                    ),
            ),
          ),
          if (progress == 0)
            Positioned(
              bottom: 46 + 18 + 10,
              left: 18,
              right: 18,
              child: BottomPositionedSubmitButton(
                color: Colors.green,
                text: '수정',
                function: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PatientRegScreen(
                        patient: patient,
                      ),
                    ),
                  );
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
              ),
            ),
        ],
      ),
    );
  }

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
