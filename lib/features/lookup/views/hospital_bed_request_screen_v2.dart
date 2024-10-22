import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/providers/loading_notifier.dart';
import 'package:sbas/common/widgets/app_bar_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/assign/bloc/assign_bed_bloc.dart';
import 'package:sbas/features/assign/repos/assign_repo.dart';
import 'package:sbas/features/assign/views/assign_bed_screen.dart';
import 'package:sbas/features/assign/views/widgets/request/assign_infectious_diseaseV2.dart';
import 'package:sbas/features/assign/views/widgets/request/assign_origin_infomationV2.dart';
import 'package:sbas/features/assign/views/widgets/request/assign_severely_diseaseV2.dart';
import 'package:sbas/features/assign/views/widgets/request/patient_reg_info_widget_v2.dart';
import 'package:sbas/features/lookup/blocs/hospital_bed_request_bloc.dart';
import 'package:sbas/features/lookup/blocs/infectious_disease_bloc.dart';
import 'package:sbas/features/lookup/blocs/patient_register_bloc.dart';
import 'package:sbas/features/lookup/models/patient_duplicate_check_model.dart';
import 'package:sbas/features/lookup/presenters/origin_info_presenter.dart';
import 'package:sbas/features/lookup/presenters/severely_disease_presenter.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';
import 'package:sbas/features/lookup/views/patient_duplicate_check_modal.dart';
import 'package:sbas/features/lookup/views/widgets/paitent_reg_info_modal.dart';
import 'package:sbas/features/lookup/views/widgets/patient_reg_report_widget.dart';
import 'package:sbas/features/lookup/views/widgets/patient_top_info_widget.dart';
import 'package:sbas/features/patient/models/patient_model.dart';
import 'package:sbas/features/assign/presenters/assign_bed_presenter.dart';

class HospitalBedRequestScreenV2 extends ConsumerWidget {
  HospitalBedRequestScreenV2({
    this.isPatientRegister = false,
    this.patient,
    super.key,
  });

  final bool isPatientRegister;

  //@@ Form key must be final
  static final patientBasicFormKey = GlobalKey<FormState>();
  static final severelyDisFormKey = GlobalKey<FormState>();
  static final infectiousDisFormKey = GlobalKey<FormState>();
  static final originFormKey = GlobalKey<FormState>();
  final Patient? patient;
  final List<String> headerList = ["역학조사서", "환자정보", "감염병정보", "중증정보", "출발정보"];
  final bool isRight = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    attcId = patient?.attcId ?? '';
    final order = ref.watch(orderOfRequestProvider);
    final patientImage = ref.watch(patientImageProvider);
    final patientAttc = ref.watch(patientAttcProvider);
    final patientInfoModel = ref.watch(patientRegProvider.notifier).patientInfoModel;

