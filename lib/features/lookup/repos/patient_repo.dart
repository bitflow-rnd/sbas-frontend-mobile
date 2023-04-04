import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/features/lookup/providers/patient_provider.dart';

class PatientRepository {
  Future<Map<String, dynamic>> getOpticalCharacterRecognition(
    XFile image,
  ) async =>
      await _patientProvider.upldepidreport(
        await MultipartFile.fromFile(
          image.path,
          filename: image.name,
        ),
      );
  final _patientProvider = PatientProvider();
}

final patientRepoProvider = Provider(
  (ref) => PatientRepository(),
);
