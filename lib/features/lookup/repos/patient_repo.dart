import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/features/lookup/api/private_patient_provider.dart';
import 'package:sbas/features/lookup/models/bed_assgin_request_model.dart';
import 'package:sbas/features/lookup/models/origin_info_model.dart';
import 'package:sbas/features/lookup/models/patient_disease_info_model.dart';
import 'package:sbas/features/lookup/models/patient_duplicate_check_model.dart';
import 'package:sbas/features/lookup/models/patient_history_model.dart';
import 'package:sbas/features/lookup/models/patient_timeline_model.dart';
import 'package:sbas/features/patient/models/patient_list_model.dart';
import 'package:sbas/features/patient/models/patient_model.dart';
import 'package:sbas/util.dart';

class PatientRepository {
  Future<PatientListModel> lookupPatientInfo() async =>
      await _privatePatientProvider.lookupPatientInfo();

  Future<Patient> getPatientInfo(String ptId) async =>
      await _privatePatientProvider.getPatientInfo(ptId);

  Future<PatientHistoryList> getPatientHistory(String ptId) async =>
      await _privatePatientProvider.getPatientHistory(ptId);

  Future<dynamic> registerPatientInfo(Map<String, dynamic> map) async =>
      await _privatePatientProvider.registerPatientInfo(
        toJson(map),
      );

  Future<dynamic> registerDiseaseInfo(Map<String, dynamic> map) async =>
      await _privatePatientProvider.registerDiseaseInfo(
        toJson(map),
      );

  Future<dynamic> updatePatientInfo(String id, Map<String, dynamic> map) async =>
      await _privatePatientProvider.updatePatientInfo(
        id,
        toJson(map),
      );

  Future<dynamic> getEpidemiologicalReport(String attcId) async =>
      await _privatePatientProvider.getEpidemiologicalReport(
        attcId,
      );

  Future<int> bioinfoanlys(Map<String, dynamic> map) async =>
      await _privatePatientProvider.bioInfoAnlys(
        toJson(map),
      );

  Future<Map<String, dynamic>> upldEpidReport(
    XFile image,
  ) async =>
      await _privatePatientProvider.upldEpidreport(
        await MultipartFile.fromFile(
          image.path,
          filename: image.name,
        ),
      );

  Future<dynamic> postBedAssignRequest(BedAssignRequestModel model) async =>
      await _privatePatientProvider.postBedAssignRequest(
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

  final _privatePatientProvider = PrivatePatientProvider();
}

final patientRepoProvider = Provider(
  (ref) => PatientRepository(),
);
late String attcId;
