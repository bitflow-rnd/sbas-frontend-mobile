import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/assign/model/assign_list_model.dart';
import 'package:sbas/features/assign/repos/assign_repo.dart';

class AssignBedPresenter extends AsyncNotifier<AssignListModel> {
  @override
  FutureOr<AssignListModel> build() async {
    _patientRepository = ref.read(assignRepoProvider);

    final model = await _patientRepository.lookupPatientInfo('BAST0003');

    model.x = -1;

    return model;
  }

  Future<void> setTopNavItem(double x) async {
    state = await AsyncValue.guard(() async {
      final model = await _patientRepository.lookupPatientInfo(getCode(x));

      model.x = x;

      return model;
    });
    if (state.hasError) {}
  }

  String getCode(double x) {
    if (x == -1) {
      return 'BAST0003';
    }
    if (x == -0.5) {
      return 'BAST0005';
    }
    if (x == 0) {
      return 'BAST0006';
    }
    if (x == 0.5) {
      return 'BAST0007';
    }
    if (x == 1) {
      return 'BAST0007';
    }
    return '';
  }

  late final AssignRepository _patientRepository;
}

final assignBedProvider =
    AsyncNotifierProvider<AssignBedPresenter, AssignListModel>(
  () => AssignBedPresenter(),
);
