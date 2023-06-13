import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/features/authentication/repos/user_reg_req_repo.dart';

class BelongAgencyBloc extends AsyncNotifier<List<BaseCodeModel>> {
  @override
  FutureOr<List<BaseCodeModel>> build() async {
    _userRegRequestRepository = ref.read(userRegReqProvider);

    final list = await _userRegRequestRepository.getBaseCode('PTTP');

    for (var e in list) {
      final map = ref.read(isCheckedProvider);

      if (e.cdId == null || e.cdId!.isEmpty) {
        continue;
      }
      map[e.cdId!] = false;
    }
    return list;
  }

  late final UserRegRequestRepository _userRegRequestRepository;
}

final belongAgencyProvider =
    AsyncNotifierProvider<BelongAgencyBloc, List<BaseCodeModel>>(
  () => BelongAgencyBloc(),
);

final isCheckedProvider = StateProvider<Map<String, bool>>((ref) => {});
