import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/features/authentication/repos/user_reg_req_repo.dart';
import 'package:sbas/features/lookup/blocs/bio_info_presenter.dart';
import 'package:sbas/features/lookup/models/severely_disease_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';

class SeverelyDiseasePresenter extends AsyncNotifier<List<BaseCodeModel>> {
  @override
  FutureOr<List<BaseCodeModel>> build() async {
    _userRegRequestRepository = ref.read(userRegReqProvider);

    _list = await _userRegRequestRepository.getBaseCode('PTTP');

    _list.addAll(
      await _userRegRequestRepository.getBaseCode('UDDS'),
    );
    _list.addAll(
      await _userRegRequestRepository.getBaseCode('SVTP'),
    );
    _list.addAll(
      await _userRegRequestRepository.getBaseCode('SVIP'),
    );
    _list.addAll(
      await _userRegRequestRepository.getBaseCode('BDTP'),
    );
    _list.addAll(
      await _userRegRequestRepository.getBaseCode('DNRA'),
    );
    for (final e in _list) {
      if (e.cdId != null && e.cdId!.isNotEmpty) {
        ref.read(checkedSeverelyDiseaseProvider.notifier).state[e.cdId!] = false;
      }
    }
    _patientRepository = ref.read(patientRepoProvider);

    return _list;
  }

  Future<void> registry(String ptId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final entries = ref.read(checkedSeverelyDiseaseProvider).entries;
      var bioInfoModel = ref.read(bioInfoProvider.notifier).bioInfoModel;

      await _patientRepository.regSevrInfo(SeverelyDiseaseModel(
        ptId: ptId,
        dnrAgreYn: entries.firstWhere((e) => e.value && e.key.substring(0, 4) == 'DNRA').key,
        reqBedTypeCd: entries.firstWhere((e) => e.value && e.key.substring(0, 4) == 'BDTP').key,
        svrtTypeCd: entries.firstWhere((e) => e.value && e.key.substring(0, 4) == 'SVTP').key,
        svrtIptTypeCd: entries.firstWhere((e) => e.value && e.key.substring(0, 4) == 'SVIP').key,
        udds: entries.where((e) => e.value && e.key.substring(0, 4) == 'UDDS').map<String>((e) => e.key).toList(),
        pttp: entries.where((e) => e.value && e.key.substring(0, 4) == 'PTTP').map<String>((e) => e.key).toList(),
        avpuCd: bioInfoModel.avpu,
        oxyYn: bioInfoModel.o2Apply,
        bdtp: bioInfoModel.bdTemp,
        spo2: bioInfoModel.spo2,
        hr: bioInfoModel.pulse,
        resp: bioInfoModel.breath,
        sbp: bioInfoModel.sbp,
        newsScore: bioInfoModel.score,
      ).toJson());

      return _list;
    });
    if (state.hasError) {}
  }

  Future<void> saveDiseaseInfo(String ptId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final entries = ref.read(checkedSeverelyDiseaseProvider).entries;
      var bioInfoModel = ref.read(bioInfoProvider.notifier).bioInfoModel;

      severelyDiseaseModel = SeverelyDiseaseModel(
        ptId: ptId,
        dnrAgreYn: entries.firstWhere((e) => e.value && e.key.substring(0, 4) == 'DNRA').key,
        reqBedTypeCd: entries.firstWhere((e) => e.value && e.key.substring(0, 4) == 'BDTP').key,
        svrtTypeCd: entries.firstWhere((e) => e.value && e.key.substring(0, 4) == 'SVTP').key,
        svrtIptTypeCd: entries.firstWhere((e) => e.value && e.key.substring(0, 4) == 'SVIP').key,
        udds: entries.where((e) => e.value && e.key.substring(0, 4) == 'UDDS').map<String>((e) => e.key).toList(),
        pttp: entries.where((e) => e.value && e.key.substring(0, 4) == 'PTTP').map<String>((e) => e.key).toList(),
        avpuCd: bioInfoModel.avpu,
        oxyYn: bioInfoModel.o2Apply,
        bdtp: bioInfoModel.bdTemp,
        spo2: bioInfoModel.spo2,
        hr: bioInfoModel.pulse,
        resp: bioInfoModel.breath,
        sbp: bioInfoModel.sbp,
        newsScore: bioInfoModel.score,
      );

      return _list;
    });
    if (state.hasError) {}
  }

  late final List<BaseCodeModel> _list;
  late final PatientRepository _patientRepository;
  late final UserRegRequestRepository _userRegRequestRepository;
  late final SeverelyDiseaseModel severelyDiseaseModel;
}

final severelyDiseaseProvider = AsyncNotifierProvider<SeverelyDiseasePresenter, List<BaseCodeModel>>(
  () => SeverelyDiseasePresenter(),
);
final checkedSeverelyDiseaseProvider = StateProvider<Map<String, bool>>(
  (ref) => {},
);
