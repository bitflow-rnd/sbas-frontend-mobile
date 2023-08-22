import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/lookup/models/patient_list_model.dart';
import 'package:sbas/features/lookup/models/patient_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';
import 'package:sbas/util.dart';

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
      text = '${patient.rrno1}-${patient.rrno2}******';
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
      if (patient.mpno != null && patient.mpno!.isNotEmpty && patient.mpno!.length == 11 && patient.mpno!.startsWith('010')) {
        text = patient.mpno?.replaceRange(3, 3, '-').replaceRange(8, 8, '-') ?? text;
      } else if (patient.mpno != null && patient.mpno!.isNotEmpty) {
        text = patient.mpno ?? text;
      } else {
        text = '-';
      }
      break;

    case 6:
      final length = patient.telno?.length ?? 0;

      if (length > 0 && patient.telno != null && (patient.telno!.length == 11 || patient.telno!.length == 10)) {
        text = patient.telno?.replaceRange(length - 4, length - 4, '-').replaceRange(length - 7, length - 7, '-') ?? text;
      } else if (patient.telno != null && patient.telno!.isNotEmpty) {
        text = patient.telno ?? text;
      } else {
        text = '-';
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
  final address = patient.addr?.split(' ');
  final phone = patient.mpno?.replaceRange(3, 3, '-').replaceRange(8, 8, '-');

  return '${patient.gndr}/${getAge(patient)}세/${address?[0]}${address?[1]}/$phone';
}

String getAddress(Patient? patient) {
  final address = patient?.addr?.split(' ');
  final phone = patient?.mpno?.replaceRange(
    3,
    7,
    '-****-',
  );
  return '${address?[0]} ${address?[1]} / $phone';
}

final patientLookupProvider = AsyncNotifierProvider<PatientLookupBloc, PatientListModel>(
  () => PatientLookupBloc(),
);
