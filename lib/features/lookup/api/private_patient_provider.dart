import 'package:sbas/common/api/v1_provider.dart';
import 'package:sbas/features/lookup/models/patient_list_model.dart';
import 'package:sbas/features/lookup/models/patient_model.dart';
import 'package:sbas/features/lookup/models/patient_timeline_model.dart';
import 'package:sbas/util.dart';

import '../models/patient_disease_info_model.dart';

class PrivatePatientProvider {
  PatientTimelineModel? timeLine;
  Future<PatientListModel> lookupPatientInfo() async => PatientListModel.fromJson(await _api.getAsync('$_privateRoute/search'));

  Future<Patient> getPatientInfo(String ptId) async => Patient.fromJson(await _api.getAsync('$_privateRoute/basicinfo?ptId=$ptId'));

  Future<dynamic> postBedAssignRequest(Map<String, dynamic> map) async => await _api.postAsync('$_privateRoute/bedassignreq', toJson(map));

  Future<dynamic> postRegOriginInfo(Map<String, dynamic> map) async => await _api.postAsync('$_privateRoute/regstrtpoint', toJson(map));

  Future<PatientDiseaseInfoModel> getDiseaseInfo(String ptId) async =>
      PatientDiseaseInfoModel.fromJson(await _api.getAsync('$_privateRoute/disease-info/$ptId'));

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
