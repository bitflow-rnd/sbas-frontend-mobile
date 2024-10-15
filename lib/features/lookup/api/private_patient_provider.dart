import 'package:dio/dio.dart';
import 'package:sbas/common/api/v1_provider.dart';
import 'package:sbas/features/lookup/models/origin_info_model.dart';
import 'package:sbas/features/patient/models/patient_list_model.dart';
import 'package:sbas/features/patient/models/patient_model.dart';
import 'package:sbas/features/lookup/models/patient_timeline_model.dart';
import 'package:sbas/util.dart';
import 'package:sbas/features/lookup/models/patient_disease_info_model.dart';
import 'package:sbas/features/lookup/models/patient_history_model.dart';

class PrivatePatientProvider {
  PatientTimelineModel? timeLine;

  Future<PatientListModel> lookupPatientInfo() async => PatientListModel.fromJson(await _api.getAsync('$_privateRoute/search'));

  Future<dynamic> registerPatientInfo(String json) async => await _api.postAsync('$_privateRoute/regbasicinfo', json);
  Future<dynamic> updatePatientInfo(String id, String json) async => await _api.postAsync('$_privateRoute/modinfo/$id', json);
  Future<Patient> getPatientInfo(String ptId) async => Patient.fromJson(await _api.getAsync('$_privateRoute/basicinfo/$ptId'));
  Future<Map<String, dynamic>> upldEpidreport(MultipartFile file) async => await _api.uploadImageFile('$_privateRoute/upldepidreport', file);
  Future<dynamic> getEpidemiologicalReport(String attcId) async => await _api.getAsync('$_privateRoute/read-epidreport/$attcId');

  Future<PatientHistoryList> getPatientHistory(String ptId) async => PatientHistoryList.fromJson(await _api.getAsync('$_privateRoute/bdasHisinfos/$ptId'));

  Future<dynamic> registerDiseaseInfo(String json) async => await _api.postAsync('$_privateRoute/regdisesinfo', json);
  Future<dynamic> postBedAssignRequest(Map<String, dynamic> map) async => await _api.postAsync('$_privateRoute/bedassignreq', toJson(map));
  Future<int> bioInfoAnlys(String json) async => await _api.postAsync('$_privateRoute/bioinfoanlys', json);

  Future<Map<String, dynamic>> postExist(Map<String, dynamic> map) async => await _api.postAsync('$_privateRoute/exist', toJson(map));

  Future<PatientDiseaseInfoModel> getDiseaseInfo(String ptId) async =>
      PatientDiseaseInfoModel.fromJson(await _api.getAsync('$_privateRoute/disease-info/$ptId'));
  Future<OriginInfoModel> getTransInfo(String ptId, int bdasSeq) async =>
      OriginInfoModel.fromJson(await _api.getAsync('$_privateRoute/transinfo/$ptId/$bdasSeq'));

  Future<PatientTimelineModel> getTimeLine(String ptId, int bdasSeq) async {
    if (timeLine == null) {
      return await reloadTimeLine(ptId, bdasSeq);
    } else {
      return timeLine!;
    }
  }

  Future<PatientTimelineModel> reloadTimeLine(String ptId, int bdasSeq) async =>
      PatientTimelineModel.fromJson(await _api.getAsync('$_privateRoute/timeline/$ptId/$bdasSeq'));

  final String _privateRoute = 'private/patient';

  final _api = V1Provider();
}
