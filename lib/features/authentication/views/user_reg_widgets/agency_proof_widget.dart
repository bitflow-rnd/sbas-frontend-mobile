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
          source: ImageSource.gallery,
          requestFullMetadata: false,
        );
        if (image != null) {
          setState(() => _pickedImg = image);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    'assets/auth_group/image_location.png',
                  ),
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

  XFile? _pickedImg;
}
