import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/lookup/views/widgets/patient_reg_top_nav_item_widget.dart';

class PatientRegTopNav extends ConsumerWidget {
  const PatientRegTopNav({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width * 0.5;

    return Stack(
      children: [
        Align(
          heightFactor: 14,
          child: Container(
            width: width * 1.25,
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
          alignment: const Alignment(
            -0.5,
            0,
          ),
          duration: const Duration(
            milliseconds: 500,
          ),
          child: Container(
            width: width * 0.65,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                30,
              ),
              color: Colors.lightBlue,
            ),
          ),
        ),
        const PatientTopNavtItem(
          x: -0.5,
          index: 1,
          text: '역학조사서',
        ),
        const PatientTopNavtItem(
          x: 0.5,
          index: 2,
          text: '환자 기본정보',
        ),
      ],
    );
  }
}
