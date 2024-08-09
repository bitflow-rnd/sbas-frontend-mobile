import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/assign/api/assign_provider.dart';
import 'package:sbas/features/assign/model/assign_list_model.dart';
import 'package:sbas/features/assign/model/available_hospital_model.dart';

class AssignRepository {
  Future<List<AssignListModel>> lookupPatientInfo() async => (await _asgnProvider.lookupPatientInfo()).map((e) => AssignListModel.fromJson(e)).toList();

  Future<dynamic> postReqConfirm(Map<String, dynamic> map) async => await _asgnProvider.postReqConfirm(map);
  Future<dynamic> asgnBdCancel(Map<String, dynamic> map) async => await _asgnProvider.postAsgnBdCancel(map);
  Future<AvailableHospitalModel> getAvalHospList(String ptId, int bdasSeq) async => await _asgnProvider.getAvalHospList(ptId, bdasSeq);
  Future<AvailableHospitalModel> searchAvalHospList(String ptId, int bdasSeq, data) async => await _asgnProvider.searchAvalHospList(ptId, bdasSeq, data);
  Future<dynamic> postDocAsgnConfirm(Map<String, dynamic> map) async => await _asgnProvider.posDocAsgnConfirm(map);
  Future<dynamic> postAsgnHosp(Map<String, dynamic> map) async => await _asgnProvider.postAsgnHosp(map);
  Future<dynamic> reqMvApr(Map<String, dynamic> map) async => await _asgnProvider.postreqMvApr(map);

  final _asgnProvider = AssignProvider();
}

final assignRepoProvider = Provider((ref) => AssignRepository());

final patientInfoIsChangedProvider = StateProvider<bool>((ref) => false);
