import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/assign/api/assign_provider.dart';
import 'package:sbas/features/assign/model/asgn_doc_res_model.dart';
import 'package:sbas/features/assign/model/assign_list_model.dart';
import 'package:sbas/features/assign/model/available_hospital_model.dart';

class AssignRepository {
  Future<List<AssignListModel>> lookupPatientInfo() async => (await _asgnProvider.lookupPatientInfo()).map((e) => AssignListModel.fromJson(e)).toList();

  Future<AvailableHospitalModel> getAvalHospList(String ptId, int bdasSeq) async => await _asgnProvider.getAvalHospList(ptId, bdasSeq);
  Future<dynamic> postReqConfirm(Map<String, dynamic> map) async => await _asgnProvider.postReqConfirm(map);
  Future<AsgnDocRes> postDocAsgnConfirm(Map<String, dynamic> map) async => AsgnDocRes.fromJson(await _asgnProvider.posDocAsgnConfirm(map));
  Future<dynamic> reqMvApr(Map<String, dynamic> map) async => await _asgnProvider.postreqMvApr(map);

  final _asgnProvider = AssignProvider();
}

final assignRepoProvider = Provider((ref) => AssignRepository());

final patientInfoIsChangedProvider = StateProvider<bool>((ref) => false);
