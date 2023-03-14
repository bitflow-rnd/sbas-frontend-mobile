import 'package:flutter/material.dart';
import 'package:sbas/screens/login_widgets/login_form.dart';

class LogInScreen extends StatefulWidget {
  @override
  State<LogInScreen> createState() => LogInScreenState();

  const LogInScreen({super.key});

  static String routeName = 'login';
  static String routeUrl = '/login';
}

class LogInScreenState extends State<LogInScreen> {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          child: Column(
            children: [
              const Icon(
                Icons.login,
              ),
              const LoginForm(),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                color: Colors.amber,
                child: const Text(
                  'recaptcha',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    '로그인',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
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
        ),
      ),
    );
  }

  final Map<String, String> formData = {};
}
