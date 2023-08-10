import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/assign/bloc/assign_bed_bloc.dart';
import 'package:sbas/features/assign/presenters/assign_bed_presenter.dart';
import 'package:sbas/features/assign/views/assign_bed_screen.dart';
import 'package:sbas/features/assign/views/widgets/request/assign_severely_diseaseV2.dart';
import 'package:sbas/features/assign/views/widgets/request/assign_request_departure_info_input.dart';
import 'package:sbas/features/assign/views/widgets/request/assign_infectious_diseaseV2.dart';
import 'package:sbas/features/lookup/blocs/hospital_bed_request_bloc.dart';
import 'package:sbas/features/lookup/blocs/infectious_disease_bloc.dart';
import 'package:sbas/features/lookup/blocs/patient_lookup_bloc.dart';
import 'package:sbas/features/lookup/blocs/patient_register_bloc.dart';
import 'package:sbas/features/lookup/blocs/severely_disease_presenter.dart';
import 'package:sbas/features/lookup/models/patient_info_model.dart';

import 'package:sbas/features/lookup/models/patient_model.dart';
import 'package:sbas/features/lookup/models/patient_reg_info_model.dart';
import 'package:sbas/features/lookup/presenters/origin_info_presenter.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';
import 'package:sbas/features/lookup/views/widgets/patient_reg_info_widget.dart';
import 'package:sbas/features/lookup/views/widgets/patient_reg_info_widget_v2.dart';
import 'package:sbas/features/lookup/views/widgets/patient_reg_report_widget.dart';
import 'package:sbas/features/lookup/views/widgets/request_steps/severely_disease_widget.dart';

final selectedTabIndexProvider = StateProvider<int>((ref) => 0);
final patientImageProvider = StateProvider<XFile?>((ref) => null);
final patientAttcProvider = StateProvider<String?>((ref) => null);
final patientIsUploadProvider = StateProvider<bool>((ref) => true);
final assignNewBedProvider = AsyncNotifierProvider<AssignNewBedPresenter, PatientRegInfoModel>(
  () => AssignNewBedPresenter(),
);

class HospitalBedRequestScreenV2 extends ConsumerWidget {
  HospitalBedRequestScreenV2({
    this.patient,
    super.key,
  });

  final formKey = GlobalKey<FormState>();
  Patient? patient;
  List<String> headerList = ["역학조사서", "환자정보", "감염병정보", "중증정보", "출발정보"];
  bool isRight = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    attcId = patient?.attcId ?? '';

    int selectedIndex = ref.watch(selectedTabIndexProvider);
    final patientImage = ref.watch(patientImageProvider);
    final patientAttc = ref.watch(patientAttcProvider);
    final patientIsUpload = ref.watch(patientIsUploadProvider);

