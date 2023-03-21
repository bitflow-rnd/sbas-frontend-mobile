import 'package:flutter/material.dart';
import 'package:sbas/features/assign/views/widgets/top_nav_item_widget.dart';

class TopNavbar extends StatefulWidget {
  const TopNavbar({super.key});

  @override
  State<TopNavbar> createState() => TopNavbarState();
}

class TopNavbarState extends State<TopNavbar> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width - 16;

    return Stack(
      children: [
        AnimatedAlign(
          heightFactor: 9,
          alignment: Alignment(
            x,
            0,
          ),
          duration: const Duration(
            milliseconds: 500,
          ),
          child: Container(
            width: width * 0.2,
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                30,
              ),
              color: Colors.lightBlue,
            ),
          ),
        ),
        const TopNavItem(
          text: '병상요청',
          x: -1,
        ),
        const TopNavItem(
          text: '병상배정',
          x: -0.5,
        ),
        const TopNavItem(
          text: '이송/배차',
          x: 0,
        ),
        const TopNavItem(
          text: '입/퇴원',
          x: 0.5,
        ),
        const TopNavItem(
          text: '완료',
          x: 1,
        ),
      ],
    );
  }

  late double width;

  double x = -1;
}
