import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/authentication/blocs/user_reg_req_bloc.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/reg_input_widget.dart';

class SelfAuth extends ConsumerWidget {
  const SelfAuth({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        RegInput(
          hintText: '사용하실 아이디를 입력하세요.',
          title: '아이디',
          isRequired: true,
          maxLength: 15,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '아이디를 입력하세요.';
            }
            return null;
          },
          regExp: r'[a-z|0-9]',
          onSaved: (newValue) =>
              ref.read(userRegProvider.notifier).state.id = newValue,
          text: ref.watch(userRegProvider).id,
        ),
        RegInput(
          hintText: '본인 이름을 입력하세요.',
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
          onSaved: (newValue) =>
              ref.read(userRegProvider.notifier).state.userNm = newValue,
          text: ref.watch(userRegProvider).userNm,
        ),
        RegInput(
          hintText: '본인 생년월일 8자리를 입력하세요.',
          title: '생년월일',
          isRequired: true,
          maxLength: 8,
          keyboardType: TextInputType.number,
          regExp: r'[0-9]',
          validator: (value) {
            if (value == null || value.length != 8) {
              return '본인 생년월일을 정확히 입력하세요.';
            }
            return null;
          },
          onSaved: (newValue) =>
              ref.read(userRegProvider.notifier).state.btDt = newValue,
          text: ref.watch(userRegProvider).btDt,
        ),
        RegInput(
          hintText: '휴대전화번호 11자리를 입력하세요.',
          title: '휴대전화번호',
          isRequired: false,
          maxLength: 11,
          keyboardType: TextInputType.phone,
          regExp: r'[0-9]',
          validator: (value) {
            if (value == null || value.length != 11) {
              return '휴대전화번호를 정확히 입력하세요.';
            }
            return null;
          },
          onSaved: (newValue) =>
              ref.read(userRegProvider.notifier).state.telno = newValue,
          text: ref.watch(userRegProvider).telno,
        ),
        RegInput(
          hintText: '인증번호 6자리를 입력하세요.',
          title: '인증번호',
          isRequired: false,
          maxLength: 6,
          keyboardType: TextInputType.number,
          regExp: r'[0-9]',
          validator: (value) {
            if (value == null || value.length != 6) {
              return '인증번호를 정확히 입력하세요.';
            }
            return null;
          },
          onSaved: (newValue) =>
              ref.read(userRegProvider.notifier).state.userCi = newValue,
          text: ref.watch(userRegProvider).userCi,
        ),
      ],
    );
  }
}
