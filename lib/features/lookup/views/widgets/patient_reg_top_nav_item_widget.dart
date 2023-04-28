import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';

class PatientTopNavtItem extends ConsumerWidget {
  const PatientTopNavtItem({
    required this.position,
    super.key,
    required this.x,
    required this.index,
    required this.text,
  });
  final double x, position;
  final int index;
  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width * 0.6;

    return Align(
      heightFactor: 1,
      alignment: Alignment(x * -0.5, 0),
      child: SizedBox(
        width: width * 0.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(
            //   padding: const EdgeInsets.all(
            //     5,
            //   ),
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: x == position ? Palette.mainColor : Colors.grey,
            //   ),
            //   child: Text(
            //     index.toString(),
            //     style: CTS(
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
            // Gaps.h2,
            Text(
              text,
              style: CTS.medium(
                fontSize: 13,
                color: x == position ? Colors.black : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
