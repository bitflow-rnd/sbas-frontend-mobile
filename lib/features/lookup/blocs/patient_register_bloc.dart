import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/features/authentication/repos/user_reg_req_repo.dart';
import 'package:sbas/features/lookup/models/epidemiological_report_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';

class PatientRegisterPresenter
    extends AsyncNotifier<EpidemiologicalReportModel> {
  @override
  FutureOr<EpidemiologicalReportModel> build() {
    _regRepository = ref.read(userRegReqProvider);
    _patientRepository = ref.read(patientRepoProvider);

    return EpidemiologicalReportModel.empty();
  }

  Future<void> uploadImage(XFile imageFile) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      ref.read(patientAttcProvider.notifier).state =
          await _regRepository.uploadImage(imageFile);

      return EpidemiologicalReportModel.fromJson(
          await _patientRepository.getOpticalCharacterRecognition(imageFile));
    });
    if (state.hasError) {}
    if (state.hasValue) {}
  }

  late final PatientRepository _patientRepository;
  late final UserRegRequestRepository _regRepository;
}

final patientRegProvider =
    AsyncNotifierProvider<PatientRegisterPresenter, EpidemiologicalReportModel>(
  () => PatientRegisterPresenter(),
);
final patientImageProvider = StateProvider<XFile?>((ref) => null);
final patientAttcProvider = StateProvider<String?>((ref) => null);
