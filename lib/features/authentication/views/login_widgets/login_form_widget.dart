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
            onChanged: (value) => setState(() {
              ls.formData['id'] = value;
            }),
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
              prefixIcon: Icon(
                Icons.account_circle_rounded,
                color: Palette.greyText_30,
              ),
              suffixIcon: ls.formData['id'] != null && ls.formData['id']!.isNotEmpty
                  ? IconButton(
                      splashRadius: 20.r,
                      onPressed: () => setState(() {
                        fieldId.clear();
                        ls.formData.remove('id');
                      }),
                      icon: Icon(
                        Icons.close_rounded,
                        color: Palette.greyText_30,
                      ),
                    )
                  : null,
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
            onChanged: (value) => setState(() {
              ls.formData['pw'] = value;
            }),
            onSaved: (newValue) => ls.formData['pw'] = newValue ?? '',
            decoration: InputDecoration(
              fillColor: Colors.grey[250],
              filled: true,
              counterStyle: const TextStyle(
                height: double.minPositive,
              ),
              counterText: "",
              prefixIcon: Icon(
                Icons.lock_rounded,
                color: Palette.greyText_30,
              ),
              suffixIcon: SizedBox(
                width: 100.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ls.formData['pw'] != null && ls.formData['pw']!.isNotEmpty
                        ? IconButton(
                            padding: EdgeInsets.symmetric(horizontal: 2.w), // 패딩 설정
                            constraints: const BoxConstraints(),
                            splashRadius: 15.r,
                            onPressed: () => setState(() {
                              fieldPassword.clear();
                              ls.formData.remove('pw');
                            }),
                            icon: Icon(
                              ls.formData['pw'] != null && ls.formData.isNotEmpty ? Icons.close_rounded : null,
                              color: Palette.greyText_30,
                            ),
                          )
                        : Container(),
                    IconButton(
                      padding: EdgeInsets.only(left: 10.w, right: 10.w), // 패딩 설정
                      constraints: const BoxConstraints(),
                      splashRadius: 15.r,
                      onPressed: () => setState(() => isVisibility = !isVisibility),
                      icon: Icon(
                        isVisibility ? Icons.visibility : Icons.visibility_off,
                        color: Palette.greyText_30,
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
