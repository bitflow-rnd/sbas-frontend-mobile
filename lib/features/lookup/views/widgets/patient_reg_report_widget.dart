import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/common.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/assign/bloc/assign_bed_bloc.dart';

class PatientRegReport extends ConsumerWidget {
  const PatientRegReport({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientImage = ref.watch(patientImageProvider);
    final ImagePicker picker = ImagePicker();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(
                text: '역학조사서 업로드(선택) ',
                style: CTS.medium(
                  color: Colors.black,
                ),
                // children: [
                //   WidgetSpan(
                //     child: GestureDetector(
                //       onTap: () => ref.read(patientIsUploadProvider.notifier).state = !ref.read(patientIsUploadProvider),
                //       child: Icon(
                //         ref.watch(patientIsUploadProvider) ? Icons.cancel_outlined : Icons.check_circle_outline_rounded,
                //         size: 20,
                //         color: Colors.grey,
                //       ),
                //     ),
                //   ),
                // ],
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              final image = await picker.pickImage(
                source: ImageSource.gallery,
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
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 75.h,
                            ),
                            decoration: BoxDecoration(
                              color: Palette.greyText_08,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Image.asset(
                              'assets/auth_group/camera_location.png',
                              width: 80.w,
                              height: 60.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (patientImage != null && patientImage.path.isNotEmpty)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () async {
                          var res = await Common.showModal(
                            context,
                            Common.commonModal(
                              context: context,
                              mainText: "역학조사서를 삭제하시겠습니까?",
                              imageWidget: Image.asset(
                                "assets/auth_group/modal_check.png",
                                width: 44.h,
                              ),
                              imageHeight: 44.h,
                              button1Function: () => Navigator.pop(context, false),
                              button2Function: () => Navigator.pop(context, true),
                            ),
                          );
                          if (res) {
                            ref.invalidate(patientImageProvider);
                            ref.invalidate(patientImageProvider);
                            ref.invalidate(patientIsUploadProvider);
                            // ignore: use_build_context_synchronously
                            Common.showModal(
                              context,
                              // ignore: use_build_context_synchronously
                              Common.commonModal(
                                context: context,
                                mainText: "역학조사서가 삭제 되었습니다.",
                                imageWidget: Image.asset(
                                  "assets/auth_group/modal_check.png",
                                  width: 44.h,
                                ),
                                imageHeight: 44.h,
                              ),
                            );
                          }
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