    return Scaffold(
      backgroundColor: Palette.white,
      appBar: AppBar(
        title: Text(
          "병상요청",
          style: CTS.medium(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 8.h,
            ),
            margin: EdgeInsets.only(right: 16.w),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/common_icon/close_button_png.png",
                  height: 13.h,
                  width: 13.w,
                ),
              ),
            ),
          )
        ],
        elevation: 0.5,
        centerTitle: true,
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: ref.watch(requestBedProvider).when(
            loading: () => const SBASProgressIndicator(),
            error: (error, stackTrace) => Center(
              child: Text(
                error.toString(),
                style: const TextStyle(
                  color: Palette.mainColor,
                ),
              ),
            ),
            data: (report) => GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                children: [
                  _header(patient!),
                  Divider(
                    color: Palette.greyText_20,
                    height: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 2.w),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 6.h),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: List.generate(
                                        5,
                                        (index) => InkWell(
                                          onTap: () {
                                            ref.read(selectedTabIndexProvider.notifier).update((state) => index);
                                            //TODO :: 이동시 data 저장 로직 필요.
                                          },
                                          child: SizedBox(
                                            width: 0.22.sw,
                                            child: Text(
                                              headerList[index],
                                              style: CTS.medium(
                                                color: Colors.black,
                                                fontSize: 13,
                                              ),
                                            ).c,
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                              Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 16.w),
                                    height: 6.h,
                                    width: 0.22.sw * 5,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffecedef),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    padding: EdgeInsets.only(left: 0.22.sw * selectedIndex + 16.w),
                                    duration: const Duration(
                                      milliseconds: 200,
                                    ),
                                    child: Container(
                                      width: 0.22.sw,
                                      height: 6.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          30,
                                        ),
                                        color: Palette.mainColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (selectedIndex == 0) //역학조사서
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 0.w, right: 0.w, top: 24.h),
                        child: const PatientRegReport(),
                      ),
                    ),
                  if (selectedIndex == 1) //환자정보
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(left: 0.w, right: 0.w, top: 24.h),
                      child: PatientRegInfo(formKey: formKey),
                      // child: PatientRegInfoV2(),
                    )),

                  if (selectedIndex == 2)
                    InfectiousDiseaseV2(
                      formKey: formKey,
                      report: report,
                    ), //감염병정보
                  //상단 2개는 신규일때만 들어갈수있도록 해야함.
                  //하단부 ConsumerStatefulWidget로 변경.
                  if (selectedIndex == 3)
                    SeverelyDiseaseV2(
                      formKey: formKey,
                      ptId: patient!.ptId!,
                    ), //중증정보
                  if (selectedIndex == 4) AssignReqDepatureInfoInputScreen(), //출발정보
                  _bottomer(ref, selectedIndex, patientImage, patientAttc, patientIsUpload, context),
                ],
              ),
            ),
          ),
    );
  }

  Widget _bottomer(WidgetRef ref, int selectedIndex, patientImage, patientAttc, patientIsUpload, context) {
    return Row(
      children: [
        selectedIndex != 0
            ? Expanded(
                child: InkWell(
                  onTap: () {
                    ref.read(selectedTabIndexProvider.notifier).update((state) => state - 1);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 11.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Palette.greyText_80,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      '이전',
                      style: CTS(
                        color: Palette.greyText_80,
                        fontSize: 16,
                      ),
                    ).c,
                  ),
                ),
              )
            : Container(),
        Expanded(
          child: InkWell(
            onTap: () {
              if (selectedIndex == 0) {
                patientImage != null || !patientIsUpload
                    ? patientAttc != null
                        ? true
                            ? () => ref.read(patientRegProvider.notifier).registry(patient?.ptId, context) //환자실등록
                            // ? null
                            : null
                        : (patientImage != null
                            ? () => ref.read(patientRegProvider.notifier).uploadImage(patientImage)
                            : () {
                                if (patient != null) {
                                  ref.read(patientRegProvider.notifier).overrideInfo(patient!);
                                }
                                ref.read(patientAttcProvider.notifier).state = '';
                              })
                    : null;
              }
              if (selectedIndex == 2) {
                ref.read(infectiousDiseaseProvider.notifier).registry(patient?.ptId ?? '');
              }
              if (selectedIndex == 3) {
                ref.read(severelyDiseaseProvider.notifier).saveDiseaseInfo(patient?.ptId ?? '');
              }

              if (selectedIndex == 4) {
                ref.read(originInfoProvider.notifier).registry(patient?.ptId ?? '');

                Navigator.pop(context);

                context.goNamed(AssignBedScreen.routeName);

                return;
              } else {
                ref.read(selectedTabIndexProvider.notifier).update((state) => state + 1);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: const BoxDecoration(
                color: Palette.mainColor,
              ),
              child: Text(
                selectedIndex == 4 ? '요청 완료' : '다음',
                style: CTS(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ).c,
            ),
          ),
        ),
      ],
    );
  }

  Widget _header(Patient patient) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 14.h,
        horizontal: 16.w,
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
                      text: getPatientInfo(patient), //TODO :: MaxLines 관리및 디자인 협의필요 04.28하진우.
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
          )
        ],
      ),
    );
  }

  PatientRegInfoModel tempPaitent = PatientRegInfoModel(
    rgstUserId: "cyberprophet",
    rgstDttm: "2023-04-11T06:12:03.709296Z",
    updtUserId: "cyberprophet",
    updtDttm: "2023-04-11T08:31:22.296640Z",
    ptId: "PT00000055",
    ptNm: "달나라",
    gndr: "F",
    rrno1: "310301",
    rrno2: "2",
    dstr1Cd: "50",
    dstr2Cd: "5013",
    addr: "제주특별자치도 서귀포시 아우성",
    telno: "04580808080",
    natiCd: "KR",
    picaVer: "",
    dethYn: "N",
    nokNm: "나라고",
    mpno: "01021210909",
    job: "머라고",
    attcId: null,
    bedStatCd: "BAST0001",
    bedStatNm: "병상요청",
  );
}
