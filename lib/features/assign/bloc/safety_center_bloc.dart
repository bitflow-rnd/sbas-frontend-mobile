import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/authentication/models/info_inst_model.dart';
import 'package:sbas/features/authentication/repos/user_reg_req_repo.dart';

class SaftyCenterBloc extends AutoDisposeAsyncNotifier<List<InfoInstModel>> {
  @override
  FutureOr<List<InfoInstModel>> build() async {
    _infoInstRepository = ref.read(userRegReqProvider);

    list = await _infoInstRepository.getOrganCode('', '', '');

    return list;
  }

  Future<void> getFireStatnList(String dstr1Cd, String? dstr2Cd) async {
    list.clear();

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      list.addAll(await _infoInstRepository.getOrganCode("ORGN0002", dstr1Cd, dstr2Cd));

      return list;
    });
    if (state.hasError) {
      if (kDebugMode) {
        print(state.error);
      }
    }
  }

  List<InfoInstModel> list = [];

  late final UserRegRequestRepository _infoInstRepository;
}

final saftyCenterPresenter = AsyncNotifierProvider.autoDispose<SaftyCenterBloc, List<InfoInstModel>>(
  () => SaftyCenterBloc(),
);
