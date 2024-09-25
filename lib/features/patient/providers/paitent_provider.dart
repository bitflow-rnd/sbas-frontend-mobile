import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/patient/models/patient_model.dart';
import 'package:sbas/features/patient/services/patient_info_service.dart';
import 'package:sbas/features/patient/models/patient_list_model.dart';
import 'package:sbas/features/patient/services/patient_list_service.dart';

final patientProvider = FutureProvider.autoDispose.family<Patient, String?>((ref, ptId) async {
  return await PatientService().getPatient(ptId);
});

final patientService = Provider(
      (ref) => PatientService(),
);

final patientListProvider =
AsyncNotifierProvider<PatientListService, PatientListModel>(
      () => PatientListService(),
);