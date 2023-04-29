import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sbas/features/lookup/models/patient_info_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';

class PatientLookupBloc extends AsyncNotifier<PatientInfoModel> {
  @override
  FutureOr<PatientInfoModel> build() async {
    _patientRepository = ref.read(patientRepoProvider);

    return await refresh() ?? await _patientRepository.lookupPatientInfo();
  }

  Future<PatientInfoModel?> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _patientRepository.lookupPatientInfo();
    });
    if (state.hasError) {}
    return state.hasValue ? state.value : null;
  }

  late final PatientRepository _patientRepository;
}

Color? getStateColor(bool backgroudColor, String? code) {
  switch (code) {
    case 'BAST0001':
      return backgroudColor ? const Color(0x1C00FF00) : const Color(0xFF00FF00);
    case 'BAST0002':
      return backgroudColor ? const Color(0x1C0000FF) : const Color(0xFF0000FF);
    case 'BAST0003':
      return backgroudColor ? const Color(0x1C00BFFF) : const Color(0xFF00BFFF);
    case 'BAST0004':
      return backgroudColor ? const Color(0x1C000080) : const Color(0xFF000080);
    case 'BAST0005':
      return backgroudColor ? const Color(0x1C696969) : const Color(0xFF696969);
  }
  return backgroudColor ? const Color(0x1CFFFF00) : const Color(0xFFFFFF00);
}

int getAge(Patient? patient) {
  final birth = int.tryParse(patient?.rrno1?.substring(0, 2) ?? '') ?? 0;

  final year = (int.tryParse(patient?.rrno2 ?? '') ?? 0) > 2 ? 2000 : 1900;

  return DateTime.now().year - year - birth + 1;
}

String getConvertPatientInfo(int index, Patient patient) {
  String text = '';

  switch (index) {
    case 0:
      text = patient.ptNm ?? '';
      break;

    case 1:
      text = '${patient.rrno1}-${patient.rrno2}******';
      break;

    case 2:
      text = patient.addr ?? '';
      break;

    case 3:
      text = patient.dethYn == 'Y' ? '사망' : '생존';
      break;

    case 4:
      text = patient.natiCd == 'KR' ? '대한민국' : (patient.natiCd ?? '');
      break;

    case 5:
      text = patient.mpno?.replaceRange(3, 3, '-').replaceRange(8, 8, '-') ?? '';
      break;

    case 6:
      final length = patient.telno?.length ?? 0;

      if (length > 0) {
        text = patient.telno?.replaceRange(length - 4, length - 4, '-').replaceRange(length - 7, length - 7, '-') ?? '';
      } else {
        text = '';
      }
      break;

    case 7:
      text = patient.nokNm ?? '';
      break;

    case 8:
      text = patient.job ?? '';
      break;

    case 9:
      text = '기저질환';
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

String getDateTimeFormat(String? dt) {
  final dateTime = DateTime.tryParse(dt ?? '')?.add(
    const Duration(
      hours: 9,
    ),
  );
  return DateFormat('yyyy년 MM월 dd일 HH시 mm분').format(dateTime ?? DateTime.now());
}

final patientLookupProvider = AsyncNotifierProvider<PatientLookupBloc, PatientInfoModel>(
  () => PatientLookupBloc(),
);
