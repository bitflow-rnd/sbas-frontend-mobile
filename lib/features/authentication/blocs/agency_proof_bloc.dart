import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/features/authentication/blocs/user_reg_bloc.dart';
import 'package:sbas/features/authentication/repos/user_reg_req_repo.dart';

class AgencyProofBloc extends AsyncNotifier<String> {
  @override
  FutureOr<String> build() {
    _regRepository = UserRegRequestRepository();

    return '';
  }

  uploadImage() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        final image = ref.read(imageProvider.notifier).state;

        return image != null ? await _regRepository.uploadImage(image) : '';
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
}

final proofProvider = AsyncNotifierProvider<AgencyProofBloc, String>(
  () => AgencyProofBloc(),
);
final imageProvider = StateProvider<XFile?>((ref) => null);

final isUsingCameraProvider = StateProvider((ref) => false);
