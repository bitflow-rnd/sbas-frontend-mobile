import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/patient/models/patient_list_model.dart';
import 'package:sbas/features/patient/models/patient_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';

class PatientLookupBloc extends AsyncNotifier<PatientListModel> {
  @override
  FutureOr<PatientListModel> build() async {
    _patientRepository = ref.read(patientRepoProvider);

    return await refresh() ?? await _patientRepository.lookupPatientInfo();
  }

  Future<PatientListModel?> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _patientRepository.lookupPatientInfo();
    });
    if (state.hasError) {}
    return state.hasValue ? state.value : null;
  }

  late final PatientRepository _patientRepository;
}

String getConvertPatientInfo(int index, Patient patient) {
  String text = '-';

  switch (index) {
    case 0:
      text = patient.ptNm ?? text;
      break;

    case 1:
      text = '${patient.rrno1}-${patient.rrno2?[0]}******';
      break;

    case 2:
      if (patient.bascAddr == null && patient.detlAddr == null) {
        text = '-';
        break;
      } else if (patient.bascAddr == null) {
        text = patient.detlAddr ?? '-';
        break;
      } else if (patient.detlAddr == null) {
        text = patient.bascAddr ?? '-';
        break;
      }
      text = '${patient.bascAddr} ${patient.detlAddr}';
      break;

    case 3:
      text = patient.dethYn == 'Y' ? '사망' : '생존';
      break;

    case 4:
      text = patient.natiNm ?? (patient.natiCd == 'NATI0001' ? '대한민국' : text);
      break;

    case 5:
      if (patient.mpno != null &&
          patient.mpno!.isNotEmpty &&
          patient.mpno!.length == 11 &&
          patient.mpno!.startsWith('010')) {
        text = patient.mpno?.replaceRange(3, 3, '-').replaceRange(8, 8, '-') ??
            text;
      } else if (patient.mpno != null && patient.mpno!.isNotEmpty) {
        text = patient.mpno ?? text;
      } else {
        text = '-';
      }
      break;

    case 6:
      var telno = patient.telno;

      if (telno == null || telno.isEmpty) {
        text = '-';
      } else {
        text = telno.replaceFirstMapped(RegExp(r'^(02|\d{3})(\d{3,4})(\d{4})$'),
            (match) => '${match[1]}-${match[2]}-${match[3]}');
      }

      break;

    case 7:
      text = patient.nokNm ?? text;
      break;

    case 8:
      text = patient.job ?? text;
      break;

    case 9:
      text = '-';
      break;
  }
  return text;
}

String getPatientInfo(Patient patient) {
  final address = patient.bascAddr?.split(' ');
  // final phone = patient.mpno?.replaceRange(3, 3, '-').replaceRange(8, 8, '-');
  // final phone;
  // if (patient.mpno != null && patient.mpno!.isNotEmpty && patient.mpno!.length == 11 && patient.mpno!.startsWith('010')) {
  //   phone = patient.mpno?.replaceRange(3, 3, '-').replaceRange(8, 8, '-');
  // } else if (patient.mpno != null && patient.mpno!.isNotEmpty) {
  //   phone = patient.mpno ?? '-';
  // } else {
  //   phone = '-';
  // }

  // return '${patient.gndr} / ${patient.age}세 / ${address?[0]} ${address?[1]} / $phone';
  return '${patient.gndr} / ${patient.age}세 / ${address?[0]} ${address?[1]}';
}

final patientLookupProvider =
    AsyncNotifierProvider<PatientLookupBloc, PatientListModel>(
  () => PatientLookupBloc(),
);
final patientProgressProvider = StateProvider.autoDispose<int>((ref) => 0);