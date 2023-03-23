import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/authentication/models/user_reg_req_model.dart';

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

final userRegProvider = StateProvider(
  (ref) => UserRegModel(),
  name: 'userModel',
);

final regIndexProvider = StateProvider(
  (ref) => -1.0,
  name: 'x',
);
