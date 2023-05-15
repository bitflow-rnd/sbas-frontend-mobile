import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/assign/model/assign_list_model.dart';
import 'package:sbas/features/assign/repos/assign_repo.dart';

class AssignBedPresenter extends AsyncNotifier<AssignListModel> {
  @override
  FutureOr<AssignListModel> build() async {
    _patientRepository = ref.read(assignRepoProvider);

    return await _patientRepository.lookupPatientInfo('BAST0003');
  }

  late final AssignRepository _patientRepository;
}

final assignBedProvider =
    AsyncNotifierProvider<AssignBedPresenter, AssignListModel>(
  () => AssignBedPresenter(),
);
