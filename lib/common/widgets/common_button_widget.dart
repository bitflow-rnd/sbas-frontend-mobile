import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';

class CommonButton extends ConsumerWidget {
  const CommonButton({
    required this.function,
    required this.text,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) => InkWell(
    onTap: function,
    child: SafeArea(
      child: Container(
        width: 150.w,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: color ?? Palette.mainColor,
          borderRadius: BorderRadius.circular(
            6.r,
          ),
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
  );
  final String text;
  final Color? color;
  final void Function() function;
}
