import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/lookup/models/origin_info_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';

class PatientTransferInfoPresenter extends AsyncNotifier {
  @override
  FutureOr build() {
    _patientRepository = ref.read(patientRepoProvider);
  }

  Future<OriginInfoModel> getTransInfo(String? ptId, int? bdasSeq) async {
    if (ptId != null && ptId.isNotEmpty && bdasSeq != null && bdasSeq != -1) {
      return await _patientRepository.getTransferInfo(ptId, bdasSeq);
    }
    return OriginInfoModel();
  }

  late final PatientRepository _patientRepository;
}

final patientTransferInfoProvider = AsyncNotifierProvider<PatientTransferInfoPresenter, void>(
  () => PatientTransferInfoPresenter(),
);
