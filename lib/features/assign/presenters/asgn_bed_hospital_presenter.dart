import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/assign/model/asgn_bed_hosp_req_model.dart';
import 'package:sbas/features/assign/repos/assign_repo.dart';
import 'package:sbas/features/patient/models/his_sample_data.dart';
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
        hisSampleData = HisSampleDataService().getHisSampleData(asgnBdHospReq.pid);
        break;
      case 2: //병실
        if (hisSampleData != null) {
          asgnBdHospReq.roomNm = hisSampleData!.roomNm;
        } else {
          asgnBdHospReq.roomNm = value;
        }
        break;
      case 3: //진료과
        if (hisSampleData != null) {
          asgnBdHospReq.deptNm = hisSampleData!.deptNm;
        } else {
          asgnBdHospReq.deptNm = value;
        }
        break;
      case 4:
        //담당의
        if (hisSampleData != null) {
          asgnBdHospReq.spclNm = hisSampleData!.spclNm;
        } else {
          asgnBdHospReq.spclNm = value;
        }
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
          return "병원 등록번호를 입력해주세요.";
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
    var hisSampleData = HisSampleDataService().getHisSampleData(asgnBdHospReq.pid);
    if (hisSampleData != null) {
      asgnBdHospReq.deptNm = hisSampleData.deptNm;
      asgnBdHospReq.wardNm = hisSampleData.wardNm;
      asgnBdHospReq.roomNm = hisSampleData.roomNm;
      asgnBdHospReq.spclNm = hisSampleData.spclNm;
      asgnBdHospReq.monStrtDt = hisSampleData.monStrtDt;
      asgnBdHospReq.monStrtTm = hisSampleData.monStrtTm;
      asgnBdHospReq.admsDt = hisSampleData.admsDt;
    }
    print(asgnBdHospReq.toJson());
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
late HisSampleData? hisSampleData;
final asgnBdHospProvider = AsyncNotifierProvider<AsgnBdHospPresenter, void>(
  () => AsgnBdHospPresenter(),
);
