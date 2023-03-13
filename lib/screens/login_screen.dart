import 'package:flutter/material.dart';
import 'package:sbas/screens/login_widgets/login_form.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '로그인',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Icon(
              Icons.login,
            ),
          ),
          const LoginForm(),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Container(
              color: Colors.amber,
              child: const Text(
                'recaptcha',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text(
              '로그인',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  '아이디 찾기',
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  '비밀번호 재설정',
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              '사용자 등록 요청',
            ),
          ),
        ],
      ),
    );
  }

  static String routeName = 'login';
  static String routeUrl = '/login';
}
