import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/assign/model/available_hospital_model.dart';
import 'package:sbas/features/assign/repos/assign_repo.dart';

class AvailableHospitalPresenter extends AsyncNotifier {
  @override
  FutureOr build() {
    _assignRepository = ref.watch(assignRepoProvider);
  }

  Future<AvailableHospitalModel> getAsync(String? ptId, int? bdasSeq) async {
    if (ptId != null && ptId.isNotEmpty &&
        bdasSeq != null) {
      return await _assignRepository.getAvalHospList(ptId, bdasSeq);
    }
    return AvailableHospitalModel(count: 0, items: []);
  }

  late final AssignRepository _assignRepository;
}

final availableHospitalProvider = AsyncNotifierProvider<AvailableHospitalPresenter, void> (
  () => AvailableHospitalPresenter(),
);