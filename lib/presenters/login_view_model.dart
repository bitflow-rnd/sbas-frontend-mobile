import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/repository/login_repo.dart';

class LoginViewModel extends AsyncNotifier<void> {
  late final LoginRepo _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepo);
  }

  bool isFirebaseAuth() => _repository.isFirebaseAuth;
}

final loginProvider = AsyncNotifierProvider<LoginViewModel, void>(
  () => LoginViewModel(),
);
