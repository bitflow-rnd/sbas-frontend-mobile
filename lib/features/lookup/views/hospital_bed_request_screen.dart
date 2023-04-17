import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/bottom_submit_btn_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/lookup/blocs/hospital_bed_request_bloc.dart';
import 'package:sbas/features/lookup/models/patient_info_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';
import 'package:sbas/features/lookup/views/widgets/hospital_bed_request_nav_widget.dart';
import 'package:sbas/features/lookup/views/widgets/infectious_disease_widget.dart';
import 'package:sbas/features/lookup/views/widgets/patient_top_info_widget.dart';

class HospitalBedRequestScreen extends ConsumerWidget {
  HospitalBedRequestScreen({
    this.patient,
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    attcId = patient?.attcId ?? '';

    final width = MediaQuery.of(context).size.width;
    final order = ref.watch(orderOfRequestProvider);

    return Scaffold(
      appBar: Bitflow.getAppBar(
        '병상 요청',
        true,
        0,
      ),
      body: ref.watch(requestBedProvider).when(
            loading: () => const SBASProgressIndicator(),
            error: (error, stackTrace) => Center(
              child: Text(
                error.toString(),
                style: const TextStyle(
                  color: Colors.lightBlueAccent,
                ),
              ),
            ),
            data: (report) => Column(
              children: [
                PatientTopInfo(
                  patient: patient,
                ),
                const Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                Gaps.v12,
                HospitalBedRequestNav(),
                if (order == -1)
                  Expanded(
                    child: SizedBox(
                      width: width,
                      child: InfectiousDisease(
                        formKey: formKey,
                      ),
                    ),
                  ),
                if (order == 0)
                  SizedBox(
                    width: width,
                  ),
                if (order == 1)
                  SizedBox(
                    width: width,
                  ),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.5,
                      child: BottomSubmitBtn(
                        text: order == -1 ? '취소' : '이전',
                        onPressed: () => order == -1
                            ? Navigator.pop(context)
                            : ref.read(orderOfRequestProvider.notifier).state--,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.5,
                      child: BottomSubmitBtn(
                        text: '다음',
                        onPressed: () =>
                            ref.read(orderOfRequestProvider.notifier).state++,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }

  final formKey = GlobalKey<FormState>();
  final Patient? patient;
}
