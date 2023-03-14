import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/screens/login_widgets/login_form.dart';

class LogInScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<LogInScreen> createState() => LogInScreenState();

  const LogInScreen({super.key});

  static String routeName = 'login';
  static String routeUrl = '/login';
}

class LogInScreenState extends ConsumerState<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          '로그인',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  height: 175,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/logo.png',
                      ),
                    ),
                  ),
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  final Map<String, String> formData = {};
}
