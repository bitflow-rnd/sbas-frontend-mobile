import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/features/assign/model/asgn_bed_req_model.dart';
import 'package:sbas/features/assign/repos/assign_repo.dart';
import 'package:sbas/features/authentication/repos/user_reg_req_repo.dart';

class AsgnBdCancelPresenter extends AsyncNotifier<List<BaseCodeModel>> {
  get getNegCd => _asgnBdMvAprReq.negCd;
  get getMsg => _asgnBdMvAprReq.msg;
  @override
  FutureOr<List<BaseCodeModel>> build() async {
    _asgnBdMvAprReq.clear();

    _userRegRequestRepository = ref.watch(userRegReqProvider);
    _assignRepository = ref.watch(assignRepoProvider);
    list = await _userRegRequestRepository.getBaseCode('BNRN');
    return list;
  }

  init({String? ptId = '', int? bdasSeq = -1, String? hospId = "", int? asgnReqSeq = -1}) {
    _asgnBdMvAprReq.clear();
    if (ptId == '' || bdasSeq == -1 || hospId == '' || asgnReqSeq == -1) {
      return false;
    }
    _asgnBdMvAprReq.bdasSeq = bdasSeq;
    _asgnBdMvAprReq.asgnReqSeq = asgnReqSeq;
    _asgnBdMvAprReq.ptId = ptId;
    _asgnBdMvAprReq.hospId = hospId;

    return true;
  }

  setBNRN(String code) {
    _asgnBdMvAprReq.negCd = code;
  }

  setMsg(String msg) {
    _asgnBdMvAprReq.msg = msg;
  }

  validate() {
    if (_asgnBdMvAprReq.negCd == null || _asgnBdMvAprReq.negCd == '') {
      return false;
    }

    return true;
  }

  Future<bool> asgnBdCancelPost() async {
    _asgnBdMvAprReq.aprvYn = 'N';
    var res = await _assignRepository.asgnBdCancel(_asgnBdMvAprReq.toJson());
    if (res['message'] == "배정 불가 처리되었습니다.") return true;
    _asgnBdMvAprReq.clear();
    
    return false;
  }

  late final UserRegRequestRepository _userRegRequestRepository;
  late final List<BaseCodeModel> list;
  late final AssignRepository _assignRepository;
  late final AsgnBdReqModel _asgnBdMvAprReq = AsgnBdReqModel();
}

final asgnBdCancelProvider = AsyncNotifierProvider<AsgnBdCancelPresenter, List<BaseCodeModel>>(
  () => AsgnBdCancelPresenter(),
);
