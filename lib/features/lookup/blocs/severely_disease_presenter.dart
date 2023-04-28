import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/features/authentication/repos/user_reg_req_repo.dart';
import 'package:sbas/features/lookup/models/severely_disease_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';

class SeverelyDiseasePresenter extends AsyncNotifier<List<BaseCodeModel>> {
  @override
  FutureOr<List<BaseCodeModel>> build() async {
    _userRegRequestRepository = ref.read(userRegReqProvider);

    list = await _userRegRequestRepository.getBaseCode('PTTP');

    list.addAll(
      await _userRegRequestRepository.getBaseCode('UDDS'),
    );
    list.addAll(
      await _userRegRequestRepository.getBaseCode('SVTP'),
    );
    list.addAll(
      await _userRegRequestRepository.getBaseCode('BDTP'),
    );
    list.addAll(
      await _userRegRequestRepository.getBaseCode('DNRA'),
    );
    for (final e in list) {
      if (e.id != null && e.id!.cdId != null && e.id!.cdId!.isNotEmpty) {
        ref.read(checkedSeverelyDiseaseProvider.notifier).state[e.id!.cdId!] =
            false;
      }
    }
    _patientRepository = ref.read(patientRepoProvider);

    return list;
  }

  Future<void> registry(String ptId) async {
    final entries = ref.read(checkedSeverelyDiseaseProvider).entries;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _patientRepository.regSevrInfo(SeverelyDiseaseModel(
              ptId: ptId,
              dnrAgreYn: entries
                  .firstWhere((e) => e.value && e.key.substring(0, 4) == 'DNRA')
                  .key,
              reqBedTypeCd: entries
                  .firstWhere((e) => e.value && e.key.substring(0, 4) == 'BDTP')
                  .key,
              svrtIptTypeCd: entries
                  .firstWhere((e) => e.value && e.key.substring(0, 4) == 'SVTP')
                  .key,
              udds: entries
                  .where((e) => e.value && e.key.substring(0, 4) == 'UDDS')
                  .map<String>((e) => e.key)
                  .toList(),
              pttp: entries
                  .where((e) => e.value && e.key.substring(0, 4) == 'PTTP')
                  .map<String>((e) => e.key)
                  .toList())
          .toJson());

      return list;
    });
    if (state.hasError) {}
  }

  late final List<BaseCodeModel> list;
  late final PatientRepository _patientRepository;
  late final UserRegRequestRepository _userRegRequestRepository;
}

final severelyDiseaseProvider =
    AsyncNotifierProvider<SeverelyDiseasePresenter, List<BaseCodeModel>>(
  () => SeverelyDiseasePresenter(),
);
final checkedSeverelyDiseaseProvider = StateProvider<Map<String, bool>>(
  (ref) => {},
);
