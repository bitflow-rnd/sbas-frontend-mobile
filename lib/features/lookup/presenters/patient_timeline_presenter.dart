import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/lookup/models/patient_timeline_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';

class PatientTimeLinePresenter extends AsyncNotifier<PatientTimelineModel> {
  @override
  FutureOr<PatientTimelineModel> build() async {
    _patientRepository = ref.read(patientRepoProvider);
    patientTimelineModel = PatientTimelineModel(count: 0, items: []);
    return patientTimelineModel;
  }

  Future<void> refresh(String? ptId, int? bdasSeq) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return await getAsync(ptId, bdasSeq);
    });
    if (state.hasError) {}
    if (state.hasValue) {}
  }

  Future<PatientTimelineModel> getAsync(String? ptId, int? bdasSeq) async {
    if (ptId != null && ptId.isNotEmpty && bdasSeq != null) {
      return _patientRepository.getTimeLine(ptId, bdasSeq);
    }
    return PatientTimelineModel(count: 0, items: []);
  }

  late final PatientTimelineModel patientTimelineModel;
  late final PatientRepository _patientRepository;
}

final patientTimeLineProvider = AsyncNotifierProvider<PatientTimeLinePresenter, PatientTimelineModel>(
  () => PatientTimeLinePresenter(),
);
