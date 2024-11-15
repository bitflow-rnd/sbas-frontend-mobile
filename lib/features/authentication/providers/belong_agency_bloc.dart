import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/features/authentication/providers/user_reg_bloc.dart';
import 'package:sbas/features/authentication/repos/user_reg_req_repo.dart';

class BelongAgencyBloc extends AsyncNotifier<List<BaseCodeModel>> {
  @override
  FutureOr<List<BaseCodeModel>> build() async {
    _userRegRequestRepository = ref.read(userRegReqProvider);

    final list = await _userRegRequestRepository.getBaseCode('PTTP');

    for (var e in list) {
      final map = ref.read(checkedPTTPProvicer);

      if (e.cdId == null || e.cdId!.isEmpty) {
        continue;
      }
      map[e.cdId!] = false;
    }

    return list;
  }

  void setOrgnType(String orgnType) {
    ref.read(orgnTypeProvider.notifier).state = orgnType;
    String instTypeCd = '';
    switch (orgnType) {
      case "의료진":
        instTypeCd = "ORGN0004";
        break;
      case "병상배정":
        instTypeCd = "ORGN0001";
        break;
      case "보건소":
        instTypeCd = "ORGN0003";
        break;
      case "전산":
        instTypeCd = "ORGN0005";
        break;
    }

    ref.read(regUserProvider.notifier).state.instTypeCd = instTypeCd;
  }

  submit() {
    //reset provider
    ref.read(isReadOnlyProvider.notifier).state = false;
    ref.read(orgnTypeProvider.notifier).state = '';
    ref.read(checkedPTTPProvicer.notifier).state = {};
  }

  late final UserRegRequestRepository _userRegRequestRepository;
}

final belongAgencyProvider = AsyncNotifierProvider<BelongAgencyBloc, List<BaseCodeModel>>(
  () => BelongAgencyBloc(),
);
final orgnTypeProvider = StateProvider<String>((ref) => '');
final isReadOnlyProvider = StateProvider<bool>((ref) => false);
final checkedPTTPProvicer = StateProvider<Map<String, bool>>((ref) => {});
