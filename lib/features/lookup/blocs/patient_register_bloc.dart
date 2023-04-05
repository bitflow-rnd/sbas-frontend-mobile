import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/features/authentication/repos/user_reg_req_repo.dart';
import 'package:sbas/features/lookup/models/epidemiological_report_model.dart';
import 'package:sbas/features/lookup/models/patient_reg_info_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';

class PatientRegisterPresenter extends AsyncNotifier<PatientRegInfoModel> {
  @override
  FutureOr<PatientRegInfoModel> build() {
    _patientInfoModel = PatientRegInfoModel.empty();
    _regRepository = ref.read(userRegReqProvider);
    _patientRepository = ref.read(patientRepoProvider);

    return _patientInfoModel;
  }

  Future<void> uploadImage(XFile imageFile) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final attcId = await _regRepository.uploadImage(imageFile);
      ref.read(patientAttcProvider.notifier).state = attcId;

      final report = EpidemiologicalReportModel.fromJson(
          await _patientRepository.getOpticalCharacterRecognition(imageFile));

      _patientInfoModel.addr = report.baseAddr;
      _patientInfoModel.attcId = attcId;
      _patientInfoModel.dethYn = report.dethYn;
      _patientInfoModel.gndr = report.gndr;
      _patientInfoModel.job = report.job;
      _patientInfoModel.ptNm = report.ptNm;
      _patientInfoModel.rrno1 = report.rrno1;
      _patientInfoModel.rrno2 = report.rrno2;

      return _patientInfoModel;
    });
    if (state.hasError) {}
    if (state.hasValue) {}
  }

  void setTextEditingController(int index, String? value) {
    switch (index) {
      case 0:
        _patientInfoModel.ptNm = value;
        return;

      case 1:
        _patientInfoModel.rrno1 = value;
        return;

      case 2:
        _patientInfoModel.addr = value;
        return;

      case 3:
        _patientInfoModel.dethYn = value;
        return;

      case 5:
        _patientInfoModel.mpno = value;
        return;

      case 8:
        _patientInfoModel.job = value;
        return;
    }
  }

  late final PatientRegInfoModel _patientInfoModel;
  late final PatientRepository _patientRepository;
  late final UserRegRequestRepository _regRepository;
}

final patientRegProvider =
    AsyncNotifierProvider<PatientRegisterPresenter, PatientRegInfoModel>(
  () => PatientRegisterPresenter(),
);
final patientImageProvider = StateProvider<XFile?>((ref) => null);
final patientAttcProvider = StateProvider<String?>((ref) => null);
