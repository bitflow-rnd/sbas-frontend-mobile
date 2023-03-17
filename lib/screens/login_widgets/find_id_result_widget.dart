import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/util.dart';

class FindIdResult extends StatelessWidget {
  const FindIdResult({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Center(
            child: ShaderMask(
              shaderCallback: (bounds) => RadialGradient(
                colors: [
                  Colors.blue.shade700,
                  Colors.blue.shade300,
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
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 16,
            ),
            child: Text(
              '아이디 찾기 결과입니다.',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                4,
              ),
              border: Border.all(
                color: Colors.grey.shade300,
                style: BorderStyle.solid,
                width: 1.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
              ),
              child: Text(
                id,
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 18,
            ),
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
                          30,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      side: const BorderSide(
                        color: Colors.blue,
                      ),
                      foregroundColor: Colors.blue,
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      '로그인',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                Gaps.h8,
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
                          30,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                    ),
                    child: const Text(
                      '비밀번호 재설정',
                      style: TextStyle(
                        fontSize: 22,
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
