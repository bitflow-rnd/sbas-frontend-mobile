import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/authentication/blocs/login_bloc.dart';
import 'package:sbas/features/authentication/views/login_screen.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  @override
  Widget build(BuildContext context) {
    final ls = context.findAncestorStateOfType<LogInScreenState>()!;

    return Form(
      key: ls.formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: ref.read(loginProvider.notifier).isFirebaseAuth() ? TextInputType.emailAddress : TextInputType.text,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(ref.read(loginProvider.notifier).isFirebaseAuth() ? r'[a-z|0-9|@.]' : r'[a-z|0-9]'),
              ),
              FilteringTextInputFormatter.singleLineFormatter,
            ],
            controller: fieldId,
            maxLength: ref.read(loginProvider.notifier).isFirebaseAuth() ? 32 : 15,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '아이디를 입력하세요.';
              }
              return null;
            },
            onSaved: (newValue) => ls.formData['id'] = newValue ?? '',
            decoration: InputDecoration(
              fillColor: Colors.grey[250],
              filled: true,
              counterStyle: const TextStyle(
                height: double.minPositive,
              ),
              counterText: "",
              contentPadding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 20.r),
              prefixIcon: const Icon(
                Icons.account_circle_rounded,
                color: Colors.black,
              ),
              suffixIcon: IconButton(
                splashRadius: 20.r,
                onPressed: () => setState(() {
                  fieldId.clear();
                  ls.formData.remove('id');
                }),
                icon: Icon(
                  ls.formData['id'] != null && ls.formData['id']!.isNotEmpty ? Icons.close_rounded : null,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  style: BorderStyle.none,
                  color: Palette.textColor1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(Bitflow.defaultRadius),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  style: BorderStyle.none,
                  color: Palette.textColor1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(Bitflow.defaultRadius),
                ),
              ),
              hintText: ref.read(loginProvider.notifier).isFirebaseAuth() ? '이메일' : '아이디',
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Palette.textColor1,
              ),
            ),
          ),
          Gaps.v24,
          TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-z|0-9|~!@#$%^&*()_-]'),
              ),
              FilteringTextInputFormatter.singleLineFormatter,
            ],
            maxLength: 15,
            controller: fieldPassword,
            obscureText: !isVisibility,
            validator: (value) {
              if (value == null || value.length < 9) {
                return '비밀번호를 8자 이상 입력하세요.';
              }
              return null;
            },
            onSaved: (newValue) => ls.formData['pw'] = newValue ?? '',
            decoration: InputDecoration(
              fillColor: Colors.grey[250],
              filled: true,
              counterStyle: const TextStyle(
                height: double.minPositive,
              ),
              counterText: "",
              prefixIcon: const Icon(
                Icons.lock_rounded,
                color: Colors.black,
              ),
              suffixIcon: SizedBox(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      splashRadius: 20.r,
                      onPressed: () => setState(() {
                        fieldPassword.clear();
                        ls.formData.remove('pw');
                      }),
                      icon: Icon(
                        ls.formData['pw'] != null && ls.formData.isNotEmpty ? Icons.close_rounded : null,
                      ),
                    ),
                    IconButton(
                      splashRadius: 20.r,
                      onPressed: () => setState(() => isVisibility = !isVisibility),
                      icon: Icon(
                        isVisibility ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ],
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  style: BorderStyle.none,
                  color: Palette.textColor1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(Bitflow.defaultRadius),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  style: BorderStyle.none,
                  color: Palette.textColor1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(Bitflow.defaultRadius),
                ),
              ),
              hintText: '비밀번호',
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Palette.textColor1,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 20.r),
            ),
          ),
        ],
      ),
    );
  }

  final fieldId = TextEditingController();
  final fieldPassword = TextEditingController();

  bool isVisibility = false;
}
