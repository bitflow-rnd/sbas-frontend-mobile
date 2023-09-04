import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/lookup/models/bio_info_model.dart';
import 'package:sbas/features/lookup/models/severely_disease_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';

class BioInfoPresenter extends AsyncNotifier<BioInfoModel> {
  @override
  FutureOr<BioInfoModel> build() {
    bioInfoModel = BioInfoModel();
    _patientRepository = ref.read(patientRepoProvider);

    return bioInfoModel;
  }

  Future<int> analyze(String ptId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      bioInfoModel.score = await _patientRepository.bioinfoanlys(bioInfoModel.toJson());

      return bioInfoModel;
    });
    if (state.hasValue) {}
    return bioInfoModel.score ?? 0;
  }

  late final PatientRepository _patientRepository;
  late final BioInfoModel bioInfoModel;
  // late final SeverelyDiseaseModel severelyDiseaseModel;
}

final bioInfoProvider = AsyncNotifierProvider<BioInfoPresenter, BioInfoModel>(
  () => BioInfoPresenter(),
);
