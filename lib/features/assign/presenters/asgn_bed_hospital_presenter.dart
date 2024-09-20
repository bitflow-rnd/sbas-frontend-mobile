import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/assign/model/asgn_bed_hosp_req_model.dart';
import 'package:sbas/features/assign/repos/assign_repo.dart';
import 'package:sbas/util.dart';

class AsgnBdHospPresenter extends AsyncNotifier {
  @override
  FutureOr build() {
    asgnBdHospReq = AsgnBdHospReq();
    _assignRepository = ref.watch(assignRepoProvider);
  }

  init(String ptId, String aprvYn, int bdasSeq, int asgnReqSeq, String hospId) {
    asgnBdHospReq.ptId = ptId;
    asgnBdHospReq.bdasSeq = bdasSeq;
    asgnBdHospReq.hospId = hospId;
  }

  void setTextByIndex(int index, String? value) {
    switch (index) {
      case 1:
        asgnBdHospReq.pid = value;
        break;
      case 2: //병실
        asgnBdHospReq.roomNm = value;
        break;
      case 3: //진료과
        asgnBdHospReq.deptNm = value;
        break;
      case 4:
        //담당의
        asgnBdHospReq.spclNm = value;
        break;
      case 5:
        asgnBdHospReq.chrgTelno = value;
        break;
      case 6:
        asgnBdHospReq.msg = value;
        break;
    }
  }

  String? validate(int index, String? value) {
    switch (index) {
      case 1:
        if (value == null || value == "") {
          return "PID를 입력해주세요.";
        }
        break;
    }
    return null;
  }

  bool isValid() {
    if (asgnBdHospReq.bdasSeq == null || asgnBdHospReq.bdasSeq == -1) {
      showToast("bdasSeq is null");
      return false;
    }
    if (ref.watch(gotoTargetProvider.notifier).state == "") {
      return false;
    }

    return true;
  }

  Future<bool> aprGotoHosp() async {
    String admsStatCd = '';
    switch (ref.watch(gotoTargetProvider.notifier).state) {
      case "입원":
        admsStatCd = "IOST0001";
        break;
      case "퇴원":
        admsStatCd = "IOST0002";
        break;
      case "자택귀가":
        admsStatCd = "IOST0003";
        break;
    }
    asgnBdHospReq.admsStatCd = admsStatCd;
    var res = await _assignRepository.postAsgnHosp(asgnBdHospReq.toJson());
    try {
      if (res != null && res['isAlreadyApproved'] == false) {
        showToast(res.message!);
        return res["isAlreadyApproved"] == false;
      }
    } catch (e) {
      if (res == "check push token") {
        return true;
      }
    }
    return false;
  }
}

final gotoTargetProvider = StateProvider<String>((ref) => "");
late AssignRepository _assignRepository;
late AsgnBdHospReq asgnBdHospReq;
final asgnBdHospProvider = AsyncNotifierProvider<AsgnBdHospPresenter, void>(
  () => AsgnBdHospPresenter(),
);
