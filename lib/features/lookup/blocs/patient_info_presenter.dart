import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/lookup/models/patient_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';

class PatientInfoPresenter extends AsyncNotifier {
  @override
  FutureOr build() {
    _repository = ref.read(patientRepoProvider);
  }

  Future<Patient> getAsync(String? ptId) async {
    if (ptId != null && ptId.isNotEmpty) {
      return await _repository.getPatientInfo(ptId);
    }
    return Patient();
  }

  late final PatientRepository _repository;
}

final patientInfoProvider = AsyncNotifierProvider<PatientInfoPresenter, void>(
  () => PatientInfoPresenter(),
);
