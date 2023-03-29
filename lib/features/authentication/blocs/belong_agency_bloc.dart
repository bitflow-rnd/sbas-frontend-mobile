import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/features/authentication/repos/user_reg_req_repo.dart';

class BelongAgencyBloc extends AsyncNotifier<List<BaseCodeModel>> {
  @override
  FutureOr<List<BaseCodeModel>> build() async {
    _userRegRequestRepository = ref.read(userRegReqProvider);

    return await _userRegRequestRepository.getBaseCode('PTTP');
  }

  late final UserRegRequestRepository _userRegRequestRepository;
}

final belongAgencyProvider =
    AsyncNotifierProvider<BelongAgencyBloc, List<BaseCodeModel>>(
  () => BelongAgencyBloc(),
);
