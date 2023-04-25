import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/lookup/models/bio_info_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';

class BioInfoPresenter extends AsyncNotifier<BioInfoModel> {
  @override
  FutureOr<BioInfoModel> build() {
    _model = BioInfoModel();
    _patientRepository = ref.read(patientRepoProvider);

    return _model;
  }

  Future<int> analyze() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      _model.score = await _patientRepository.bioinfoanlys(_model.toJson());

      return _model;
    });
    return _model.score ?? 0;
  }

  late final PatientRepository _patientRepository;
  late final BioInfoModel _model;
}

final bioInfoProvider = AsyncNotifierProvider<BioInfoPresenter, BioInfoModel>(
  () => BioInfoPresenter(),
);
