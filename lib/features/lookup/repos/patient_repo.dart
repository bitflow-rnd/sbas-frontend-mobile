import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/features/lookup/api/private_patient_provider.dart';
import 'package:sbas/features/lookup/models/bed_assgin_request_model.dart';
import 'package:sbas/features/lookup/models/origin_info_model.dart';
import 'package:sbas/features/lookup/models/patient_disease_info_model.dart';
import 'package:sbas/features/lookup/models/patient_duplicate_check_model.dart';
import 'package:sbas/features/lookup/models/patient_list_model.dart';
import 'package:sbas/features/patient/models/patient_model.dart';
import 'package:sbas/features/lookup/models/patient_timeline_model.dart';
import 'package:sbas/features/lookup/providers/patient_provider.dart';
import 'package:sbas/util.dart';
import 'package:sbas/features/lookup/models/patient_history_model.dart';

class PatientRepository {
  Future<PatientListModel> lookupPatientInfo() async =>
      await _privatePatientProvider.lookupPatientInfo();

  Future<Patient> getPatientInfo(String ptId) async =>
      await _privatePatientProvider.getPatientInfo(ptId);

  Future<PatientHistoryList> getPatientHistory(String ptId) async =>
      await _privatePatientProvider.getPatientHistory(ptId);

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

  Future<dynamic> postBedAssignRequest(BedAssignRequestModel model) async =>
      await _privatePatientProvider.postBedAssignRequest(
        model.toJson(),
      );

  Future<dynamic> postRegOriginInfo(OriginInfoModel model) async =>
      await _privatePatientProvider.postRegOriginInfo(
        model.toJson(),
      );

  Future<Map<String, dynamic>> postExist(PatientDuplicateCheckModel model) async =>
      await _privatePatientProvider.postExist(
        model.toJson(),
      );

  Future<PatientDiseaseInfoModel> getDiseaseInfo(String ptId) async =>
      await _privatePatientProvider.getDiseaseInfo(
        ptId,
      );

  Future<OriginInfoModel> getTransferInfo(String ptId, int bdasSeq) async =>
      await _privatePatientProvider.getTransInfo(ptId, bdasSeq);

  Future<PatientTimelineModel> getTimeLine(String ptId, int bdasSeq) async =>
      await _privatePatientProvider.getTimeLine(ptId, bdasSeq);

  final _patientProvider = PatientProvider();
  final _privatePatientProvider = PrivatePatientProvider();
}

final patientRepoProvider = Provider(
  (ref) => PatientRepository(),
);
late String attcId;
