import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/constants/gaps.dart';

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
    return GestureDetector(
      onTap: () async {
        final image = await widget.picker.pickImage(
          source: isCameraImage ? ImageSource.camera : ImageSource.gallery,
          requestFullMetadata: false,
        );
        if (image != null) {
          setState(() => _pickedImg = image);
        }
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
                  ),
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
                child: _pickedImg != null
                    ? Image.file(
                        File(_pickedImg!.path),
                      )
                    : Image.asset(
                        'assets/auth_group/${isCameraImage ? 'camera' : 'image'}_location.png',
                      ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: () => setState(() {
                    if (_pickedImg == null) {
                      isCameraImage = !isCameraImage;
                    } else {
                      _pickedImg = null;
                    }
                  }),
                  icon: Icon(
                    _pickedImg != null
                        ? Icons.cancel_rounded
                        : Icons.sync_rounded,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          Gaps.v8,
          const Text(
            '※해당 기관 소속을 증명할 수 있는 명함 또는 신분증을 업로드해주세요.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }

  bool isCameraImage = false;
  XFile? _pickedImg;
}
