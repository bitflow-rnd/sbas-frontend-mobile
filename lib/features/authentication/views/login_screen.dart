import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
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
      backgroundColor: Colors.white,
      appBar: Bitflow.getAppBar(
        '',
        false,
        0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 36.w,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 36.w,
                  ),
                  child: Image.asset(
                    'assets/login_logo.png',
                    height: 168.h,
                  ),
                ),
                const LoginForm(),
                Gaps.v24,
                const SubmitButton(),
                Gaps.v20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith((states) => Palette.diabledGrey),
                      ),
                      onPressed: () => findId(context),
                      child: Text(
                        '아이디 찾기',
                        style: TextStyle(
                          fontSize: 12.h,
                          color: Palette.greyText,
                        ),
                      ),
                    ),
                    Container(
                      height: 10.h,
                      width: 1.2.w,
                      color: Palette.greyText,
                    ),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith((states) => Palette.diabledGrey),
                      ),
                      onPressed: () => setPassword(context),
                      child: Text(
                        '비밀번호 재설정',
                        style: TextStyle(
                          fontSize: 12.h,
                          color: Palette.greyText,
                        ),
                      ),
                    ),
                  ],
                ),
                Gaps.v48,
                TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith((states) => Palette.diabledGrey),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserRegisterRequestScreen(),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '사용자 등록 요청 >',
                        style: TextStyle(
                          fontSize: 12.h,
                          color: Palette.greyText,
                        ),
                      ),
                    ],
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
