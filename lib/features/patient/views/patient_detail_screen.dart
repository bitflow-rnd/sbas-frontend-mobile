import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/app_bar_widget.dart';
import 'package:sbas/common/widgets/bottom_sub_position_btn_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/lookup/blocs/patient_asgn_history_bloc.dart';
import 'package:sbas/features/lookup/blocs/patient_info_presenter.dart';
import 'package:sbas/features/lookup/blocs/patient_lookup_bloc.dart';
import 'package:sbas/features/lookup/blocs/patient_lookup_detail_bloc.dart';
import 'package:sbas/features/lookup/blocs/patient_register_bloc.dart';
import 'package:sbas/features/patient/models/patient_model.dart';
import 'package:sbas/features/lookup/views/hospital_bed_request_screen_v2.dart';
import 'package:sbas/features/lookup/views/patient_modify_screen.dart';
import 'package:sbas/features/lookup/views/widgets/bed_assign_history_card.dart';
import 'package:sbas/features/lookup/views/widgets/patient_reg_top_nav_widget.dart';
import 'package:sbas/features/lookup/views/widgets/patient_top_info_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/common.dart';
import 'package:sbas/features/assign/bloc/assign_bed_bloc.dart';
import 'package:sbas/features/lookup/models/patient_history_model.dart';
import 'package:sbas/features/patient/providers/paitent_provider.dart';

class PatientDetailScreen extends ConsumerWidget {
  final Patient patient;
  PatientDetailScreen({
    super.key,
    required this.patient,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(patientProgressProvider);
    final patientDetail = ref.watch(patientProvider(patient.ptId));

    return Scaffold(
        backgroundColor: Palette.white,
        appBar: SBASAppBar(
          title: '환자 상세 정보',
          actions: [
            progress == 0
                ? Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                    ),
                    margin: EdgeInsets.only(right: 16.w),
                    child: InkWell(
                      // onTap: () {},
                      child: Image.asset(
                        "assets/common_icon/share_icon.png",
                        color: Palette.greyText_30,
                        height: 24.h,
                        width: 24.w,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
        body: patientDetail.when(
              loading: () => const SBASProgressIndicator(),
              error: (error, stackTrace) => Center(
                child: Text(
                  error.toString(),
                  style: const TextStyle(
                    color: Palette.mainColor,
                  ),
                ),
              ),
              data: (patient) => Stack(
                children: [
                  Column(
                    children: [
                      PatientTopInfo(patient: patient),
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
                            onTap: () {
                              progress == 0
                                  ? ref
                                      .read(patientProgressProvider.notifier)
                                      .state++
                                  : ref
                                      .read(patientProgressProvider.notifier)
                                      .state--;
                              ref
                                  .watch(patientAsgnHistoryProvider.notifier)
                                  .refresh(patient.ptId);
                            },
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
                                                Text(
                                                  list[i],
                                                  style: CTS(
                                                    color: Palette.greyText,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    getConvertPatientInfo(
                                                        i, patient),
                                                    style: CTS.medium(
                                                      fontSize: 13,
                                                    ),
                                                    textAlign: TextAlign.end,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '성별',
                                                        style: CTS(
                                                          color:
                                                              Palette.greyText,
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                      Gaps.h10,
                                                      Text(
                                                        patient.gndr ?? '',
                                                        style: CTS.medium(
                                                          fontSize: 13,
                                                        ),
                                                        textAlign:
                                                            TextAlign.end,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                  Gaps.h32,
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '나이',
                                                        style: CTS(
                                                          color:
                                                              Palette.greyText,
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                      Gaps.h10,
                                                      Text(
                                                        '${patient.age}세',
                                                        style: CTS.medium(
                                                          fontSize: 13,
                                                        ),
                                                        textAlign:
                                                            TextAlign.end,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                              : ref.watch(patientAsgnHistoryProvider).when(
                                    loading: () =>
                                        const SBASProgressIndicator(),
                                    error: (error, stackTrace) => Center(
                                      child: Text(
                                        error.toString(),
                                        style: const TextStyle(
                                          color: Palette.mainColor,
                                        ),
                                      ),
                                    ),
                                    data: (history) =>
                                        buildHistoryList(history, patient),
                                  ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Row(
                      children: [
                        Expanded(
                          child: BottomPositionedSubmitButton(
                            text: '수정',
                            function: () async {
                              ref
                                  .watch(patientRegProvider.notifier)
                                  .patientInit(patient);
                              ref.watch(patientAttcProvider.notifier).state =
                                  patient.attcId;
                              ref.watch(patientIdProvider.notifier).state =
                                  patient.ptId;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PatientModifyScreen(
                                    patient: patient,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Gaps.h1,
                        Expanded(
                          child: BottomPositionedSubmitButton(
                            text: '병상 요청',
                            function: () {
                              ref
                                  .watch(patientAsgnHistoryProvider.notifier)
                                  .refresh(patient.ptId)
                                  .then((value) {
                                if (value == true) {
                                  if (ref
                                      .watch(
                                          patientAsgnHistoryProvider.notifier)
                                      .checkBedAssignCompletion()) {
                                    Common.showModal(
                                      context,
                                      Common.commonModal(
                                        context: context,
                                        mainText: "병상배정이 진행중입니다.",
                                        imageWidget: Image.asset(
                                          "assets/auth_group/modal_check.png",
                                          width: 44.h,
                                        ),
                                        imageHeight: 44.h,
                                      ),
                                    );
                                    return;
                                  }
                                  ref.read(patientRegProvider.notifier).init();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            HospitalBedRequestScreenV2(
                                          // builder: (context) => HospitalBedRequestScreen(
                                          isPatientRegister: true,
                                          patient: patient,
                                        ),
                                      ));
                                }
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ));
  }

  Widget buildHistoryList(PatientHistoryList history, Patient patient) {
    if (history.count != 0) {
      return SingleChildScrollView(
        child: Column(
          children: [
            for (PatientHistoryModel i in history.items)
              BedAssignHistoryCardItem(
                item: i,
                patient: patient,
              ),
          ],
        ),
      );
    } else {
      return Column(
        children: [
          SizedBox(height: 100.h),
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
      );
    }
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
}
