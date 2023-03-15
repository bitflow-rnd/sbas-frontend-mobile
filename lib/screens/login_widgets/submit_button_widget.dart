import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/presenters/login_view_model.dart';
import 'package:sbas/screens/login_screen.dart';

class SubmitButton extends ConsumerStatefulWidget {
  const SubmitButton({super.key});

  @override
  ConsumerState<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends ConsumerState<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: ref.watch(loginProvider).isLoading ? null : _onSubmit,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(
          '로그인',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

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
