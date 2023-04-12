import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/features/lookup/blocs/hospital_bed_request_bloc.dart';
import 'package:sbas/features/lookup/views/widgets/hospital_bed_request_nav_item.dart';

class HospitalBedRequestNav extends ConsumerWidget {
  HospitalBedRequestNav({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = (256 + 64).w;

    return Stack(
      children: [
        Align(
          heightFactor: 14,
          child: Container(
            width: width,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                30,
              ),
              color: Colors.grey.shade300,
            ),
          ),
        ),
        AnimatedAlign(
          heightFactor: 14,
          alignment: Alignment(
            0.85 * ref.watch(orderOfRequestProvider),
            0,
          ),
          duration: const Duration(
            milliseconds: 500,
          ),
          child: Container(
            width: width * 0.35,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                30,
              ),
              color: Colors.lightBlue,
            ),
          ),
        ),
        for (int i = 0; i < _titles.length; i++)
          HospitalBedRequestNavItem(
            index: i + 3,
            text: _titles[i],
            x: i - 1,
          ),
      ],
    );
  }

  final _titles = [
    '감염병정보',
    '중증정보',
    '출발지정보',
  ];
}
