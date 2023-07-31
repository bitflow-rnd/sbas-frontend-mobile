import 'package:flutter/material.dart';
import 'package:sbas/features/lookup/models/patient_model.dart';

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
    return gndr ?? '';
  }

  String getPhoneNum() {
    return mpno?.replaceRange(3, 3, '-').replaceRange(8, 8, '-') ?? '';
  }

  String getAddr() {
    if (bascAddr == null) return "";
    List<String> addrList = bascAddr!.split(" ");
    int index = addrList.indexWhere((element) => element.endsWith("구"));

    if (index != -1) {
      String res = '';
      for (int i = 0; i < index + 1; i++) {
        res += "${addrList[i]} ";
      }
      return res;
    } else {
      return "";
    }
  }
}
