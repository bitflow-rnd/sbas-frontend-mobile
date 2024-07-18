import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/authentication/views/find_id_screen.dart';
import 'package:sbas/util.dart';

class FindId extends StatelessWidget {
  const FindId({super.key});

  @override
  Widget build(BuildContext context) {
    final fs = context.findAncestorStateOfType<FindIdScreenState>()!;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 36.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            '휴대전화 번호 본인인증을 통해\n가입하신 아이디를 확인하실 수 있습니다.',
            maxLines: 2,
            style: CTS(color: Palette.greyText_80, fontSize: 14, height: 5.5 / 3.5),
          ),
          Gaps.v24,
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: fs.authenticate,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
              ),
              child: Text(
                '인증하기',
                style: CTS(
                  color: Palette.white,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Gaps.v16,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '비밀번호 재설정을 원하시나요?',
                style: CTS(
                  fontSize: 13,
                  color: Palette.textColor1,
                ),
              ),
              Gaps.h6,
              TextButton(
                onPressed: () async {
                  await setPassword(context);

                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  '비밀번호 재설정',
                  style: CTS.bold(
                    fontSize: 13,
                    color: Palette.primary,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}