import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/features/patient/models/patient_model.dart';
import 'package:sbas/features/patient/services/patient_info_service.dart';
import 'package:sbas/features/patient/models/patient_list_model.dart';
import 'package:sbas/features/patient/notifiers/patient_list_notifier.dart';

final patientProvider = FutureProvider.autoDispose.family<Patient, String?>((ref, ptId) async {
  return await PatientService().getPatient(ptId);
});

final patientService = Provider(
      (ref) => PatientService(),
);

final patientListProvider =
AsyncNotifierProvider<PatientListNotifier, PatientListModel>(
      () => PatientListNotifier(),
);
final patientImageProvider = StateProvider<XFile?>((ref) => null);
final patientAttcProvider = StateProvider<String?>((ref) => null);
final patientIsUploadProvider = StateProvider<bool>((ref) => true);