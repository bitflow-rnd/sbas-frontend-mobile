import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/assign/model/asgn_bed_mv_apr_model.dart';
import 'package:sbas/features/assign/repos/assign_repo.dart';
import 'package:sbas/features/authentication/models/info_inst_model.dart';
import 'package:sbas/features/lookup/models/patient_disease_info_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';

class AssignBedMoveAprPresenter extends AsyncNotifier {
  @override
  FutureOr build() {
    _assignRepository = ref.read(assignRepoProvider);
    _asgnBdMvAprReq.clear();
  }

  init({String? ptId = '', int? bdasSeq = -1}) {
    _asgnBdMvAprReq.clear();
    if (ptId == '' || bdasSeq == -1) {
      return false;
    }
    _asgnBdMvAprReq.bdasSeq = bdasSeq;
    _asgnBdMvAprReq.ptId = ptId;

    return true;
  }

  Future<bool> submit() async {
    var submitRes = await _assignRepository.reqMvApr(_asgnBdMvAprReq.toJson());
    if (submitRes) {
      return false;
    }

    return false;
  }

  void changeSaftyCenter(InfoInstModel inst) {
    _asgnBdMvAprReq.instId = inst.instId;

    _asgnBdMvAprReq.ambsNm = inst.instNm;
  }

  String? setTextEditingController({required int index, String? value}) {
    switch (index) {
      case 0:
        _asgnBdMvAprReq.ambsNm = value ?? "";
        return _asgnBdMvAprReq.ambsNm ?? "";

      case 1:
        _asgnBdMvAprReq.chfTelno = value ?? "";
        _asgnBdMvAprReq.crew1Telno = value ?? ""; // TODO::디자인상 입력 필드 미존재로 수정 필요
        return _asgnBdMvAprReq.chfTelno ?? "";

      case 1000:
        _asgnBdMvAprReq.crew1Pstn = value ?? "";
        return _asgnBdMvAprReq.crew1Pstn ?? "";

      case 2000:
        _asgnBdMvAprReq.crew2Pstn = value ?? "";
        return _asgnBdMvAprReq.crew2Pstn ?? "";

      case 3000:
        _asgnBdMvAprReq.crew3Pstn = value ?? "";
        return _asgnBdMvAprReq.crew3Pstn ?? "";

      case 1001:
        _asgnBdMvAprReq.crew1Nm = value ?? "";
        return _asgnBdMvAprReq.crew1Nm ?? "";

      case 2001:
        _asgnBdMvAprReq.crew2Nm = value ?? "";
        return _asgnBdMvAprReq.crew2Nm ?? "";

      case 3001:
        _asgnBdMvAprReq.crew3Nm = value ?? "";
        return _asgnBdMvAprReq.crew3Nm ?? "";

      case 3:
        _asgnBdMvAprReq.vecno = value ?? "";
        return _asgnBdMvAprReq.vecno ?? "";
      case 4:
        _asgnBdMvAprReq.msg = value ?? "";
        return _asgnBdMvAprReq.msg ?? "";
      default:
        return "";
    }
  }

  String? getText({required int index}) {
    switch (index) {
      case 0:
        return _asgnBdMvAprReq.ambsNm ?? "";

      case 1:
        return _asgnBdMvAprReq.chfTelno ?? "";

      case 1000:
        return _asgnBdMvAprReq.crew1Pstn ?? "";

      case 2000:
        return _asgnBdMvAprReq.crew2Pstn ?? "";

      case 3000:
        return _asgnBdMvAprReq.crew3Pstn ?? "";

      case 1001:
        return _asgnBdMvAprReq.crew1Nm ?? "";

      case 2001:
        return _asgnBdMvAprReq.crew2Nm ?? "";

      case 3001:
        return _asgnBdMvAprReq.crew3Nm ?? "";
      case 3:
        return _asgnBdMvAprReq.vecno ?? "";
      case 4:
        return _asgnBdMvAprReq.msg ?? "";
      default:
        return "";
    }
  }

  String? getRegExp({required int index}) {
    switch (index) {
      case 1:
        return null;

      case 1000:
      case 2000:
      case 3000:
        return r'[가-힝|ㄱ-ㅎ|ㆍ|ᆢ]';

      case 1001:
      case 2001:
      case 3001:
        return r'[가-힝|ㄱ-ㅎ|ㆍ|ᆢ]';
      default:
        return null;
    }
  }

  final AsgnBdMvAprReq _asgnBdMvAprReq = AsgnBdMvAprReq();
  late AssignRepository _assignRepository;
}

final asgnBdMvAprPresenter = AsyncNotifierProvider<AssignBedMoveAprPresenter, void>(
  () => AssignBedMoveAprPresenter(),
);
