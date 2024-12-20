import 'package:sbas/common/api/v1_provider.dart';

import 'package:sbas/util.dart';
import 'package:sbas/features/assign/model/available_hospital_model.dart';

class AssignProvider {
  Future<List<dynamic>> lookupPatientInfo() async => await _api.getAsync('$_privateRoute/list');

  Future<AvailableHospitalModel> getAvalHospList(String ptId, int bdasSeq) async =>
      AvailableHospitalModel.fromJson(await _api.getAsync('$_privateRoute/hosp-list/$ptId/$bdasSeq'));
  Future<AvailableHospitalModel> searchAvalHospList(String ptId, int bdsaSeq, data) async =>
      AvailableHospitalModel.fromJson(await _api.getAsyncWithMap('$_privateRoute/hosp-list/$ptId/$bdsaSeq', data));

  Future<dynamic> postReqConfirm(Map<String, dynamic> map) async => await _api.postAsync('$_privateRoute/reqconfirm', toJson(map));
  Future<dynamic> posDocAsgnConfirm(Map<String, dynamic> map) async => await _api.postAsync('$_privateRoute/asgnconfirm', toJson(map));
  Future<dynamic> postAsgnHosp(Map<String, dynamic> map) async => await _api.postAsync('$_privateRoute/confirmhosptlzdiscg', toJson(map));
  Future<dynamic> postreqMvApr(Map<String, dynamic> map) async => await _api.postAsync('$_privateRoute/confirmtransf', toJson(map));
  Future<dynamic> postAsgnBdCancel(Map<String, dynamic> map) async => await _api.postAsync('$_privateRoute/asgnconfirm', toJson(map));

  final _privateRoute = 'private/bedasgn';
  final _api = V1Provider();
}
