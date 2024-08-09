import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/assign/model/available_hospital_model.dart';
import 'package:sbas/features/assign/repos/assign_repo.dart';

class AvailableHospitalPresenter extends AsyncNotifier {
  @override
  FutureOr build() {
    _assignRepository = ref.watch(assignRepoProvider);
  }

  Future<AvailableHospitalModel> getAsync(String? ptId, int? bdasSeq) async {
    if (ptId != null && ptId.isNotEmpty && bdasSeq != null) {
      return await _assignRepository.getAvalHospList(ptId, bdasSeq);
    }
    return AvailableHospitalModel(count: 0, items: []);
  }

  Future<AvailableHospitalModel> getHospList(
    String ptId, int bdasSeq,
    List<String> ptTypeCdList,
    List<String> reqBedTypeCdList,
    List<String> svrtTypeCdList,
    List<String> equipmentList,
  ) async {
    String? ptTypeCd = ptTypeCdList.isNotEmpty ? ptTypeCdList.join(",") : null;
    String? reqBedTypeCd = reqBedTypeCdList.isNotEmpty ? reqBedTypeCdList.join(",") : null;
    String? svrtTypeCd = svrtTypeCdList.isNotEmpty ? svrtTypeCdList.join(",") : null;
    String? equipment = equipmentList.isNotEmpty ? equipmentList.join(",") : null;

    Map<String, dynamic> data = {
      'ptTypeCd': ptTypeCd,
      'reqBedTypeCd': reqBedTypeCd,
      'svrtTypeCd': svrtTypeCd,
      'equipment': equipment,
    };

    return await _assignRepository.searchAvalHospList(ptId, bdasSeq, data);
  }

  late final AssignRepository _assignRepository;
}

final availableHospitalProvider = AsyncNotifierProvider<AvailableHospitalPresenter, void>(
  () => AvailableHospitalPresenter(),
);
