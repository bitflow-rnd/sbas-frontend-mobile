import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/features/lookup/api/private_patient_provider.dart';
import 'package:sbas/features/lookup/models/origin_info_model.dart';
import 'package:sbas/features/lookup/models/patient_list_model.dart';
import 'package:sbas/features/lookup/models/patient_model.dart';
import 'package:sbas/features/lookup/providers/patient_provider.dart';
import 'package:sbas/util.dart';

class PatientRepository {
  Future<PatientListModel> lookupPatientInfo() async =>
      await _privatePatientProvider.lookupPatientInfo();

  Future<Patient> getPatientInfo(String ptId) async =>
      await _privatePatientProvider.getPatientInfo(ptId);

  Future<dynamic> registerPatientInfo(Map<String, dynamic> map) async =>
      await _patientProvider.registerPatientInfo(
        toJson(map),
      );
  Future<dynamic> registerDiseaseInfo(Map<String, dynamic> map) async =>
      await _patientProvider.registerDiseaseInfo(
        toJson(map),
      );
  Future<dynamic> amendPatientInfo(String id, Map<String, dynamic> map) async =>
      await _patientProvider.amendPatientInfo(
        id,
        toJson(map),
      );
  Future<dynamic> getAllocationHistory(String id) async =>
      await _patientProvider.getAllocationHistory(
        id,
      );
  Future<dynamic> getEpidemiologicalReport(String attcId) async =>
      await _patientProvider.getEpidemiologicalReport(
        attcId,
      );
  Future<int> bioinfoanlys(Map<String, dynamic> map) async =>
      await _patientProvider.bioinfoanlys(
        toJson(map),
      );
  Future<dynamic> regBioInfo(Map<String, dynamic> map) async =>
      await _patientProvider.regBioInfo(
        toJson(map),
      );
  Future<dynamic> regSevrInfo(Map<String, dynamic> map) async =>
      await _patientProvider.regSevrInfo(
        toJson(map),
      );
  Future<Map<String, dynamic>> getOpticalCharacterRecognition(
    XFile image,
  ) async =>
      await _patientProvider.upldepidreport(
        await MultipartFile.fromFile(
          image.path,
          filename: image.name,
        ),
      );
  Future<dynamic> postRegOriginInfo(OriginInfoModel model) async =>
      await _privatePatientProvider.postRegOriginInfo(
        model.toJson(),
      );
  final _patientProvider = PatientProvider();
  final _privatePatientProvider = PrivatePatientProvider();
}

final patientRepoProvider = Provider(
  (ref) => PatientRepository(),
);
late String attcId;
