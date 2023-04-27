import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/features/authentication/repos/user_reg_req_repo.dart';

class SeverelyDiseasePresenter extends AsyncNotifier<List<BaseCodeModel>> {
  @override
  FutureOr<List<BaseCodeModel>> build() async {
    _userRegRequestRepository = ref.read(userRegReqProvider);

    final list = await _userRegRequestRepository.getBaseCode('PTTP');

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
    return list;
  }

  registry(String ptId) {
    for (final kv in ref.read(checkedSeverelyDiseaseProvider).entries) {
      if (kv.value) {
        print(kv.key);
      }
    }
    print(ptId);
  }

  late final UserRegRequestRepository _userRegRequestRepository;
}

final severelyDiseaseProvider =
    AsyncNotifierProvider<SeverelyDiseasePresenter, List<BaseCodeModel>>(
  () => SeverelyDiseasePresenter(),
);
final checkedSeverelyDiseaseProvider = StateProvider<Map<String, bool>>(
  (ref) => {},
);
