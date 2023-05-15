import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/assign/api/assign_provider.dart';
import 'package:sbas/features/assign/model/assign_list_model.dart';

class AssignRepository {
  Future<AssignListModel> lookupPatientInfo(String code) async =>
      AssignListModel.fromJson(await _patientProvider.lookupPatientInfo(code));

  final _patientProvider = AssignProvider();
}

final assignRepoProvider = Provider((ref) => AssignRepository());
