import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sbas/models/user_model.dart';
import 'package:sbas/repository/login_repo.dart';
import 'package:sbas/util.dart';

class LoginViewModel extends AsyncNotifier<void> {
  late final LoginRepo _repository;

  @override
  FutureOr<void> build() async {
    _repository = ref.read(authRepo);
  }

  bool isFirebaseAuth() => _repository.isFirebaseAuth;

  Future<void> logIn(
    BuildContext context,
    Map<String, dynamic> map,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await _repository.signIn(
        UserModel.fromJson(map),
      ),
    );
    if (context.mounted) {
      if (state.hasError) {
        if (kDebugMode) {
          print(state.error);
        }
        showFirebaseErrorSnack(context, state.error);
      } else {
        context.go('/home');
      }
    }
  }
}

final loginProvider = AsyncNotifierProvider<LoginViewModel, void>(
  () => LoginViewModel(),
);
