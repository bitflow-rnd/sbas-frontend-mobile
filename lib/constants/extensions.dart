import 'package:flutter/material.dart';
import 'package:sbas/features/lookup/models/patient_info_model.dart';

extension TextExtension on Text {
  Center get c => Center(child: this);
}

extension PatientExtension on Patient {
  int getAge() {
    final birth = int.tryParse(rrno1?.substring(0, 2) ?? '') ?? 0;

    final year = (int.tryParse(rrno2 ?? '') ?? 0) > 2 ? 2000 : 1900;

    return DateTime.now().year - year - birth + 1;
  }

  String getSex() {
    return gndr == 'M' ? '남' : '여';
  }
}
