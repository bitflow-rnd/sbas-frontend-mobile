import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/features/authentication/views/widgets/top_navbar_req_widget.dart';

class UserRegisterRequestScreen extends ConsumerWidget {
  const UserRegisterRequestScreen({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Scaffold(
      appBar: Bitflow.getAppBar(
        '사용자 등록 요청',
        true,
        1,
      ),
      body: Column(
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 32,
            ),
            child: TopNavbarRequest(),
          )
        ],
      ),
    );
  }
}
