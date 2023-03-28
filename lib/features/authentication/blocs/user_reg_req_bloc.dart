import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/authentication/models/user_reg_req_model.dart';
import 'package:sbas/features/authentication/repos/user_reg_req_repo.dart';

class UserRegBloc extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<dynamic> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      print({
        'provider': provider.name ?? provider.runtimeType,
        'newValue': newValue
      });
    }
  }
}

final regIndexProvider = StateProvider(
  (ref) => -1.0,
  name: 'x',
);

class UserRegRequestBloc extends AsyncNotifier<UserRegModel> {
  @override
  FutureOr<UserRegModel> build() {
    _userRegRequestRepository = ref.read(userRegReqProvider);

    return UserRegModel.empty();
  }

  late final UserRegRequestRepository _userRegRequestRepository;
}

final userRegProvider = AsyncNotifierProvider<UserRegRequestBloc, UserRegModel>(
  () => UserRegRequestBloc(),
);
