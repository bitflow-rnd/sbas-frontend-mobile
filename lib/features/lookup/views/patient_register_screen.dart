import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/bottom_submit_btn_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/authentication/blocs/agency_region_bloc.dart';
import 'package:sbas/features/lookup/blocs/patient_lookup_bloc.dart';
import 'package:sbas/features/lookup/blocs/patient_register_bloc.dart';
import 'package:sbas/features/lookup/models/patient_info_model.dart';
import 'package:sbas/features/lookup/views/widgets/patient_reg_info_widget.dart';
import 'package:sbas/features/lookup/views/widgets/patient_reg_report_widget.dart';
import 'package:sbas/features/lookup/views/widgets/patient_reg_top_nav_widget.dart';

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
      appBar: Bitflow.getAppBar(
        '환자 등록',
        true,
        0,
      ),
      body: Column(
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
                patient == null
                    ? const Text(
                        '신규 환자 등록',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: '${patient?.ptNm}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: '[${getPatientInfo(patient!)}]',
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
              x: patientAttc != null ? -1 : 1,
              items: const [
                '역학조사서',
                '환자 기본정보',
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
              ),
              child: patientAttc != null
                  ? PatientRegInfo(
                      formKey: formKey,
                    )
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
                                  .registry(
                                      ref
                                          .read(agencyRegionProvider.notifier)
                                          .list,
                                      context)
                              : null
                          : (patientImage != null
                              ? () => ref
                                  .read(patientRegProvider.notifier)
                                  .uploadImage(patientImage)
                              : () => ref
                                  .read(patientAttcProvider.notifier)
                                  .state = '')
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
