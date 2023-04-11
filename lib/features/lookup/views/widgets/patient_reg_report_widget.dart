import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/features/lookup/blocs/patient_register_bloc.dart';

class PatientRegReport extends ConsumerWidget {
  const PatientRegReport({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientImage = ref.watch(patientImageProvider);
    final ImagePicker picker = ImagePicker();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(
                text: '역학조사서 업로드 ',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                children: [
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () => ref
                          .read(patientIsUploadProvider.notifier)
                          .state = !ref.read(patientIsUploadProvider),
                      child: Icon(
                        ref.watch(patientIsUploadProvider)
                            ? Icons.cancel_outlined
                            : Icons.check_circle_outline_rounded,
                        size: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              final image = await picker.pickImage(
                source: kDebugMode ? ImageSource.gallery : ImageSource.camera,
                preferredCameraDevice: CameraDevice.front,
                requestFullMetadata: false,
              );
              if (image != null) {
                ref.read(patientImageProvider.notifier).state = image;
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
              ),
              alignment: Alignment.center,
              child: Stack(
                children: [
                  if (patientImage != null && patientImage.path.isNotEmpty)
                    Image.file(
                      File(patientImage.path),
                    )
                  else
                    Image.asset(
                      'assets/auth_group/camera_location.png',
                    ),
                  if (patientImage != null && patientImage.path.isNotEmpty)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          ref.read(patientImageProvider.notifier).state = null;
                          ref.read(patientAttcProvider.notifier).state = null;
                          ref.read(patientIsUploadProvider.notifier).state =
                              true;
                        },
                        icon: Icon(
                          Icons.cancel_sharp,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
