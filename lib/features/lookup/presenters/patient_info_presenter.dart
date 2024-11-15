import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/patient/models/patient_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';

class PatientInfoPresenter extends AsyncNotifier<Patient> {
  @override
  FutureOr<Patient> build() {
    String? ptId = ref.read(patientIdProvider);
    debugPrint("PatientInfoPresenter build $ptId");
    return getAsync(ptId);
  }

  Future<Patient> getAsync(String? ptId) async {
    if (ptId != null && ptId.isNotEmpty) {
      return await _repository.getPatientInfo(ptId);
    }
    return Patient();
  }

  final PatientRepository _repository = PatientRepository();
}

final patientInfoProvider = AsyncNotifierProvider<PatientInfoPresenter, Patient>(
  () => PatientInfoPresenter(),
);
final patientIdProvider = StateProvider.autoDispose<String?>((ref) => '');