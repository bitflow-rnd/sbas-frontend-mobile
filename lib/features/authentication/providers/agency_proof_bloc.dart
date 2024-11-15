import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/common/repos/file_repo.dart';
import 'package:sbas/features/authentication/providers/user_reg_bloc.dart';
import 'package:sbas/features/authentication/repos/user_reg_req_repo.dart';

class AgencyProofBloc extends AsyncNotifier<String> {
  @override
  FutureOr<String> build() {
    _regRepository = UserRegRequestRepository();
    _fileRepository = FileRepository();
    return '';
  }

  uploadImage() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        final image = ref.read(imageProvider.notifier).state;

        return image != null ? await _fileRepository.uploadPrivateImage(image).then((value) => value[0]) : '';
      },
    );
    if (state.hasError) {
      if (kDebugMode) {
        print(state.error);
      }
    }
    if (state.hasValue) {
      ref.read(regUserProvider).attcId = state.value;
    }
  }

  late final UserRegRequestRepository _regRepository;
  late final FileRepository _fileRepository;
}

final proofProvider = AsyncNotifierProvider<AgencyProofBloc, String>(
  () => AgencyProofBloc(),
);
final imageProvider = StateProvider<XFile?>((ref) => null);

final isUsingCameraProvider = StateProvider((ref) => false);
