import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/features/assign/views/widgets/top_nav_item_widget.dart';

class TopNavbar extends StatefulWidget {
  const TopNavbar({super.key});

  @override
  State<TopNavbar> createState() => TopNavbarState();
}

class TopNavbarState extends State<TopNavbar> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width - 24.w;

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
            width: width * 0.19,
            height: 6.h,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.zero,
              color: Colors.blueAccent,
            ),
          ),
        ),
        const TopNavItem(
          text: '병상요청',
          x: -1,
          // width: 0.3.sw,
        ),
        const TopNavItem(
          text: '병상배정',
          x: -0.5,
          // width: 0.3.sw,
        ),
        const TopNavItem(
          text: '배차',
          // width: 0.2.sw,
          x: 0,
        ),
        const TopNavItem(
          text: '입퇴원',
          // width: 0.3.sw,
          x: 0.5,
        ),
        const TopNavItem(
          // width: 0.3.sw,
          text: '완료',
          x: 1.0,
        ),
      ],
    );
  }

  late double width;

  double x = -1;
}
