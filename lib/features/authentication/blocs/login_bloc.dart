import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sbas/features/authentication/models/user_model.dart';
import 'package:sbas/features/authentication/repos/login_repo.dart';
import 'package:sbas/util.dart';

class LoginBloc extends AsyncNotifier<void> {
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
        showErrorSnack(context, state.error);
      } else {
        context.go('/home');
      }
    }
  }

  String getFindId() {
    const id = 'lemon';

    if (kDebugMode) {
      print(id);
    }
    return id;
  }
}

final loginProvider = AsyncNotifierProvider<LoginBloc, void>(
  () => LoginBloc(),
);
