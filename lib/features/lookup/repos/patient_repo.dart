import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/features/lookup/providers/patient_provider.dart';
import 'package:sbas/util.dart';

class PatientRepository {
  Future<dynamic> registerPatientInfo(Map<String, dynamic> map) async =>
      await _patientProvider.registerPatientInfo(toJson(map));

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
