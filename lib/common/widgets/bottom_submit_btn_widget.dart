import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';

class BottomSubmitBtn extends StatelessWidget {
  const BottomSubmitBtn({
    super.key,
    required this.text,
    required this.onPressed,
  });
  final String text;
  final VoidCallback? onPressed;

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
        disabledBackgroundColor: Colors.blueAccent,
        backgroundColor: Colors.blueAccent,
      ),
      child: SafeArea(
        child: Center(
          child: Text(
            text,
            style: CTS(
              fontSize: 16,
              color: Palette.white,
            ),
          ),
        ),
      ),
    );
  }
}
