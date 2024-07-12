import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/authentication/models/authentiate_req_model.dart';
import 'package:sbas/features/authentication/models/user_reg_req_model.dart';
import 'package:sbas/features/authentication/repos/user_reg_req_repo.dart';
import 'package:sbas/features/authentication/views/user_reg_req_screen_v2.dart';

class UserRegBloc extends AsyncNotifier {
  @override
  FutureOr build() {
    _signUpRepository = ref.read(userRegReqProvider);
  }

  Future<Map<String, dynamic>> confirm(String authNumber) async =>
      _signUpRepository.confirm(
        ref.read(regUserProvider).telno ?? '',
        authNumber,
      );

  Future<String> findId(AuthenticateReqModel request) async {
    return _signUpRepository.findId(
      request.userNm,
      request.telno
    );
  }

  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = ref.read(regUserProvider);
      user.authCd = 'DTPM0001';
      return await _signUpRepository.reqUserReg(user);
    });
    if (state.hasError) {}
    if (state.hasValue && state.value == 200 && context.mounted) {
      ref.read(isPhoneAuthSuccess.notifier).state = false;
      ref.read(regUserProvider).clear();
    }
  }

  Future<bool> existId(String? userId) async =>
      _signUpRepository.existId(userId);

  late final UserRegRequestRepository _signUpRepository;
}

final signUpProvider = AsyncNotifierProvider<UserRegBloc, void>(
  () => UserRegBloc(),
);
final regUserProvider = StateProvider<UserDetailModel>(
  (ref) => UserDetailModel.empty(),
);
