import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/lookup/blocs/hospital_bed_request_bloc.dart';

class HospitalBedRequestNavItem extends ConsumerWidget {
  const HospitalBedRequestNavItem({
    required this.index,
    required this.text,
    required this.x,
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(orderOfRequestProvider);

    return Align(
      heightFactor: 1,
      alignment: Alignment(x * 0.85, 0),
      child: SizedBox(
        width: ((256 + 64) * 0.35).w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(
                5,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: x == order ? Colors.blue : Colors.grey,
              ),
              child: Text(
                index.toString(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Gaps.h2,
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: x == order ? Colors.black : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final double x;
  final String text;
  final int index;
}
