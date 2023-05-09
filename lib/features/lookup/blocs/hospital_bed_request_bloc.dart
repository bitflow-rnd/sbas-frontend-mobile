import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/lookup/models/epidemiological_report_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';

class HospitalBedRequest extends AsyncNotifier<EpidemiologicalReportModel> {
  @override
  FutureOr<EpidemiologicalReportModel> build() async {
    _patientRepository = ref.read(patientRepoProvider);

    if (attcId.isNotEmpty) {
      try {
        return EpidemiologicalReportModel.fromJson(
          await _patientRepository.getEpidemiologicalReport(attcId),
        );
      } catch (exception) {
        if (kDebugMode) {
          print(exception);
        }
      }
    }
    return EpidemiologicalReportModel();
  }

  late final PatientRepository _patientRepository;
}

final requestBedProvider =
    AsyncNotifierProvider<HospitalBedRequest, EpidemiologicalReportModel>(
  () => HospitalBedRequest(),
);
final orderOfRequestProvider = StateProvider.autoDispose<int>((ref) => -1);
