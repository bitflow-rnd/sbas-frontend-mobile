import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/top_nav_req_item_widget.dart';
import 'package:sbas/constants/palette.dart';

class TopNavbarRequest extends ConsumerWidget {
  const TopNavbarRequest({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width - 132.w;

    return Stack(
      children: [
        Align(
          heightFactor: 9,
          child: Container(
            width: width,
            height: 6.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                30,
              ),
              color: Colors.grey.shade300,
            ),
          ),
        ),
        AnimatedAlign(
          heightFactor: 9,
          alignment: const Alignment(
            // x.toDouble(),
            -1,
            0,
          ),
          duration: const Duration(
            milliseconds: 200,
          ),
          child: Container(
            width: width * 0.5,
            height: 6.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                30,
              ),
              color: Palette.mainColor,
            ),
          ),
        ),
        const TopNavRequestItem(
          x: -1,
          index: 1,
          text: '사용자정보',
        ),
        const TopNavRequestItem(
          x: 1,
          index: 2,
          text: '소속기관',
        ),
      ],
    );
  }
}
