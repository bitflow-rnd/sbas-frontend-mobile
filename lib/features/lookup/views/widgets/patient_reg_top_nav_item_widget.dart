import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/bitflow_theme.dart';

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
