import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/util.dart';

class FindIdResult extends StatelessWidget {
  const FindIdResult({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Center(
              child: ShaderMask(
                shaderCallback: (bounds) => RadialGradient(
                  colors: [
                    Bitflow.myCustomMaterialColor.shade700,
                    Bitflow.myCustomMaterialColor.shade300,
                  ],
                  center: Alignment.topLeft,
                  radius: 1,
                  tileMode: TileMode.clamp,
                ).createShader(bounds),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 128,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 16.h,
            ),
            child: Text(
              '아이디 찾기 결과입니다.',
              style: CTS.bold(
                fontSize: 15,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                4.r,
              ),
              border: Border.all(
                color: Colors.grey.shade300,
                style: BorderStyle.solid,
                width: 1.5,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12.h,
              ),
              child: Text(
                id,
                style: CTS(
                  fontSize: 13,
                ),
              ),
            ),
          ),
          const Spacer(),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          0,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                      ),
                      side: const BorderSide(
                        color: Palette.mainColor,
                      ),
                      foregroundColor: Palette.backgroundColor,
                      backgroundColor: Colors.white,
                    ),
                    child: Text(
                      '로그인',
                      style: CTS(
                        fontSize: 16,
                        color: Palette.mainColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () async {
                      final result = await setPassword(context);

                      if (kDebugMode) {
                        print(result);
                      }
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          0,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                      ),
                    ),
                    child: Text(
                      '비밀번호 재설정',
                      style: CTS(
                        color: Palette.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      );

  final String id;
}
