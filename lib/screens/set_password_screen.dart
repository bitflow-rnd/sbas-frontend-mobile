import 'package:flutter/material.dart';
import 'package:sbas/common/bitflow_theme.dart';

class SetPasswordScreen extends StatelessWidget {
  const SetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Bitflow.getAppBar(
        '비밀번호 재설정',
        false,
      ),
      body: Column(
        children: const [],
      ),
    );
  }
}
