import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kpostal/kpostal.dart';
import 'package:sbas/features/lookup/blocs/severely_disease_presenter.dart';
import 'package:sbas/features/lookup/models/bed_assgin_request_model.dart';
import 'package:sbas/features/lookup/models/origin_info_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';

class OriginInfoPresenter extends AsyncNotifier<OriginInfoModel> {
  @override
  FutureOr<OriginInfoModel> build() {
    _model = OriginInfoModel();
    _repository = ref.read(patientRepoProvider);

    return _model;
  }

  Future<void> registry(String ptId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      _model.ptId = ptId;

      var severelyDiseaseModel = ref.read(severelyDiseaseProvider.notifier).severelyDiseaseModel;

      // await _repository.postRegOriginInfo(_model);

      await _repository.postBedAssignRequest(BedAssignRequestModel(severelyDiseaseModel, _model));

      return _model;
    });
    if (state.hasError) {}
  }

  Future<void> setAddress(Kpostal postal) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      _model.dprtDstrBascAddr = postal.roadAddress;
      _model.dprtDstrZip = postal.postCode;

      return _model;
    });
  }

  Future<int> setOriginIndex(int index) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      _model.dprtDstrTypeCd = 'DPTP000${index + 1}';

      if (index != 1) {
        _model.inhpAsgnYn = 'N';
      }
      return _model;
    });
    if (state.hasError) {}

    return index;
  }

  Future<int> setAssignedToTheFloor(int index) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      _model.inhpAsgnYn = index == 0 ? 'N' : 'Y';

      return _model;
    });
    if (state.hasError) {}

    return index;
  }

  Future<void> selectLocalGovernment(String value) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      _model.reqDstr1Cd = value;

      return _model;
    });
  }

  Future<void> selectLocalCounty(String value) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      _model.reqDstr2Cd = value;

      return _model;
    });
  }

  String? getText(int index) {
    switch (index) {
      case 0:
        return _model.dprtDstrBascAddr;

      case 100:
        return _model.dprtDstrDetlAddr;

      case 103:
        return _model.nok1Telno;

      case 104:
        return _model.nok2Telno;

      case 105:
      //메세지
      case 1006:
        return _model.msg;

      case 1003:
        return _model.deptNm;

      case 1004:
        return _model.spclNm;

      case 1005:
        return _model.chrgTelno;
    }
    return '';
  }

  String? getHintText(int index) {
    switch (index) {
      case 0:
        return '기본 주소 입력';

      case 100:
        return '상세 주소 입력';

      case 103:
        return '보호자 1 연락처 입력';
      case 104:
        return '보호자 2 연락처 입력';
      case 105:
      case 1006:
        return '메세지 입력';
      case 1003:
        return '진료과 입력';
      case 1004:
        return '담당의 입력';
      case 1005:
        return '담당의 연락처 입력';
    }
    return '';
  }

  void onChanged(int index, String text) {
    switch (index) {
      case 100:
        _model.dprtDstrDetlAddr = text;
        break;

      case 103:
        _model.nok1Telno = text;
        break;

      case 104:
        _model.nok2Telno = text;
        break;

      case 105:
      //메세지
      case 1007:
        _model.msg = text;
        break;

      case 1003:
        _model.deptNm = text;
        break;

      case 1004:
        _model.spclNm = text;
        break;

      case 1005:
        _model.chrgTelno = text;
        break;
    }
  }

  late final PatientRepository _repository;
  late final OriginInfoModel _model;
}

final originInfoProvider = AsyncNotifierProvider<OriginInfoPresenter, OriginInfoModel>(
  () => OriginInfoPresenter(),
);
