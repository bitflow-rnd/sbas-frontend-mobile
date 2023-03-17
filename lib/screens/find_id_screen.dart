import 'package:flutter/material.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/screens/login_widgets/find_id_widget.dart';

class FindIdScreen extends StatelessWidget {
  const FindIdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Bitflow.getAppBar(
        '아이디 찾기',
        true,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 36,
        ),
        child: FindId(),
      ),
    );
  }
}
