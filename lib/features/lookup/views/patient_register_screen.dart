import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/bottom_submit_btn_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/assign/bloc/assign_bed_bloc.dart';
import 'package:sbas/features/lookup/blocs/patient_register_bloc.dart';
import 'package:sbas/features/lookup/models/patient_duplicate_check_model.dart';
import 'package:sbas/features/patient/models/patient_model.dart';
import 'package:sbas/features/assign/views/widgets/request/patient_reg_info_widget_v2.dart';
import 'package:sbas/features/lookup/views/widgets/paitent_info_modal.dart';
import 'package:sbas/features/lookup/views/widgets/paitent_reg_info_modal.dart';
import 'package:sbas/features/lookup/views/widgets/patient_reg_report_widget.dart';
import 'package:sbas/features/lookup/views/widgets/patient_reg_top_nav_widget.dart';
import 'package:sbas/features/lookup/views/widgets/patient_top_info_widget.dart';


class PatientRegScreen extends ConsumerStatefulWidget {
  const PatientRegScreen({
    this.patient,
    super.key,
  });

  final Patient? patient;

  @override
  ConsumerState<PatientRegScreen> createState() => PatientRegScreenState();
}

class PatientRegScreenState extends ConsumerState<PatientRegScreen> {
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final patientImage = ref.watch(patientImageProvider);
    final patientAttc = ref.watch(patientAttcProvider);
    // final patientIsUpload = ref.watch(patientIsUploadProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Palette.white,
      appBar: Bitflow.getAppBar(
        '환자 등록',
        false,
        0.5,
      ),
      body: Column(
        children: [
          PatientTopInfo(
            patient: widget.patient,
          ),
          Container(
            color: Palette.dividerGrey,
            height: 1.h,
            width: 1.sw,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 14.h,
            ),
            child: PatientRegTopNav(
              x: patientAttc != null ? -1 : 1,
              items: const [
                '역학조사서',
                '환자 기본정보',
              ],
            ),
          ),
          Expanded(
            child: Form(
              key: formKey,
              child: patientAttc != null
                  ? PatientRegInfoV2()
                  : _isLoading
                  ? const SBASProgressIndicator()
                  : const PatientRegReport(),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: width * 0.5,
                child: BottomSubmitBtn(
                  mainColor: Palette.white,
                  text: patientAttc != null ? '이전' : '취소',
                  onPressed: patientAttc != null
                      ? () {
                    ref.read(patientIsUploadProvider.notifier).state = true;
                    ref.read(patientAttcProvider.notifier).state = null;
                  }
                      : () => Navigator.pop(context),
                ),
              ),
              SizedBox(
                width: width * 0.5,
                child: BottomSubmitBtn(
                  text: '다음',
                  onPressed: () {
                    setState(() {
                      _isLoading = true; // 로딩 상태 시작
                    });

                    if (patientAttc != null) {
                      if (_tryValidation()) {
                        var patientRegInfoModel = ref.read(patientRegProvider).value;

                        ref.read(patientRegProvider.notifier).exist().then((value) {
                            setState(() {
                              _isLoading = false; // 로딩 상태 종료
                            });

                            if (value['isExist']) {
                              var oldPatient = PatientCheckResponse.fromJson(value['items']);
                              PatientInfoModal().patientDuplicateCheckModal(context, oldPatient, patientRegInfoModel!, ref);
                            } else {
                              ref.read(patientRegProvider.notifier).registry(widget.patient?.ptId, context);
                              Navigator.pop(context);
                            }
                          },
                          onError: (error) {
                            setState(() {
                              _isLoading = false; // 에러 발생 시 로딩 종료
                            });
                          },
                        );
                      } else {
                        setState(() {
                          _isLoading = false; // 유효성 검사 실패 시 로딩 종료
                        });
                      }
                    } else {
                      if (patientImage != null) {
                        ref.read(patientRegProvider.notifier).uploadImage(patientImage).then(
                              (value) {
                            setState(() {
                              _isLoading = false; // 이미지 업로드 후 로딩 종료
                            });

                            if (value == true) {
                              PatientRegInfoModal().epidUploadConfirmModal(context);
                            }
                          },
                          onError: (error) {
                            setState(() {
                              _isLoading = false; // 에러 발생 시 로딩 종료
                            });
                          },
                        );
                      } else {
                        setState(() {
                          _isLoading = false; // 이미지가 없을 경우 로딩 종료
                        });
                        ref.read(patientAttcProvider.notifier).state = '';
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _tryValidation() {
    bool isValid = formKey.currentState?.validate() ?? false;
    if (isValid) {
      formKey.currentState?.save();
    }
    return isValid;
  }
}
