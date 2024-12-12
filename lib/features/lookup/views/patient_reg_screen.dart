import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/widgets/app_bar_widget.dart';
import 'package:sbas/common/widgets/bottom_submit_btn_widget.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/patient/providers/patient_provider.dart';
import 'package:sbas/features/lookup/views/widgets/patient_reg_info_widget_v2.dart';
import 'package:sbas/features/lookup/presenters/patient_register_provider.dart';
import 'package:sbas/features/lookup/models/patient_duplicate_check_model.dart';
import 'package:sbas/features/lookup/views/widgets/paitent_reg_info_modal.dart';
import 'package:sbas/features/lookup/views/widgets/patient_reg_report_widget.dart';
import 'package:sbas/features/lookup/views/widgets/patient_reg_top_nav_widget.dart';
import 'package:sbas/features/lookup/views/widgets/patient_top_info_widget.dart';
import 'package:sbas/features/patient/models/patient_model.dart';

import '../../../common/providers/loading_provider.dart';
import 'patient_duplicate_check_modal.dart';

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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final patientImage = ref.watch(patientImageProvider);
    final patientAttc = ref.watch(patientAttcProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Palette.white,
      appBar: const SBASAppBar(
        title: '환자 등록',
        elevation: 0.5,
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
              child: patientAttc != null ? PatientRegInfoV2() : const PatientRegReport(),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: width * 0.5,
                child: BottomSubmitBtn(
                  mainColor: Palette.white,
                  text: patientAttc != null ? '이전' : '취소',
                  onPressed: patientAttc != null ?
                    () {
                      ref.read(patientIsUploadProvider.notifier).state = true;
                      ref.read(patientAttcProvider.notifier).state = null;
                    } : () => Navigator.pop(context),
                ),
              ),
              SizedBox(
                width: width * 0.5,
                child: BottomSubmitBtn(
                  text: '다음',
                  onPressed: () {
                    ref.watch(loadingProvider.notifier).show();
                    if (patientAttc != null) {
                      if (_tryValidation()) {
                        var patientRegInfoModel = ref.read(patientRegProvider).value;

                        ref.read(patientRegProvider.notifier).exist().then((value) {
                          ref.watch(loadingProvider.notifier).hide();
                          if (value['isExist']) {
                            var oldPatient = PatientCheckResponse.fromJson(value['items']);
                            patientDuplicateCheckModal(context, oldPatient, patientRegInfoModel!, ref);
                          } else {
                            ref.read(patientRegProvider.notifier).registry(widget.patient?.ptId);
                            Navigator.pop(context);
                          }
                        });
                      }
                    } else {
                      if (patientImage != null) {
                        ref.read(patientRegProvider.notifier).uploadImage(patientImage).then((value) {
                          ref.watch(loadingProvider.notifier).hide();
                          if (value == true) {
                            PatientRegInfoModal().epidUploadConfirmModal(context, "역학조사서 파일을 기반으로\n환자정보를 자동입력 하였습니다.\n내용을 확인해주세요.");
                          } else {
                            PatientRegInfoModal().epidUploadConfirmModal(context, "역학조사서 인식에 실패했습니다.\n다시 한번 시도해주세요.");
                          }
                        });
                      } else {
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
