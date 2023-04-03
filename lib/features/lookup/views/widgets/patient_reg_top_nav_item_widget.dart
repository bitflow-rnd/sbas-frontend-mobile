import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/constants/gaps.dart';

class PatientTopNavtItem extends ConsumerWidget {
  const PatientTopNavtItem({
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
    final width = MediaQuery.of(context).size.width * 0.55;

    return Align(
      heightFactor: 1,
      alignment: Alignment(x, 0),
      child: SizedBox(
        width: width * 0.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(
                5,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: -0.5 == x ? Colors.blue : Colors.grey,
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
                color: x == -0.5 ? Colors.black : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}