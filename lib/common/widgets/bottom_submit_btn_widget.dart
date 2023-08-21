import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';

class BottomSubmitBtn extends StatelessWidget {
  const BottomSubmitBtn({
    super.key,
    required this.text,
    required this.onPressed,
    this.mainColor = Palette.mainColor,
  });
  final String text;
  final VoidCallback? onPressed;
  final Color mainColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: 16.r,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.zero,
          ),
        ),
        disabledBackgroundColor: Palette.mainColor,
        backgroundColor: mainColor,
      ),
      child: SafeArea(
        child: Center(
          child: Text(
            text,
            style: CTS(
              fontSize: 16,
              color: mainColor == Palette.mainColor ? Palette.white : Palette.greyText_60,
            ),
          ),
        ),
      ),
    );
  }
}
