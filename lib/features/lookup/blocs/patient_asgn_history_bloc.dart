import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/lookup/models/patient_history_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';

class PatientAsgnHistoryBloc extends AsyncNotifier<PatientHistoryList> {
  @override
  FutureOr<PatientHistoryList> build() {
    _repository = ref.read(patientRepoProvider);
    _historyList = PatientHistoryList(count: 0, items: []);
    return _historyList;
  }

  Future<void> refresh(String? ptId) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return await getAsync(ptId);
    });
    if (state.hasError) {}
    if (state.hasValue) {}
  }

  Future<PatientHistoryList> getAsync(String? ptId) async {
      if (ptId != null && ptId.isNotEmpty) {
        return _repository.getPatientHistory(ptId);
      }
      return PatientHistoryList(count: 0, items: []);
  }

  bool checkBedAssignCompletion() {
    if (state.value?.count == 0) return false;
    if (state.value?.items.last.bedStatCd != "BAST0007" ||
        state.value?.items.last.bedStatCd != "BAST0008") {
      return true;
    }
    return false;
  }

  late final PatientRepository _repository;
  late final PatientHistoryList _historyList;

}

final patientAsgnHistoryProvider = AsyncNotifierProvider<PatientAsgnHistoryBloc, PatientHistoryList>(
  () => PatientAsgnHistoryBloc(),
);
