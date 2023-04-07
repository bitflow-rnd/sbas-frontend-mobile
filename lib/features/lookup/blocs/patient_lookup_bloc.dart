import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/lookup/models/patient_info_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';

class PatientLookupBloc extends AsyncNotifier<PatientInfoModel> {
  @override
  FutureOr<PatientInfoModel> build() async {
    _patientRepository = ref.read(patientRepoProvider);

    return await _patientRepository.lookupPatientInfo();
  }

  late final PatientRepository _patientRepository;
}

final patientLookupProvider =
    AsyncNotifierProvider<PatientLookupBloc, PatientInfoModel>(
  () => PatientLookupBloc(),
);
