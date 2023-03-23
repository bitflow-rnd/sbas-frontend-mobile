import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/bottom_submit_btn_widget.dart';
import 'package:sbas/features/authentication/views/widgets/reg_input_widget.dart';
import 'package:sbas/features/authentication/views/widgets/top_navbar_req_widget.dart';

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
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: Column(
                    children: const [
                      RegInput(
                        hintText: '사용하실 아이디를 입력하세요.',
                        title: '아이디',
                        isRequired: true,
                        maxLength: 15,
                        keyboardType: TextInputType.text,
                      ),
                      RegInput(
                        hintText: '본인 이름을 입력하세요.',
                        title: '이름',
                        isRequired: true,
                        maxLength: 7,
                        keyboardType: TextInputType.name,
                      ),
                      RegInput(
                        hintText: '본인 생년월일 8자리를 입력하세요.',
                        title: '생년월일',
                        isRequired: true,
                        maxLength: 8,
                        keyboardType: TextInputType.number,
                      ),
                      RegInput(
                        hintText: '휴대전화번호 11자리를 입력하세요.',
                        title: '휴대전화번호',
                        isRequired: false,
                        maxLength: 11,
                        keyboardType: TextInputType.phone,
                      ),
                      RegInput(
                        hintText: '인증번호 6자리를 입력하세요.',
                        title: '인증번호',
                        isRequired: false,
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
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
                    child: const BottomSubmitBtn(
                      func: null,
                      text: '이전',
                    ),
                  ),
                  SizedBox(
                    width: width * 0.5,
                    child: BottomSubmitBtn(
                      func: () {},
                      text: '다음',
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

  double x = -1;
}
