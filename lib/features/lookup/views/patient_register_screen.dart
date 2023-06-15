import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/bottom_submit_btn_widget.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/lookup/blocs/patient_register_bloc.dart';
import 'package:sbas/features/lookup/models/patient_model.dart';
import 'package:sbas/features/lookup/views/widgets/patient_reg_info_widget_v2.dart';
import 'package:sbas/features/lookup/views/widgets/patient_reg_report_widget.dart';
import 'package:sbas/features/lookup/views/widgets/patient_reg_top_nav_widget.dart';
import 'package:sbas/features/lookup/views/widgets/patient_top_info_widget.dart';

class PatientRegScreen extends ConsumerWidget {
  PatientRegScreen({
    this.patient,
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final patientImage = ref.watch(patientImageProvider);
    final patientAttc = ref.watch(patientAttcProvider);
    final patientIsUpload = ref.watch(patientIsUploadProvider);

    return Scaffold(
      backgroundColor: Palette.white,
      appBar: Bitflow.getAppBar(
        '환자 등록',
        false,
        0.5,
      ),
      body: Column(
        children: [
          PatientTopInfo(
            patient: patient,
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
                  : const PatientRegReport(),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: width * 0.5,
                child: BottomSubmitBtn(
                  text: patientAttc != null ? '이전' : '취소',
                  onPressed: patientAttc != null
                      ? () {
                          ref.read(patientIsUploadProvider.notifier).state =
                              true;
                          ref.read(patientAttcProvider.notifier).state = null;
                        }
                      : () => Navigator.pop(context),
                ),
              ),
              SizedBox(
                width: width * 0.5,
                child: BottomSubmitBtn(
                  text: '다음',
                  onPressed: patientImage != null || !patientIsUpload
                      ? patientAttc != null
                          ? _tryValidation()
                              ? () => ref
                                  .read(patientRegProvider.notifier)
                                  .registry(patient?.ptId, context)
                              : null
                          : (patientImage != null
                              ? () => ref
                                  .read(patientRegProvider.notifier)
                                  .uploadImage(patientImage)
                              : () {
                                  if (patient != null) {
                                    ref
                                        .read(patientRegProvider.notifier)
                                        .overrideInfo(patient!);
                                  }
                                  ref.read(patientAttcProvider.notifier).state =
                                      '';
                                })
                      : null,
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

  final formKey = GlobalKey<FormState>();
  final Patient? patient;
}
