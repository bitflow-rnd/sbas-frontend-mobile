import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sbas/features/authentication/models/user_reg_req_model.dart';
import 'package:sbas/features/authentication/repos/user_reg_req_repo.dart';
import 'package:sbas/features/authentication/views/login_screen.dart';

class UserRegBloc extends AsyncNotifier {
  @override
  FutureOr build() {
    _signUpRepository = ref.read(userRegReqProvider);
  }

  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = ref.read(regUserProvider);
      await _signUpRepository.reqUserReg(user);
    });
    if (state.hasError) {}
    if (context.mounted) {
      context.pop();
      context.goNamed(LogInScreen.routeName);
    }
  }

  late final UserRegRequestRepository _signUpRepository;
}

final signUpProvider = AsyncNotifierProvider<UserRegBloc, void>(
  () => UserRegBloc(),
);
final regUserProvider = StateProvider(
  (ref) => UserRegModel.empty(),
);
