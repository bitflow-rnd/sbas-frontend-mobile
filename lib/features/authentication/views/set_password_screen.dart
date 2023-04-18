import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/bottom_sub_position_btn_widget.dart';
import 'package:sbas/common/widgets/bottom_submit_btn_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/authentication/views/set_pw_widgets/pw_input_widget.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      appBar: Bitflow.getAppBar(
        '비밀번호 재설정',
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
                  vertical: 24.h,
                  horizontal: 16.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '비밀번호를 재설정해주세요.',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gaps.v24,
                    InputPassword(
                      label: '새 비밀번호',
                      hintText: '8~15자리의 영소문자,숫자,특수문자 조합',
                    ),
                    Gaps.v16,
                    InputPassword(
                      label: '비밀번호 확인',
                      hintText: '비밀번호 확인',
                    ),
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
                function: () {},
                text: '비밀번호 변경',
              ),
              // const BottomSubmitBtn(
              //   text: '비밀번호 변경',
              //   onPressed: null,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
