import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/lookup/models/patient_timeline_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';

class PatientTimeLinePresenter extends AsyncNotifier {
  @override
  FutureOr build() {
    _patientRepository = ref.read(patientRepoProvider);
  }

  Future<PatientTimelineModel> getAsync(String? ptId, int? bdasSeq) async {
    if (ptId != null && ptId.isNotEmpty &&
        bdasSeq != null) {
      return await _patientRepository.getTimeLine(ptId, bdasSeq);
    }
    return PatientTimelineModel(count: 0, items: []);
  }

  late final PatientRepository _patientRepository;
}

final patientTimeLineProvider = AsyncNotifierProvider<PatientTimeLinePresenter, void> (
      () => PatientTimeLinePresenter(),
);
