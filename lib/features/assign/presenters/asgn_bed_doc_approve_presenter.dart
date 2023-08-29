import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/assign/model/asgn_bed_req_model.dart';
import 'package:sbas/features/assign/repos/assign_repo.dart';

class AsgnBdDocPresenter extends AsyncNotifier {
  @override
  FutureOr build() {
    asgnBdReqModel = AsgnBdReqModel();
    _assignRepository = ref.watch(assignRepoProvider);
  }

  init(String aprvYn, int bdasSeq, int asgnReqSeq, String hospId) {
    asgnBdReqModel.aprvYn = aprvYn;
    asgnBdReqModel.bdasSeq = bdasSeq;
    asgnBdReqModel.asgnReqSeq = asgnReqSeq;
    asgnBdReqModel.hospId = hospId;
  }

// ['의료기관명', '병실', '진료과', '담당의', '연락처', '메시지'];
  void setTextEditingController(int index, String? value) {
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
    if (asgnBdReqModel.hospId == null || asgnBdReqModel.roomNm!.isEmpty) {
      return false;
    }
    if (asgnBdReqModel.asgnReqSeq == null || asgnBdReqModel.asgnReqSeq == -1) {
      return false;
    }
    if (asgnBdReqModel.bdasSeq == null || asgnBdReqModel.bdasSeq == -1) {
      return false;
    }
    return true;
  }

  Future<bool> aprvDocReq() async {
    String res = await _assignRepository.postDocAsgnConfirm(asgnBdReqModel.toJson());
    return res.contains("성공");
  }
}

late AssignRepository _assignRepository;
late AsgnBdReqModel asgnBdReqModel;
final asgnBdDocProvider = AsyncNotifierProvider<AsgnBdDocPresenter, void>(
  () => AsgnBdDocPresenter(),
);
