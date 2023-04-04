import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/bottom_submit_btn_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/lookup/blocs/patient_register_bloc.dart';
import 'package:sbas/features/lookup/views/widgets/patient_reg_top_nav_widget.dart';

class PatientRegScreen extends ConsumerWidget {
  PatientRegScreen({
    required this.newPatient,
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final patientImage = ref.watch(patientImageProvider);

    return Scaffold(
      appBar: Bitflow.getAppBar(
        '환자 등록',
        true,
        0,
      ),
      body: ref.watch(patientRegProvider).when(
            loading: () => const SBASProgressIndicator(),
            error: (error, stackTrace) => Center(
              child: Text(
                error.toString(),
                style: const TextStyle(
                  color: Colors.lightBlueAccent,
                ),
              ),
            ),
            data: (data) => Column(
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
                      newPatient
                          ? const Text(
                              '신규 환자 등록',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            )
                          : getPatientInfo(),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: PatientRegTopNav(),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: const Text(
                            '역학조사서 업로드(선택)',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final image = await picker.pickImage(
                              source: kDebugMode
                                  ? ImageSource.gallery
                                  : ImageSource.camera,
                              preferredCameraDevice: CameraDevice.front,
                              requestFullMetadata: false,
                            );
                            if (image != null) {
                              ref.read(patientImageProvider.notifier).state =
                                  image;

                              ref
                                  .read(patientRegProvider.notifier)
                                  .uploadImage(image);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                if (patientImage != null &&
                                    patientImage.path.isNotEmpty)
                                  Image.file(
                                    File(patientImage.path),
                                  )
                                else
                                  Image.asset(
                                    'assets/auth_group/camera_location.png',
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.5,
                      child: BottomSubmitBtn(
                        text: '취소 ',
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      width: width * 0.5,
                      child: BottomSubmitBtn(
                        text: '다음',
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }

  Widget getPatientInfo() {
    return const SizedBox();
  }

  final ImagePicker picker = ImagePicker();
  final bool newPatient;
}
