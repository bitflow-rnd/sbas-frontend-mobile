import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/assign/api/assign_provider.dart';
import 'package:sbas/features/assign/model/assign_list_model.dart';
import 'package:sbas/features/assign/model/available_hospital_model.dart';

class AssignRepository {
  Future<List<AssignListModel>> lookupPatientInfo() async =>
      (await _patientProvider.lookupPatientInfo())
          .map((e) => AssignListModel.fromJson(e))
          .toList();

  Future<AvailableHospitalModel> getAvalHospList(String ptId, int bdasSeq) async =>
      await _patientProvider.getAvalHospList(ptId, bdasSeq);

  final _patientProvider = AssignProvider();
}

final assignRepoProvider = Provider((ref) => AssignRepository());
