import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/lookup/models/patient_disease_info_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';

class PatientDiseaseInfoPresenter extends AsyncNotifier {
  @override
  FutureOr build() {
    _patientRepository = ref.read(patientRepoProvider);
  }

  Future<PatientDiseaseInfoModel> getAsync(String? ptId) async {
    if (ptId != null && ptId.isNotEmpty) {
      return await _patientRepository.getDiseaseInfo(ptId);
    }
    return PatientDiseaseInfoModel(undrDsesNms: [], ptTypeNms: [], svrtTypeNms: []);
  }

  late final PatientRepository _patientRepository;
}

final patientDiseaseInfoProvider = AsyncNotifierProvider<PatientDiseaseInfoPresenter, void>(
      () => PatientDiseaseInfoPresenter(),
);
