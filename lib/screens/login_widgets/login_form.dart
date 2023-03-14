import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/screens/login_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    final ls = context.findAncestorStateOfType<LogInScreenState>()!;
    return Column(
      children: [
        TextFormField(
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-z|0-9]')),
            FilteringTextInputFormatter.singleLineFormatter,
          ],
          controller: fieldId,
          maxLength: 15,
          validator: (value) {
            return null;
          },
          onChanged: (value) => setState(() => ls.formData['id'] = value),
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.account_circle,
              color: Colors.black,
            ),
            suffixIcon: IconButton(
              onPressed: () => setState(() {
                fieldId.clear();
                ls.formData.remove('id');
              }),
              icon: Icon(
                ls.formData['id'] != null && ls.formData['id']!.isNotEmpty
                    ? Icons.close_rounded
                    : null,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Palette.textColor1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Palette.textColor1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            hintText: '아이디',
            hintStyle: const TextStyle(
              fontSize: 14,
              color: Palette.textColor1,
            ),
            contentPadding: const EdgeInsets.all(10),
          ),
        ),
        Gaps.v8,
        TextFormField(
          inputFormatters: [
            FilteringTextInputFormatter.allow(
                RegExp(r'[a-z|0-9|~!@#$%^&*()_-]')),
            FilteringTextInputFormatter.singleLineFormatter,
          ],
          maxLength: 15,
          controller: fieldPassword,
          obscureText: !isVisibility,
          validator: (value) {
            return null;
          },
          onChanged: (value) => setState(() => ls.formData['password'] = value),
          decoration: InputDecoration(
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
                    onPressed: () => setState(() {
                      fieldPassword.clear();
                      ls.formData.remove('password');
                    }),
                    icon: Icon(
                      ls.formData['password'] != null && ls.formData.isNotEmpty
                          ? Icons.close_rounded
                          : null,
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        setState(() => isVisibility = !isVisibility),
                    icon: Icon(
                      isVisibility ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ],
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Palette.textColor1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Palette.textColor1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            hintText: '비밀번호',
            hintStyle: const TextStyle(
              fontSize: 14,
              color: Palette.textColor1,
            ),
            contentPadding: const EdgeInsets.all(10),
          ),
        ),
      ],
    );
  }

  final fieldId = TextEditingController();
  final fieldPassword = TextEditingController();

  bool isVisibility = false;
}
