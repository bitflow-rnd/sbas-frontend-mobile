import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/features/lookup/models/patient_history_model.dart';
import 'package:sbas/features/lookup/views/widgets/bed_assign_history_card.dart';
import 'package:sbas/features/patient/models/patient_model.dart';

Widget bdasHistoryList(PatientHistoryList history, Patient patient) {
  if (history.count != 0) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (PatientHistoryModel i in history.items)
            BedAssignHistoryCardItem(
              item: i,
              patient: patient,
            ),
        ],
      ),
    );
  } else {
    return Column(
      children: [
        SizedBox(height: 100.h),
        Image.asset(
          'assets/lookup/history_icon.png',
          height: 128.h,
        ),
        const AutoSizeText(
          '병상 배정 이력이 없습니다.',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          maxLines: 1,
          maxFontSize: 22,
        ),
      ],
    );
  }
}