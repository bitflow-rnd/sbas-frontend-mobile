import 'package:sbas/common/api/v1_provider.dart';
import 'package:sbas/features/lookup/models/patient_list_model.dart';
import 'package:sbas/features/lookup/models/patient_model.dart';
import 'package:sbas/util.dart';

class PrivatePatientProvider {
  Future<PatientListModel> lookupPatientInfo() async =>
      PatientListModel.fromJson(await _api.getAsync('$_privateRoute/search'));

  Future<Patient> getPatientInfo(String ptId) async => Patient.fromJson(
      await _api.getAsync('$_privateRoute/basicinfo?ptId=$ptId'));

  Future<dynamic> postRegOriginInfo(Map<String, dynamic> map) async =>
      await _api.postAsync('$_privateRoute/regstrtpoint', toJson(map));

  final String _privateRoute = 'private/patient';

  final _api = V1Provider();
}
