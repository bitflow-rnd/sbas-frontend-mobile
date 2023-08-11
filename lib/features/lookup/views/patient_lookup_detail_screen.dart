import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/bottom_sub_position_btn_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/lookup/views/hospital_bed_request_screen.dart';
import 'package:sbas/features/lookup/views/hospital_bed_request_screen_v2.dart';
import 'package:sbas/features/lookup/blocs/patient_lookup_bloc.dart';
import 'package:sbas/features/lookup/blocs/patient_lookup_detail_bloc.dart';
import 'package:sbas/features/lookup/models/patient_model.dart';
import 'package:sbas/features/lookup/views/patient_register_screen.dart';
import 'package:sbas/features/lookup/views/widgets/patient_reg_top_nav_widget.dart';
import 'package:sbas/constants/palette.dart';

class PatientLookupDetailScreen extends ConsumerWidget {
  PatientLookupDetailScreen({
    required this.patient,
    required this.age,
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(patientProgressProvider);

    return Scaffold(
      backgroundColor: Palette.white,
      appBar: AppBar(
        title: Text(
          "환자 상세 정보",
          style: CTS.medium(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        actions: [
          progress == 0
              ? Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.h,
                  ),
                  margin: EdgeInsets.only(right: 16.w),
                  child: InkWell(
                    onTap: () {},
                    child: Image.asset(
                      "assets/common_icon/share_icon.png",
                      height: 24.h,
                      width: 24.w,
                    ),
                  ),
                )
              : Container()
        ],
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.h,
                  vertical: 14.w,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/patient.png',
                      height: 36.h,
                      width: 36.h,
                    ),
                    Gaps.h8,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: '${patient.ptNm}',
                            style: CTS.bold(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: '',
                                style: CTS(
                                  color: const Color(0xff333333),
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gaps.v4,
                        const Text(
                          '#중증#투석', //TODO 임시로 하드코딩 - 수정 필요
                          style: TextStyle(
                            color: Palette.mainColor,
                          ),
                        ),
                      ],
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
                  child: GestureDetector(
                    onTap: () => progress == 0 ? ref.read(patientProgressProvider.notifier).state++ : ref.read(patientProgressProvider.notifier).state--,
                    child: PatientRegTopNav(
                      x: progress == 0 ? 1 : -1,
                      items: const [
                        '환자정보',
                        '병상배정이력',
                      ],
                    ),
                  )),
              Expanded(
                child: SingleChildScrollView(
                  child: progress == 0
                      ? Column(
                          children: [
                            for (int i = 0; i < list.length; i++)
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                      vertical: 12.h,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            list[i],
                                            style: CTS(
                                              color: Palette.greyText,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            getConvertPatientInfo(i, patient),
                                            style: CTS.medium(
                                              fontSize: 13,
                                            ),
                                            textAlign: TextAlign.end,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  if (i == 1)
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 24.w,
                                        vertical: 12.h,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                '성별',
                                                style: CTS(
                                                  color: Palette.greyText,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              Gaps.h10,
                                              Text(
                                                patient.gndr ?? '',
                                                style: CTS.medium(
                                                  fontSize: 13,
                                                ),
                                                textAlign: TextAlign.end,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                          Gaps.h32,
                                          Row(
                                            children: [
                                              Text(
                                                '나이',
                                                style: CTS(
                                                  color: Palette.greyText,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              Gaps.h10,
                                              Text(
                                                '$age세',
                                                style: CTS.medium(
                                                  fontSize: 13,
                                                ),
                                                textAlign: TextAlign.end,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
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
                            data:
                                (history) => /* SingleChildScrollView(
                                    child: Column(
                                      children: const [
                                        /*
                                        BedAssignHistoryCardItem(
                                          name: "칠곡경북대병원",
                                          disease: "코로나바이러스감염증-19",
                                          timestamp: '2023년 2월 18일 15시 22분',
                                          count: "1",
                                          tagList: const [
                                            "중증",
                                            "중증",
                                            "중증",
                                            "중증",
                                          ],
                                          patient: patient,
                                        ),
                                        BedAssignHistoryCardItem(
                                          name: "칠곡경북대병원",
                                          disease: "코로나바이러스감염증-19",
                                          timestamp: '2023년 2월 18일 15시 22분',
                                          count: "2",
                                          tagList: const [
                                            "중증",
                                            "중증",
                                            "중증",
                                            "중증",
                                          ],
                                          patient: patient,
                                        ),
                                        BedAssignHistoryCardItem(
                                          name: "칠곡경북대병원",
                                          disease: "코로나바이러스감염증-19",
                                          timestamp: '2023년 2월 18일 15시 22분',
                                          count: "3",
                                          tagList: const [
                                            "중증",
                                            "중증",
                                            "중증",
                                            "중증",
                                          ],
                                          patient: patient,
                                        ),
                                        */
                                      ],
                                    ),
                                  )
                                :
                                */
                                    Center(
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
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: BottomPositionedSubmitButton(
          //     text: progress == 0 ? '다음' : '신규 병상 요청',
          //     function: () => progress == 0
          //         ? ref.read(patientProgressProvider.notifier).state++
          //         : Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => HospitalBedRequestScreen(
          //                 patient: patient,
          //               ),
          //             ),
          //           ),
          //   ),
          // ),
          if (progress == 0) // 환자정보 - 수정
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomPositionedSubmitButton(
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
            )
          else // 병상배정이력 - 병상요청
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomPositionedSubmitButton(
                text: '병상 요청',
                function: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HospitalBedRequestScreenV2(
                      // builder: (context) => HospitalBedRequestScreen(
                      patient: patient,
                    ),
                  ),
                ),
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
  final int age;
}
