import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kpostal/kpostal.dart';
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
      _model.reqTypeCd = 'RQTP0001';

      await _repository.postRegOriginInfo(_model);

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
      } else {}
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
        return _model.msg;
    }
    return '';
  }

  String? getHintText(int index) {
    switch (index) {
      case 0:
        return '주소검색으로 입력';

      case 100:
        return '나머지 주소입력';
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
        _model.msg = text;
        break;
    }
  }

  late final PatientRepository _repository;
  late final OriginInfoModel _model;
}

final originInfoProvider =
    AsyncNotifierProvider<OriginInfoPresenter, OriginInfoModel>(
  () => OriginInfoPresenter(),
);
