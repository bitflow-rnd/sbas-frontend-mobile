import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/assign/model/assign_list_model.dart';
import 'package:sbas/features/lookup/models/patient_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';

class PatientAsgnHistoryPresenter extends AsyncNotifier<AssignListModel> {
  @override
  FutureOr<AssignListModel> build() {
    _repository = ref.read(patientRepoProvider);
    _assignListModel = AssignListModel(count: 0, items: [], x: 0);
    // state = _assignListModel;
    return _assignListModel;
  }

  Future<void> getAsync(String? ptId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      if (ptId != null && ptId.isNotEmpty) {
        AssignListModel t = await _repository.getPatientHistory(ptId);
        _assignListModel.items.clear();
        _assignListModel.items.addAll(t.items);
        _assignListModel.count = t.count;
      }
      return _assignListModel;
    });
    if (state.hasError) {}
    if (state.hasValue) {}
  }

  late final PatientRepository _repository;
  late final AssignListModel _assignListModel;
}

final patientAsgnHistoryPresenter = AsyncNotifierProvider<PatientAsgnHistoryPresenter, AssignListModel>(
  () => PatientAsgnHistoryPresenter(),
);
