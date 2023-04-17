import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/features/authentication/blocs/login_bloc.dart';
import 'package:sbas/features/authentication/views/login_screen.dart';

class SubmitButton extends ConsumerStatefulWidget {
  const SubmitButton({super.key});

  @override
  ConsumerState<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends ConsumerState<SubmitButton> {
  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: ref.watch(loginProvider).isLoading ? null : _onSubmit,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9.2.r),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 15.r,
            ),
          ),
          child: const Text(
            '로그인',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      );

  void _onSubmit() {
    final ls = context.findAncestorStateOfType<LogInScreenState>()!;

    ls.tryValidation();

    final bytes = utf8.encode(ls.formData['pw'] ?? '');
    final pw = sha512.convert(bytes).toString();

    ref.read(loginProvider.notifier).logIn(
      context,
      {
        'id': ls.formData['id'],
        'pw': pw,
      },
    );
  }
}
