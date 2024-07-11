import 'package:sbas/common/api/v1_provider.dart';
import 'package:sbas/features/lookup/models/origin_info_model.dart';
import 'package:sbas/features/lookup/models/patient_list_model.dart';
import 'package:sbas/features/lookup/models/patient_model.dart';
import 'package:sbas/features/lookup/models/patient_timeline_model.dart';
import 'package:sbas/util.dart';

import 'package:sbas/features/lookup/models/patient_disease_info_model.dart';
import 'package:sbas/features/lookup/models/patient_history_model.dart';

class PrivatePatientProvider {
  PatientTimelineModel? timeLine;
  Future<PatientListModel> lookupPatientInfo() async => PatientListModel.fromJson(await _api.getAsync('$_privateRoute/search'));

  Future<Patient> getPatientInfo(String ptId) async => Patient.fromJson(await _api.getAsync('$_privateRoute/basicinfo/$ptId'));
  Future<PatientHistoryList> getPatientHistory(String ptId) async => PatientHistoryList.fromJson(await _api.getAsync('$_privateRoute/bdasHisinfos/$ptId'));

  Future<dynamic> postRegOriginInfo(Map<String, dynamic> map) async => await _api.postAsync('$_privateRoute/regstrtpoint', toJson(map));

  Future<dynamic> postBedAssignRequest(Map<String, dynamic> map) async => await _api.postAsync('$_privateRoute/bedassignreq', toJson(map));

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
