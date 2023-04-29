import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/lookup/views/widgets/patient_reg_top_nav_item_widget.dart';

class PatientRegTopNav extends ConsumerWidget {
  const PatientRegTopNav({
    required this.items,
    required this.x,
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width * 0.5;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PatientTopNavtItem(
              position: x,
              x: 1,
              index: 1,
              text: items[0],
            ),
            PatientTopNavtItem(
              position: x,
              x: -1,
              index: 2,
              text: items[1],
            ),
          ],
        ),
        Gaps.v10,
        Stack(
          children: [
            Align(
              // heightFactor: 14,
              child: Container(
                width: width * 1.2,
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
              // heightFactor: 14,
              alignment: Alignment(
                -0.5 * x,
                0,
              ),
              duration: const Duration(
                milliseconds: 200,
              ),
              child: Container(
                width: width * 0.6,
                height: 6.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                  color: Palette.mainColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  final double x;
  final List<String> items;
}
