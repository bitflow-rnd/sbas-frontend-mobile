import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/lookup/models/epidemiological_report_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';

class HospitalBedRequestNotifier extends AsyncNotifier<EpidemiologicalReportModel> {
  @override
  FutureOr<EpidemiologicalReportModel> build() async {
    if (attcId.isNotEmpty) {
      debugPrint('HospitalBedRequest attcId >>> $attcId');
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

  final PatientRepository _patientRepository = PatientRepository();
}

final requestBedProvider = AsyncNotifierProvider<HospitalBedRequestNotifier, EpidemiologicalReportModel>(
  () => HospitalBedRequestNotifier(),
);
final orderOfRequestProvider = StateProvider.autoDispose<int>((ref) => 0);
