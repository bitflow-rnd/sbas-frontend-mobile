import 'package:sbas/common/api/v1_provider.dart';

import '../../../util.dart';
import '../model/available_hospital_model.dart';

class AssignProvider {
  Future<List<dynamic>> lookupPatientInfo() async => await _api.getAsync('$_privateRoute/list');

  Future<AvailableHospitalModel> getAvalHospList(String ptId, int bdasSeq) async =>
      AvailableHospitalModel.fromJson(await _api.getAsync('$_privateRoute/hosp-list/$ptId/$bdasSeq'));

  Future<dynamic> postReqApprove(Map<String, dynamic> map) async => await _api.postAsync('$_privateRoute/reqconfirm', toJson(map));
  Future<dynamic> postAsgnConfirm(Map<String, dynamic> map) async => await _api.postAsync('$_privateRoute/asgnconfirm', toJson(map));
  Future<dynamic> posDocAsgnConfirm(Map<String, dynamic> map) async => await _api.postAsync('$_privateRoute/asgnconfirm', toJson(map));

  final _privateRoute = 'private/bedasgn';
  final _api = V1Provider();
}