    // final patientIsUpload = ref.watch(patientIsUploadProvider);
    //빌드 이후 실행
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (patient != null && ref.read(patientInfoIsChangedProvider.notifier).state == false) {
        //환자정보가 변경되지 않았을때 기존 정보 사용 override
        await ref.watch(patientRegProvider.notifier).patientInit(patient!); // 기존 데이터로 override
        ref.read(patientInfoIsChangedProvider.notifier).state = true;
        ref.invalidate(requestBedProvider);
        // 이미 기본 정보 입력, valid 한 케이스 2(감염병정보)으로 이동
        if (tryBasicInfoValidation(ref)) {
          ref.read(orderOfRequestProvider.notifier).update((state) => 2);
        } else {
          //입력은 되었지만 이상함 -> 1(환자정보) 추가하도록
          ref.read(orderOfRequestProvider.notifier).update((state) => 1);
        }
      }
      //patient 가 null 이 아닐 때 patientRegProvider.patientINit 으로 init
    });

    void imageInit() {
      ref.read(infectiousImageProvider.notifier).state = [];
    }

    return Scaffold(
      backgroundColor: Palette.white,
      appBar: SBASAppBar(
        title: '병상 요청',
        onBackPressed: () {
          if(order == 2) {
            return imageInit();
          }
          ref.watch(assignBedProvider.notifier).reloadPatients();
          return;
        },
        actions: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 8.h,
            ),
            margin: EdgeInsets.only(right: 16.w),
            child: InkWell(
              onTap: () {
                if(order == 2) {
                  imageInit();
                }
                ref.watch(assignBedProvider.notifier).reloadPatients();
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
          ),
        ],
        elevation: 0.5,
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
            data: (report) => WillPopScope(
              onWillPop: () async {
                ref.watch(assignBedProvider.notifier).reloadPatients();
                return true;
              },
              child: Column(
                children: [
                  PatientTopInfo(
                    patient: patient,
                  ),
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 10.h),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 6.h),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: List.generate(
                                        5, (index) => GestureDetector(
                                          onTap: () {
                                            ref.read(orderOfRequestProvider.notifier).update((state) => index);
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
                                    padding: EdgeInsets.only(
                                        left: 0.22.sw * order + 16.w),
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
                  if (order == 0) //역학조사서
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 0.w, right: 0.w, top: 16.h),
                        child: const PatientRegReport(),
                      ),
                    ),
                  if (order == 1) //환자정보
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 0.w, right: 0.w, top: 16.h),
                        child: Form(
                          key: patientBasicFormKey,
                          child: PatientRegInfoV2(),
                        ),
                    )),
                  if (order == 2)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 0.w, right: 0.w, top: 16.h),
                        child: Form(
                          key: infectiousDisFormKey,
                          child: InfectiousDiseaseV2(report: report, dstr1Cd: patientInfoModel.dstr1Cd),
                        ),
                    )),
                  //상단 2개는 신규일때만 들어갈수있도록?!
                  if (order == 3)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 0.w, right: 0.w, top: 16.h),
                        child: Form(
                          key: severelyDisFormKey,
                          child: SeverelyDiseaseV2(
                            ptId: patient?.ptId ?? patientInfoModel.ptId ?? '',
                          ),
                        ),
                    )), //중증정보
                  if (order == 4)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 0.w, right: 0.w, top: 16.h),
                        child: Form(
                          key: originFormKey,
                          child: OriginInfomationV2(),
                        ),
                      ), //출발정보
                    ),
                  _bottomer(ref, patientImage, patientAttc, context,
                      hasPatient: patient != null),
                ],
              ),
            ),
          ),
    );
  }

  Widget _bottomer(WidgetRef ref, XFile? patientImage, String? patientAttc,
      BuildContext context,
      {required bool hasPatient}) {
    final order = ref.watch(orderOfRequestProvider);

    return Row(
      children: [
        order != 0
            ? Expanded(
                child: InkWell(
                  onTap: () {
                    ref.read(orderOfRequestProvider.notifier).update((state) => order - 1);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Palette.greyText_20,
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
            onTap: () async {
              if (isPatientRegister) {
                //신규 환자 등록 화면.
                if (order == 0) {
                  if (patientAttc == null && patientImage != null) {
                    //image 가 선택되어있지만 업로드 이전
                    //역학조사서 이미지는 선택되어있지만, 업로드 이전
                    ref.watch(loadingProvider.notifier).show();
                    await ref.read(patientRegProvider.notifier).uploadImage(patientImage).then((value) {
                      if (value == true) {
                        PatientRegInfoModal().epidUploadConfirmModal(context, "역학조사서 파일을 기반으로\n환자정보를 자동입력 하였습니다.\n내용을 확인해주세요.");
                        ref.read(orderOfRequestProvider.notifier).update((state) => state + 1);
                        ref.watch(loadingProvider.notifier).hide();
                      } else {
                        PatientRegInfoModal().epidUploadConfirmModal(context, "역학조사서 인식에 실패했습니다.\n다시 한번 시도해주세요.");
                        ref.watch(loadingProvider.notifier).hide();
                      }
                    });
                  } else if (patientAttc != null && patientImage != null) {
                    // image 가 선택되어있고 업로드 된 경우
                    //역학조사서 이미지가 업로드 되어있는 경우 + 환자등록
                    ref.read(orderOfRequestProvider.notifier).update((state) => order + 1);
                    // ref.read(patientRegProvider.notifier).overrideInfo(patient!);
                  } else {
                    //역학조사서 없는경우
                    ref.read(orderOfRequestProvider.notifier).update((state) => order + 1);
                  }
                } else if (order == 1) {
                  if (tryBasicInfoValidation(ref)) {
                    var patientRegInfoModel =
                        ref.read(patientRegProvider).value;

                    ref.read(patientRegProvider.notifier).exist().then((value) {
                      if (value['isExist']) {
                        var oldPatient =
                            PatientCheckResponse.fromJson(value['items']);
                        patientDuplicateCheckModal(
                            context, oldPatient, patientRegInfoModel!, ref);
                      } else {
                        ref
                            .read(patientRegProvider.notifier)
                            .registry(patient?.ptId, context);
                        ref
                            .read(orderOfRequestProvider.notifier)
                            .update((state) => order + 1);
                      }
                    });
                  }
                } else if (order == 2) {
                  //예외처리 추가 필요.
                  if (tryInfectDisValidation()) {
                    final patientInfoModel =
                        ref.watch(patientRegProvider.notifier).patientInfoModel;

                    bool infectRes = await ref
                        .read(infectiousDiseaseProvider.notifier)
                        .registry(patientInfoModel.ptId ?? '');
                    if (infectRes) {
                      ref
                          .read(orderOfRequestProvider.notifier)
                          .update((state) => order + 1);
                    }
                  }
                } else if (order == 3) {
                  if (trySeverelyDisValidation(ref)) {
                    final patientInfoModel =
                        ref.watch(patientRegProvider.notifier).patientInfoModel;

                    bool severeRes = await ref
                        .read(severelyDiseaseProvider.notifier)
                        .saveDiseaseInfo(patientInfoModel.ptId ?? '');
                    if (severeRes) {
                      ref
                          .read(orderOfRequestProvider.notifier)
                          .update((state) => order + 1);
                    }
                  }
                } else if (order == 4) {
                  if (tryOrignInfoValidation(ref)) {
                    final patientInfoModel =
                        ref.watch(patientRegProvider.notifier).patientInfoModel;
                    bool orignRes = await ref
                        .read(originInfoProvider.notifier)
                        .orignSeverelyDiseaseRegistry(
                            patientInfoModel.ptId ?? '');
                    if (orignRes) {
                      await Future.delayed(Duration(milliseconds: 1500));

                      await ref.read(patientRepoProvider).lookupPatientInfo();
                      // ignore: use_build_context_synchronously
                      Navigator.popUntil(context, (route) => route.isFirst);
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AssignBedScreen(
                              automaticallyImplyLeading: false,
                            ),
                          ));
                    } else {}
                  }
                }
              } else {
                // 병상요청 화면
                if (order == 0) {
                  if (patientAttc == null && patientImage != null) {
                    //역학조사서 이미지는 선택되어있지만, 업로드 이전
                    var uploadRes = await ref
                        .read(patientRegProvider.notifier)
                        .uploadImage(patientImage);
                    if (uploadRes) {
                      ref.read(orderOfRequestProvider.notifier)
                          .update((state) => state + 1);
                    }
                  } else if (patientAttc != null && patientImage != null) {
                    //역학조사서 이미지가 업로드 되어있는 경우 + 환자등록
                    ref
                        .read(orderOfRequestProvider.notifier)
                        .update((state) => state + 1);
                    // ref.read(patientRegProvider.notifier).overrideInfo(patient!);
                  } else if (patientAttc != null && patientImage != null) {
                    //역학조사서 이미지가 업로드 되어있는 경우 + 병상요청

                    ref
                        .read(patientRegProvider.notifier)
                        .overrideInfo(patient!);
                  }
                } else if (order == 1) {
                  if (tryBasicInfoValidation(ref)) {
                    var patientRegInfoModel = ref.read(patientRegProvider).value;
                    ref.read(patientRegProvider.notifier).exist().then((value) {
                      if (value['isExist']) {
                        var oldPatient = PatientCheckResponse.fromJson(value['items']);
                        patientDuplicateCheckModal(context, oldPatient, patientRegInfoModel!, ref);
                      } else {
                        ref.read(patientRegProvider.notifier).registry(patient?.ptId, context);
                        ref.read(orderOfRequestProvider.notifier).update((state) => order + 1);
                      }
                    });
                  }
                } else if (order == 2) {
                  //예외처리 추가 필요.
                  if (tryInfectDisValidation()) {
                    final a =
                        ref.watch(patientRegProvider.notifier).patientInfoModel;

                    bool infectRes = await ref
                        .read(infectiousDiseaseProvider.notifier)
                        .registry(patient?.ptId ?? a.ptId ?? '');
                    if (infectRes) {
                      ref
                          .read(orderOfRequestProvider.notifier)
                          .update((state) => order + 1);
                    }
                  }
                } else if (order == 3) {
                  if (trySeverelyDisValidation(ref)) {
                    final a =
                        ref.watch(patientRegProvider.notifier).patientInfoModel;
                    bool severeRes = await ref
                        .read(severelyDiseaseProvider.notifier)
                        .saveDiseaseInfo(patient?.ptId ?? a.ptId ?? '');
                    if (severeRes) {
                      ref
                          .read(orderOfRequestProvider.notifier)
                          .update((state) => order + 1);
                    }
                  }
                } else if (order == 4) {
                  if (tryOrignInfoValidation(ref)) {
                    final a =
                        ref.watch(patientRegProvider.notifier).patientInfoModel;
                    bool orignRes = await ref
                        .read(originInfoProvider.notifier)
                        .orignSeverelyDiseaseRegistry(
                            patient?.ptId ?? a.ptId ?? '');
                    if (orignRes) {
                      await Future.delayed(const Duration(milliseconds: 1500));
                      await ref.read(patientRepoProvider).lookupPatientInfo();
                      // ignore: use_build_context_synchronously
                      Navigator.popUntil(context, (route) => route.isFirst);

                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AssignBedScreen(
                              automaticallyImplyLeading: false,
                            ),
                          ));
                    }
                  }
                }
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: Palette.mainColor,
                border: Border.all(
                  color: Palette.mainColor,
                  width: 1,
                ),
              ),
              child: Text(
                order == 4 ? '요청 완료' : '다음',
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

  bool tryBasicInfoValidation(WidgetRef ref) {
    print('patientBasicForm');
    bool isValid = patientBasicFormKey.currentState?.validate() ?? false;

    if (isValid) {
      patientBasicFormKey.currentState?.save();
    }
    return isValid;
  }

  bool tryInfectDisValidation() {
    print('infectiousDisForm');
    bool isValid = infectiousDisFormKey.currentState?.validate() ?? false;

    if (isValid) {
      infectiousDisFormKey.currentState?.save();
    }
    return isValid;
  }

  bool trySeverelyDisValidation(WidgetRef ref) {
    print('severelyDisForm');
    print(severelyDisFormKey.currentState?.validate());
    bool isValid = severelyDisFormKey.currentState?.validate() ?? false;

    // isValid = ref.watch(severelyDiseaseProvider.notifier).isValid();

    if (isValid) {
      severelyDisFormKey.currentState?.save();
    }
    return isValid;
  }

  bool tryOrignInfoValidation(WidgetRef ref) {
    print('originForm');
    bool isValid = originFormKey.currentState?.validate() ?? false;
    // isValid = ref.watch(severelyDiseaseProvider.notifier).isValid();
    // isValid = ref.watch(originInfoProvider.notifier).isValid();
    if (isValid) {
      originFormKey.currentState?.save();
    }
    return isValid;
  }
}
