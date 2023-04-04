import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/features/authentication/repos/user_reg_req_repo.dart';
import 'package:sbas/features/lookup/models/epidemiological_report_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';

class PatientRegisterPresenter extends AsyncNotifier<String> {
  @override
  FutureOr<String> build() {
    _regRepository = ref.read(userRegReqProvider);
    _patientRepository = ref.read(patientRepoProvider);

    return '';
  }

  Future<void> uploadImage(XFile imageFile) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final key = await _regRepository.uploadImage(imageFile);

      final char = EpidemiologicalReportModel.fromJson(
          await _patientRepository.getOpticalCharacterRecognition(imageFile));

      return '';
    });
    if (state.hasError) {}
    if (state.hasValue) {}
  }

  late final PatientRepository _patientRepository;
  late final UserRegRequestRepository _regRepository;
}

final patientRegProvider =
    AsyncNotifierProvider<PatientRegisterPresenter, String>(
  () => PatientRegisterPresenter(),
);
final patientImageProvider = StateProvider<XFile?>((ref) => null);
