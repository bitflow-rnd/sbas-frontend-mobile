import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';

class BottomPositionedSubmitButton extends ConsumerWidget {
  const BottomPositionedSubmitButton({
    required this.function,
    required this.text,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) => Container(
        child: InkWell(
          onTap: function,
          child: SafeArea(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                vertical: 14.h,
              ),
              decoration: BoxDecoration(color: color ?? Colors.blueAccent, borderRadius: BorderRadius.zero
                  // borderRadius: BorderRadius.circular(
                  //   6.r,
                  // ),
                  ),
              child: Text(
                text,
                style: CTS.bold(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      );
  final String text;
  final Color? color;
  final void Function() function;
}
