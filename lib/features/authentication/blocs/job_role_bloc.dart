import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/features/authentication/models/user_reg_req_model.dart';
import 'package:sbas/features/authentication/repos/user_reg_req_repo.dart';

class JobRoleBloc extends AsyncNotifier<List<BaseCodeModel>> {
  @override
  FutureOr<List<BaseCodeModel>> build() async {
    _userRegRequestRepository = ref.read(userRegReqProvider);

    return await _userRegRequestRepository.getBaseCode('ORGN');
  }

  late final UserRegRequestRepository _userRegRequestRepository;
}

final jobRoleProvider = AsyncNotifierProvider<JobRoleBloc, List<BaseCodeModel>>(
  () => JobRoleBloc(),
);

final regIndexProvider = StateProvider(
  (ref) => -1.0,
  name: 'index',
);
final regUserProvider = StateProvider(
  (ref) => UserRegModel.empty(),
);
