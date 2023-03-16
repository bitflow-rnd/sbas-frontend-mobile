import 'package:flutter/material.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/screens/authenticate_phone_screen.dart';

class FindIdScreen extends StatelessWidget {
  const FindIdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Bitflow.getAppBar('아이디 찾기'),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 36,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AutoSizeText(
              '휴대전화 번호 본인인증을 통해\n가입하신 아이디를 확인하실 수 있습니다.',
              maxLines: 2,
              style: TextStyle(
                color: Palette.textColor1,
                fontSize: 16,
              ),
            ),
            Gaps.v24,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => authenticate(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                ),
                child: const Text(
                  '인증하기',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Gaps.v16,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '비밀번호 재설정을 원하시나요?',
                  style: TextStyle(
                    fontSize: 16,
                    color: Palette.textColor1,
                  ),
                ),
                Gaps.h6,
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    '비밀번호 재설정',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void authenticate(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthPhone(),
      ),
    );
  }
}
