import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/authentication/views/login_widgets/login_form_widget.dart';
import 'package:sbas/features/authentication/views/login_widgets/submit_button_widget.dart';
import 'package:sbas/features/authentication/views/user_reg_req_screen.dart';
import 'package:sbas/util.dart';

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
      appBar: Bitflow.getAppBar(
        '로그인',
        false,
        0,
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
                        'assets/login_logo.png',
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
                const SubmitButton(),
                Gaps.v24,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => findId(context),
                      child: const Text(
                        '아이디 찾기',
                      ),
                    ),
                    TextButton(
                      onPressed: () => setPassword(context),
                      child: const Text(
                        '비밀번호 재설정',
                      ),
                    ),
                  ],
                ),
                Gaps.v48,
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserRegisterRequestScreen(),
                    ),
                  ),
                  child: const Text(
                    '사용자 등록 요청',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void tryValidation() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
    }
  }

  final formKey = GlobalKey<FormState>();
  final Map<String, String> formData = {};
}