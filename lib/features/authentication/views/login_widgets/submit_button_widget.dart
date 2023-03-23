import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ),
          ),
          child: const Text(
            '로그인',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      );

  void _onSubmit() {
    final ls = context.findAncestorStateOfType<LogInScreenState>()!;

    ls.tryValidation();

    if (kDebugMode) {
      print(ls.formData);
    }
    ref.read(loginProvider.notifier).logIn(
          context,
          ls.formData,
        );
  }
}
