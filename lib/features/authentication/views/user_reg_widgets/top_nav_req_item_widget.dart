import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/authentication/blocs/job_role_bloc.dart';

class TopNavRequestItem extends ConsumerWidget {
  const TopNavRequestItem({
    super.key,
    required this.x,
    required this.index,
    required this.text,
  });
  final double x;
  final int index;
  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width - 32;
    final position = ref.watch(regIndexProvider);

    return Align(
      heightFactor: 1,
      alignment: Alignment(x, 0),
      child: SizedBox(
        width: width * 0.3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(
            //   padding: const EdgeInsets.all(
            //     5,
            //   ),
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: position == x ? Palette.mainColor : Colors.grey,
            //   ),
            //   child: Text(
            //     index.toString(),
            //     style: const TextStyle(
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
            // Gaps.h2,
            Text(
              text,
              style: CTS.medium(
                fontSize: 13,
                color: x == position ? Colors.black : Palette.greyText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
