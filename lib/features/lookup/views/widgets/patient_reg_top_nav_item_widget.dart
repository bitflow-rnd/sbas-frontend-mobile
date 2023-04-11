import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/constants/gaps.dart';

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
    final width = MediaQuery.of(context).size.width * 0.55;

    return Align(
      heightFactor: 1,
      alignment: Alignment(x * -0.5, 0),
      child: SizedBox(
        width: width * 0.55,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(
                5,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: x == position ? Colors.blue : Colors.grey,
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
                color: x == position ? Colors.black : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
