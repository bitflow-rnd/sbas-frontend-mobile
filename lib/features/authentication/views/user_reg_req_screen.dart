import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/bottom_submit_btn_widget.dart';
import 'package:sbas/features/authentication/blocs/user_reg_req_bloc.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/job_role_widget.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/self_auth_widget.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/top_navbar_req_widget.dart';

class UserRegisterRequestScreen extends ConsumerStatefulWidget {
  const UserRegisterRequestScreen({
    super.key,
  });

  @override
  ConsumerState<UserRegisterRequestScreen> createState() =>
      UserRegisterRequestScreenState();
}

class UserRegisterRequestScreenState
    extends ConsumerState<UserRegisterRequestScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final index = ref.watch(regIndexProvider);

    return Scaffold(
      appBar: Bitflow.getAppBar(
        '사용자 등록 요청',
        true,
        1,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          fit: StackFit.expand,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 32,
              ),
              child: TopNavbarRequest(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 96,
              ),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: _getRegIndex(index),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width * 0.5,
                    child: BottomSubmitBtn(
                      func: index < 0
                          ? null
                          : () {
                              if (_tryValidation()) {
                                ref.read(regIndexProvider.notifier).state--;
                              }
                            },
                      text: '이전',
                    ),
                  ),
                  SizedBox(
                    width: width * 0.5,
                    child: BottomSubmitBtn(
                      func: index > 1
                          ? null
                          : () {
                              if (_tryValidation()) {
                                ref.read(regIndexProvider.notifier).state++;
                              }
                            },
                      text: index == 1 ? '등록요청' : '다음',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getRegIndex(double index) {
    if (index == 0) {
      return const JobRole(
        title: [
          '소속기관 유형',
          '권한그룹 선택',
          '세부 권한 선택',
        ],
        affiliationType: [
          '보건소',
          '병상배정반',
          '의료진',
          '구급대',
          '전산담당',
        ],
      );
    }
    if (index == -1) {
      return const SelfAuth();
    }
    return const Placeholder();
  }

  bool _tryValidation() {
    bool isValid = formKey.currentState?.validate() ?? false;

    if (isValid) {
      formKey.currentState?.save();
    }
    return isValid;
  }

  final formKey = GlobalKey<FormState>();
}
