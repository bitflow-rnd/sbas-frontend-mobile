import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/assign/model/asgn_bed_req_model.dart';
import 'package:sbas/features/assign/repos/assign_repo.dart';
import 'package:sbas/util.dart';

class AsgnBdDocPresenter extends AsyncNotifier {
  @override
  FutureOr build() {
    asgnBdReqModel = AsgnBdReqModel();
    _assignRepository = ref.watch(assignRepoProvider);
  }

  init(String ptId, String aprvYn, int bdasSeq, int asgnReqSeq, String hospId) {
    asgnBdReqModel.ptId = ptId;
    asgnBdReqModel.aprvYn = aprvYn;
    asgnBdReqModel.bdasSeq = bdasSeq;
    asgnBdReqModel.hospId = hospId;
    asgnBdReqModel.asgnReqSeq = asgnReqSeq;
  }

// ['의료기관명', '병실', '진료과', '담당의', '연락처', '메시지'];
  void setTextByIndex(int index, String? value) {
    switch (index) {
      // case 0: //병실
      //   asgnBdReqModel.roomNm = value;
      //   break;
      case 1: //병실
        asgnBdReqModel.roomNm = value;
        break;
      case 2: //진료과
        asgnBdReqModel.deptNm = value;
        break;
      case 3:
        //담당의
        asgnBdReqModel.spclNm = value;
        break;
      case 4:
        asgnBdReqModel.chrgTelno = value;
        break;
      case 5:
        asgnBdReqModel.msg = value;
      // break;
    }
  }

  bool isValid() {
    if (asgnBdReqModel.asgnReqSeq == null || asgnBdReqModel.asgnReqSeq == -1) {
      showToast("asgnReqSeq is null");
      return false;
    }
    if (asgnBdReqModel.bdasSeq == null || asgnBdReqModel.bdasSeq == -1) {
      showToast("bdasSeq is null");
      return false;
    }
    return true;
  }

  Future<dynamic> patientToHosp() async {
    var res = await _assignRepository.postDocAsgnConfirm(asgnBdReqModel.toJson());
    return res["message"] == "배정 승인되었습니다.";
  }
}

late AssignRepository _assignRepository;
late AsgnBdReqModel asgnBdReqModel;
final asgnBdDocProvider = AsyncNotifierProvider<AsgnBdDocPresenter, void>(
  () => AsgnBdDocPresenter(),
);
