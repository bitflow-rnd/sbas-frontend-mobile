import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/bottom_sub_position_btn_widget.dart';
import 'package:sbas/common/widgets/input_text_widget.dart';
import 'package:sbas/constants/common.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/authentication/repos/user_reg_req_repo.dart';
import 'package:sbas/features/authentication/views/set_pw_widgets/pw_input_widget.dart';

import 'authenticate_phone_screen.dart';

class SetPasswordScreen extends ConsumerStatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  ConsumerState<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends ConsumerState<SetPasswordScreen> {
  String id = '';
  bool isEqualId = false;
  String pw = '';
  String checkPw = '';
  bool isEqualPw = false;

  Future<String> modifyPw() async {
    var result = await ref.read(userRegReqProvider).modifyPw(id, pw);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      appBar: Bitflow.getAppBar(
        '비밀번호 초기화',
        false,
        0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                      ),
                      child: Text(
                        '아이디',
                        style: CTS(
                          color: Palette.textColor1,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    InputTextWidget(
                      keyboardType: TextInputType.name,
                      onChanged: (value) => setState(() {
                        id = value;
                      }),
                      hintText: '아이디',
                      readOnly: isEqualId,
                    ),
                    Gaps.v24,
                    AutoSizeText(
                      '휴대전화 번호 본인인증 후\n비밀번호를 재설정 하실 수 있습니다.',
                      maxLines: 2,
                      style: CTS(
                          color: Palette.greyText_80,
                          fontSize: 14,
                          height: 5.5 / 3.5),
                    ),
                    Gaps.v24,
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isEqualId ? null : authenticate,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                        ),
                        child: Text(
                          isEqualId ? '인증완료' : '인증하기',
                          style: CTS(
                            color: Palette.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (isEqualId)
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 24.h,
                    horizontal: 24.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '새 비밀번호를 입력해 주세요.',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Gaps.v24,
                      InputPassword(
                        label: '새 비밀번호',
                        hintText: '8~15자리의 영소문자,숫자,특수문자 조합',
                        onChanged: (value) => setState(() {
                          pw = value;
                          checkIsEqualPw();
                        }),
                      ),
                      Gaps.v16,
                      InputPassword(
                        label: '비밀번호 확인',
                        hintText: '비밀번호 확인',
                        onChanged: (value) => setState(() {
                          checkPw = value;
                          checkIsEqualPw();
                        }),
                      ),
                      if (isEqualPw)
                        Text('비밀번호가 일치합니다.', style: CTS.bold(color: Colors.red))
                      else
                        Text('비밀번호가 다릅니다.', style: CTS.bold(color: Colors.red)),
                    ],
                  ),
                ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.transparent,
                  width: double.infinity,
                ),
              ),
              BottomPositionedSubmitButton(
                function: () async {
                  final bytes = utf8.encode(pw);
                  pw = sha512.convert(bytes).toString();

                  var result = await modifyPw();

                  if(result == 'SUCCESS') {
                    print('success');
                  }
                },
                text: '비밀번호 변경',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> authenticate() async {
    final result = await Navigator.push<String?>(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthPhone(),
      ),
    );
    if (kDebugMode) {
      print(result);
    }
    if (result != null && result.isNotEmpty) {
      if (mounted) {
        setState(() => isEqualId = id == result);
      }
    }
  }

  void modifyPassword() {
    Common.showModal(
      context,
      Common.commonModal(
        context: context,
        mainText: "비밀번호가 변경되었습니다.\n변경된 비밀번호로 로그인 해 주세요.",
        imageWidget: Image.asset(
          "assets/auth_group/modal_check.png",
          width: 44.h,
        ),
        imageHeight: 44.h,
      ),
    );
  }

  void checkIsEqualPw() {
    isEqualPw = pw == checkPw;
  }
}
