import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/features/authentication/repos/user_reg_req_repo.dart';
import 'package:sbas/features/lookup/presenters/bio_info_presenter.dart';
import 'package:sbas/features/lookup/models/severely_disease_model.dart';

class SeverelyDiseasePresenter extends AsyncNotifier<SeverelyDiseaseModel> {
  @override
  FutureOr<SeverelyDiseaseModel> build() async {
    _userRegRequestRepository = ref.read(userRegReqProvider);

    list = await _userRegRequestRepository.getBaseCode('PTTP');

    list.addAll(
      await _userRegRequestRepository.getBaseCode('UDDS'),
    );
    list.addAll(
      await _userRegRequestRepository.getBaseCode('SVTP'),
    );
    list.addAll(
      await _userRegRequestRepository.getBaseCode('SVIP'),
    );
    list.addAll(
      await _userRegRequestRepository.getBaseCode('BDTP'),
    );
    list.addAll(
      await _userRegRequestRepository.getBaseCode('DNRA'),
    );
    for (final e in list) {
      if (e.cdId != null && e.cdId!.isNotEmpty) {
        ref.read(checkedSeverelyDiseaseProvider.notifier).state[e.cdId!] = false;
      }
    }
    // _patientRepository = ref.read(patientRepoProvider);
    severelyDiseaseModel = SeverelyDiseaseModel.empty();
    return severelyDiseaseModel;
  }

  reset() {
    severelyDiseaseModel = SeverelyDiseaseModel.empty();
    ref.read(bioInfoProvider.notifier).bioInfoModel.clear();
  }

  Future<bool> saveDiseaseInfo(String ptId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final entries = ref.read(checkedSeverelyDiseaseProvider).entries;
      var bioInfoModel = ref.read(bioInfoProvider.notifier).bioInfoModel;
      severelyDiseaseModel.ptId = ptId;
      severelyDiseaseModel.dnrAgreYn = entries.firstWhere((e) => e.value && e.key.substring(0, 4) == 'DNRA').key;
      severelyDiseaseModel.reqBedTypeCd = entries.firstWhere((e) => e.value && e.key.substring(0, 4) == 'BDTP').key;
      severelyDiseaseModel.svrtTypeCd = entries //중증 유형   -> null 가능함.
          .firstWhere(
            (e) => e.value && e.key.substring(0, 4) == 'SVTP',
            orElse: () => const MapEntry("", true),
          )
          .key;
      severelyDiseaseModel.svrtIptTypeCd = entries.firstWhere((e) => e.value && e.key.substring(0, 4) == 'SVIP').key;
      severelyDiseaseModel.udds = entries.where((e) => e.value && e.key.substring(0, 4) == 'UDDS').map<String>((e) => e.key).toList();
      severelyDiseaseModel.pttp = entries.where((e) => e.value && e.key.substring(0, 4) == 'PTTP').map<String>((e) => e.key).toList();
      severelyDiseaseModel.avpuCd = bioInfoModel.avpu;
      severelyDiseaseModel.oxyYn = bioInfoModel.o2Apply;
      severelyDiseaseModel.bdtp = bioInfoModel.bdTemp;
      severelyDiseaseModel.spo2 = bioInfoModel.spo2;
      severelyDiseaseModel.hr = bioInfoModel.pulse;
      severelyDiseaseModel.resp = bioInfoModel.breath;
      severelyDiseaseModel.sbp = bioInfoModel.sbp;
      severelyDiseaseModel.newsScore = bioInfoModel.score;

      return severelyDiseaseModel;
    });
    if (state.hasError) {
      return false;
    }
    if (state.hasValue) {
      debugPrint(state.value?.toJson().toString());
      return true;
    }
    return false;
  }

  late final List<BaseCodeModel> list;
  // late final PatientRepository _patientRepository;
  late final UserRegRequestRepository _userRegRequestRepository;
  SeverelyDiseaseModel severelyDiseaseModel = SeverelyDiseaseModel.empty();
}

final severelyDiseaseProvider = AsyncNotifierProvider<SeverelyDiseasePresenter, SeverelyDiseaseModel>(
  () => SeverelyDiseasePresenter(),
);
final checkedSeverelyDiseaseProvider = StateProvider<Map<String, bool>>(
  (ref) => {},
);
