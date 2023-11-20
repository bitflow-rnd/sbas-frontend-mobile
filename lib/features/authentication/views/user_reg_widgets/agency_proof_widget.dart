import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/features/authentication/blocs/agency_proof_bloc.dart';
import 'package:sbas/constants/palette.dart';

class AgencyProof extends ConsumerStatefulWidget {
  AgencyProof({
    super.key,
  });
  final ImagePicker picker = ImagePicker();
  @override
  ConsumerState<AgencyProof> createState() => _AgencyProofState();
}

class _AgencyProofState extends ConsumerState<AgencyProof> {
  @override
  Widget build(BuildContext context) {
    final isUsingCamera = ref.watch(isUsingCameraProvider.notifier).state;
    final image = ref.watch(imageProvider.notifier).state;

    return FormField(
      initialValue: image == null,
      builder: (field) => ref.watch(proofProvider).when(
            loading: () => const SBASProgressIndicator(),
            error: (error, stackTrace) => Center(
              child: Text(
                error.toString(),
                style: const TextStyle(
                  color: Palette.mainColor,
                ),
              ),
            ),
            data: (data) => GestureDetector(
              onTap: () async {
                final image = await widget.picker.pickImage(
                  source: isUsingCamera ? ImageSource.camera : ImageSource.gallery,
                  requestFullMetadata: false,
                );
                if (image != null) {
                  ref.read(imageProvider.notifier).state = image;

                  ref.read(proofProvider.notifier).uploadImage();
                }
                field.didChange(image == null);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(
                            4.r,
                          ),
                        ),
                        child: image != null
                            ? Image.file(
                                File(image.path),
                              )
                            : Image.asset(
                                'assets/auth_group/${isUsingCamera ? 'camera' : 'image'}_location.png',
                              ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () => setState(
                            () {
                              if (image == null) {
                                ref.read(isUsingCameraProvider.notifier).state = !isUsingCamera;
                              } else {
                                ref.read(imageProvider.notifier).state = null;
                              }
                              field.didChange(ref.read(imageProvider) == null);
                            },
                          ),
                          icon: Icon(
                            image != null ? Icons.cancel_rounded : Icons.sync_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
