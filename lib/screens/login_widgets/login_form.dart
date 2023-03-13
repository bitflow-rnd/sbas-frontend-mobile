import 'package:flutter/material.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.account_circle,
                color: Colors.black,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Palette.textColor1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(35),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Palette.textColor1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(35),
                ),
              ),
              hintText: '아이디',
              hintStyle: TextStyle(
                fontSize: 14,
                color: Palette.textColor1,
              ),
              contentPadding: EdgeInsets.all(10),
            ),
          ),
          Gaps.v8,
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.lock_rounded,
                color: Colors.black,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Palette.textColor1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(35),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Palette.textColor1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(35),
                ),
              ),
              hintText: '비밀번호',
              hintStyle: TextStyle(
                fontSize: 14,
                color: Palette.textColor1,
              ),
              contentPadding: EdgeInsets.all(10),
            ),
          ),
        ],
      ),
    );
  }
}
