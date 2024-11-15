import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:sbas/features/authentication/providers/user_reg_bloc.dart';
import 'package:sbas/features/authentication/views/user_reg_req_screen_v2.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/reg_input_widget.dart';

class SelfAuth extends ConsumerWidget {
  const SelfAuth({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(regUserProvider);
    String? confirmPassword;

    return Column(
      children: [
        RegInput(
          hintText: '아이디 입력',
          title: '아이디',
          isRequired: true,
          maxLength: 15,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '아이디를 입력하세요.';
            }
            if (value.length < 6) {
              return '입력하신 아이디는 사용하실 수 없습니다.';
            }
            return null;
          },
          regExp: r'[a-z|0-9]',
          onChanged: (newValue) => model.id = newValue,
          text: model.id,
        ),
        RegInput(
          hintText: '이름 입력',
          title: '이름',
          isRequired: true,
          maxLength: 7,
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value == null ||
                value.length < 2 ||
                RegExp(
                      r'[\uac00-\ud7af]',
                      unicode: true,
                    ).allMatches(value).length !=
                    value.length) {
              return '본인 이름을 정확히 입력하세요.';
            }
            return null;
          },
          regExp: r'[가-힝|ㄱ-ㅎ|ㆍ|ᆢ]',
          onChanged: (newValue) => model.userNm = newValue,
          text: model.userNm,
        ),
        RegInput(
          hintText: 'YYYY-MM-DD',
          title: '생년월일',
          isRequired: true,
          maxLength: 8,
          keyboardType: TextInputType.datetime,
          regExp: r'[0-9]',
          validator: (value) {
            if (value == null ||
                value.length != 8 ||
                DateFormat('yyyyMMdd')
                        .format(
                          DateTime.now().subtract(
                            const Duration(
                              days: 20 * 365,
                            ),
                          ),
                        )
                        .compareTo(value) <
                    0 ||
                !RegExp(r'^(19|20)\d{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])$').hasMatch(value)) {
              return '본인 생년월일을 정확히 입력하세요.';
            }
            return null;
          },
          onChanged: (newValue) {
            model.btDt = newValue;
            // TODO 성별 입력 없음, 하드 코딩
            model.gndr = '남';
          },
          text: model.btDt,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: RegInput(
                hintText: '휴대폰번호 입력',
                title: '휴대폰번호',
                isRequired: true,
                maxLength: 11,
                keyboardType: TextInputType.phone,
                regExp: r'[0-9]',
                validator: (value) {
                  if (value == null || value.length != 11 || !RegExp(r'^01([0-2])[0-9]{3,4}[0-9]{4}$').hasMatch(value)) {
                    return '휴대폰 번호를 정확히 입력하세요.';
                  }
                  return null;
                },
                onChanged: (newValue) => model.telno = newValue,
                text: model.telno,
              ),
            ),
          ],
        ),
        RegInput(
          hintText: '인증번호 6자리 입력',
          title: '인증',
          isRequired: false,
          maxLength: 6,
          keyboardType: TextInputType.number,
          regExp: r'[0-9]',
          validator: (value) {
            if (value == null || value.length != 6) {
              return '인증번호를 정확히 입력하세요.';
            }
            if (model.pushKey != null && model.pushKey!.isNotEmpty && model.pushKey?.length != 6) {
              return '인증번호가 유효하지 않습니다.';
            }
            return null;
          },
          pnumVerify: () async {
            if (model.userCi != null && model.userCi!.isNotEmpty) {

            }
          },
          onChanged: (newValue) async {
            model.userCi = newValue;
            // model.pushKey = res['statusCode'] != 200 ? res['message'] : newValue;
          },
          text: ref.watch(isPhoneAuthSuccess.notifier).state ? "인증완료" : model.pushKey,
        ),
        RegInput(
          hintText: '비밀번호 입력',
          title: '비밀번호',
          isRequired: true,
          maxLength: 15,
          keyboardType: TextInputType.visiblePassword,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '비밀번호를 입력하세요.';
            } else if (value.length < 8) {
              return '8자 이상 입력하세요.';
            } else if (!value.contains(
              RegExp(r'[a-z]'),
            )) {
              return '영문자를 입력해주세요.';
            } else if (!value.contains(
              RegExp(r'[0-9]'),
            )) {
              return '숫자를 입력해주세요.';
            } else if (!value.contains(
              RegExp(r'[~!@#$%^&*()_-]'),
            )) {
              return '특수문자를 입력해주세요.';
            }
            return null;
          },
          regExp: r'[a-zA-z|0-9|~!@#$%^&*()_-]',
          onChanged: (newValue) => model.pw = newValue,
          text: model.pw,
        ),
        RegInput(
          hintText: '비밀번호 확인',
          title: '비밀번호 확인',
          isRequired: true,
          maxLength: 15,
          keyboardType: TextInputType.visiblePassword,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '비밀번호를 입력하세요.';
            } else if (value.length < 8) {
              return '8자 이상 입력하세요.';
            } else if (!value.contains(
              RegExp(r'[a-z]'),
            )) {
              return '영문자를 입력해주세요.';
            } else if (!value.contains(
              RegExp(r'[0-9]'),
            )) {
              return '숫자를 입력해주세요.';
            } else if (!value.contains(
              RegExp(r'[~!@#$%^&*()_-]'),
            )) {
              return '특수문자를 입력해주세요.';
            } else if (model.pw != confirmPassword) {
              return '비밀번호가 일치하지 않습니다.';
            }
            return null;
          },
          regExp: r'[a-zA-Z|0-9|~!@#$%^&*()_-]',
          onChanged: (newValue) => confirmPassword = newValue,
          text: confirmPassword,
        ),
        SizedBox(height: 44.h)
      ],
    );
  }
}
