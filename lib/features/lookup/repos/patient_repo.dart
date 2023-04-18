import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/features/lookup/models/patient_info_model.dart';
import 'package:sbas/features/lookup/providers/patient_provider.dart';
import 'package:sbas/util.dart';

class PatientRepository {
  Future<PatientInfoModel> lookupPatientInfo() async =>
      PatientInfoModel.fromJson(await _patientProvider.lookupPatientInfo());

  Future<dynamic> registerPatientInfo(Map<String, dynamic> map) async =>
      await _patientProvider.registerPatientInfo(toJson(map));

  Future<dynamic> registerDiseaseInfo(Map<String, dynamic> map) async =>
      await _patientProvider.registerDiseaseInfo(toJson(map));

  Future<dynamic> amendPatientInfo(String id, Map<String, dynamic> map) async =>
      await _patientProvider.amendPatientInfo(id, toJson(map));

  Future<dynamic> getAllocationHistory(String id) async =>
      await _patientProvider.getAllocationHistory(id);

  Future<dynamic> getEpidemiologicalReport(String attcId) async =>
      await _patientProvider.getEpidemiologicalReport(attcId);

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
late String attcId;
