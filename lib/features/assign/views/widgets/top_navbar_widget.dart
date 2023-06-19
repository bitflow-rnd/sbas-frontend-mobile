import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/assign/views/widgets/top_nav_item_widget.dart';

class TopNavbar extends StatelessWidget {
  const TopNavbar({
    super.key,
    required this.x,
    required this.list,
  });
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 24.w;

    return Stack(
      children: [
        AnimatedAlign(
          heightFactor: 9,
          alignment: Alignment(
            x,
            0,
          ),
          duration: const Duration(
            milliseconds: 200,
          ),
          child: Container(
            width: width * 0.17.w,
            height: 6.h,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.zero,
              color: Palette.mainColor,
            ),
          ),
        ),
        TopNavItem(
          text: '병상요청',
          x: -1.0,
          width: width,
          isSelected: x == -1.0,
          count: list[0],
        ),
        TopNavItem(
          text: '병상배정',
          x: -0.5,
          width: width,
          isSelected: x == -0.5,
          count: list[1],
        ),
        TopNavItem(
          text: '이송',
          x: 0,
          width: width,
          isSelected: x == 0,
          count: list[2],
        ),
        TopNavItem(
          text: '입퇴원',
          x: 0.5,
          width: width,
          isSelected: x == 0.5,
          count: list[3],
        ),
        TopNavItem(
          text: '완료',
          x: 1.0,
          width: width,
          isSelected: x == 1.0,
          count: list[4],
        ),
      ],
    );
  }

  final double x;
  final List<int> list;
}
