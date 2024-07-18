import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/bottom_sub_position_btn_widget.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/authentication/models/authentiate_req_model.dart';
import 'package:sbas/util.dart';
import 'package:sbas/features/authentication/blocs/user_reg_bloc.dart';
import 'package:sbas/features/authentication/repos/user_reg_req_repo.dart';

class AuthPhone extends ConsumerStatefulWidget {
  const AuthPhone({super.key});

  @override
  ConsumerState<AuthPhone> createState() => _AuthPhoneState();
}

class _AuthPhoneState extends ConsumerState<AuthPhone> {
  bool isSent = false;
  late Timer timer;
  late String authNumber = '';
  late String pNum = '';
  late String name = '';
  late int remainingTime;

  static const validTime = 180;

  @override
  void initState() {
    super.initState();
    pNum = '';
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startTimer() {
    authNumber = '';
    remainingTime = kDebugMode ? 30 : validTime;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
  }

  Future<void> authenticate() async {
    var request = AuthenticateReqModel(userNm: name, telno: pNum);

    try {
      var value = await ref.read(userRegReqProvider).sendAuthMessage(pNum);

      if (value == 200) {
        ref.read(regUserProvider).telno = pNum;
        showToast("인증번호가 발송되었습니다.");
        if (mounted) {
          setState(() => isSent = true);
        }
      } else {
        showToast("휴대폰번호를 확인해주세요.");
      }

      if (pNum.length == 11) {
        startTimer();
      }
    } catch (e) {
      showToast("인증 중 오류가 발생했습니다.");
      print(e);
    }
  }

  void onTick(Timer timer) {
    if (mounted) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          timer.cancel();
        }
      });
    } else {
      timer.cancel();
    }
  }

  Future<void> checkAuth() async {
    if (authNumber.length == 6) {
      final res = await ref.read(signUpProvider.notifier).confirm(authNumber);
      if (res['message'] == "SUCCESS") {
        final findId = await ref.read(signUpProvider.notifier).findId(
            AuthenticateReqModel(userNm: name, telno: pNum));
        if (mounted) {
          Navigator.pop(context, findId); // 여기서 String 값 반환
        }
      }
    } else {
      showToast('인증번호를 다시 입력해 주세요.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      appBar: Bitflow.getAppBar(
        '휴대폰 본인인증',
        false,
        0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Text(
                      '이름',
                      style: CTS(
                        color: Palette.textColor1,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.name,
                    onChanged: (value) => name = value,
                    decoration: InputDecoration(
                      counterText: "",
                      hintText: "이름",
                      hintStyle: CTS(
                        color: Palette.greyText_60,
                        fontSize: 13,
                      ),
                      fillColor: Colors.grey[250],
                      filled: true,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.none,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.none,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          style: BorderStyle.none,
                          color: Palette.textColor1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(Bitflow.defaultRadius),
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          style: BorderStyle.none,
                          color: Palette.textColor1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(Bitflow.defaultRadius),
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Text(
                      '전화 번호',
                      style: CTS(
                        color: Palette.textColor1,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9]'),
                            ),
                            FilteringTextInputFormatter.singleLineFormatter,
                          ],
                          onChanged: (value) => pNum = value,
                          maxLength: 11,
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: "전화 번호",
                            hintStyle: CTS(
                              color: Palette.greyText_60,
                              fontSize: 13,
                            ),
                            fillColor: Colors.grey[250],
                            filled: true,
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                style: BorderStyle.none,
                                color: Palette.textColor1,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(Bitflow.defaultRadius),
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                style: BorderStyle.none,
                                color: Palette.textColor1,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(Bitflow.defaultRadius),
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(16),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SizedBox(
                          width: 100.w,
                          child: ElevatedButton(
                            onPressed: authenticate,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(16),
                            ),
                            child: Text(
                              isSent ? '인증번호 재발송' : "전송",
                              style: CTS(
                                color: Palette.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
                    child: Text(
                      '인증번호',
                      style: CTS(
                        color: Palette.textColor1,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9]'),
                      ),
                      FilteringTextInputFormatter.singleLineFormatter,
                    ],
                    onChanged: (value) => authNumber = value,
                    maxLength: 6,
                    decoration: InputDecoration(
                      hintText: "인증번호 6자리",
                      counterText: "",
                      hintStyle: CTS(
                        color: Palette.greyText_60,
                        fontSize: 13,
                      ),
                      fillColor: Colors.grey[250],
                      filled: true,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.none,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.none,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          style: BorderStyle.none,
                          color: Palette.textColor1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(Bitflow.defaultRadius),
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          style: BorderStyle.none,
                          color: Palette.textColor1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(Bitflow.defaultRadius),
                        ),
                      ),
                      contentPadding: EdgeInsets.all(16.r),
                    ),
                  ),
                  Row(children: [
                    Container(
                      margin: EdgeInsets.only(top: 8.h),
                      child: Text('유효시간 ${format(remainingTime)}',
                          style: CTS(
                            color: Colors.red,
                            fontSize: 11,
                          )),
                    ),
                  ]),
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
            Container(
              color: Palette.mainColor,
              child: SafeArea(
                child: BottomPositionedSubmitButton(
                  text: '확인',
                  function: checkAuth,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
