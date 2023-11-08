import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kpostal/kpostal.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/features/authentication/blocs/agency_region_bloc.dart';
import 'package:sbas/features/lookup/blocs/infectious_disease_bloc.dart';
import 'package:sbas/features/lookup/models/severely_disease_model.dart';
import 'package:sbas/features/lookup/presenters/severely_disease_presenter.dart';
import 'package:sbas/features/lookup/models/bed_assgin_request_model.dart';
import 'package:sbas/features/lookup/models/origin_info_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';

class OriginInfoPresenter extends AsyncNotifier<OriginInfoModel> {
  @override
  FutureOr<OriginInfoModel> build() {
    _repository = ref.read(patientRepoProvider);
    return _dprtInfo;
  }

  Future<bool> orignSeverelyDiseaseRegistry(String ptId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      _dprtInfo.ptId = ptId;

      SeverelyDiseaseModel severelyDiseaseModel = ref.read(severelyDiseaseProvider.notifier).severelyDiseaseModel;

      // await _repository.postRegOriginInfo(_dprtInfo);

      var res = await _repository.postBedAssignRequest(BedAssignRequestModel(severelyDiseaseModel, _dprtInfo)); //실병상요청.
      if (res == "병상 요청 성공" || res == "check push token") {
        _dprtInfo.clear();

        ref.read(infectiousDiseaseProvider.notifier).reset();
        ref.read(severelyDiseaseProvider.notifier).reset();
      }
      return _dprtInfo;
    });
    if (state.hasError) {
      return false;
    }
    if (state.hasValue) {
      return true;
    }
    return false;
  }

  Future<void> setAddress(Kpostal postal) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      _dprtInfo.dprtDstrBascAddr = postal.roadAddress;
      _dprtInfo.dprtDstrZip = postal.postCode;

      return _dprtInfo;
    });
  }

  Future<int> setOriginIndex(int index) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      _dprtInfo.dprtDstrTypeCd = 'DPTP000${index + 1}';

      if (index != 1) {
        _dprtInfo.inhpAsgnYn = 'N';
      }
      return _dprtInfo;
    });
    if (state.hasError) {}

    return index;
  }

  Future<int> setAssignedToTheFloor(int index) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      _dprtInfo.inhpAsgnYn = index == 0 ? 'N' : 'Y';

      return _dprtInfo;
    });
    if (state.hasError) {}

    return index;
  }

  Future<void> selectLocalGovernment(BaseCodeModel baseCode) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      ref.watch(selectedRegionProvider.notifier).state = baseCode;
      _dprtInfo.reqDstr1Cd = baseCode.cdId;
      // _dprtInfo.reqDstr2Cd = value; //2 입력하는 부분이 없음..

      return _dprtInfo;
    });
  }

  Future<void> selectLocalCounty(String value) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      _dprtInfo.reqDstr2Cd = value;

      return _dprtInfo;
    });
  }

  String? getText(int index) {
    switch (index) {
      case 0:
        return _dprtInfo.dprtDstrBascAddr;

      case 100:
        return _dprtInfo.dprtDstrDetlAddr;

      case 103:
        return _dprtInfo.nok1Telno;

      case 104:
        return _dprtInfo.nok2Telno;

      case 105:
      //메시지
      case 1006:
        return _dprtInfo.msg;

      case 1003:
        return _dprtInfo.deptNm;

      case 1004:
        return _dprtInfo.spclNm;

      case 1005:
        return _dprtInfo.chrgTelno;
    }
    return null;
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
        return '메시지 입력';
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
        _dprtInfo.dprtDstrDetlAddr = text;
        break;

      case 103:
        _dprtInfo.nok1Telno = text;
        break;

      case 104:
        _dprtInfo.nok2Telno = text;
        break;

      case 105:
      //메시지
      case 1006:
        _dprtInfo.msg = text;
        break;

      case 1003:
        _dprtInfo.deptNm = text;
        break;

      case 1004:
        _dprtInfo.spclNm = text;
        break;

      case 1005:
        _dprtInfo.chrgTelno = text;
        break;
    }
  }

  bool isValid() {
    if (_dprtInfo.dprtDstrBascAddr == null || _dprtInfo.dprtDstrBascAddr!.isEmpty) {
      return false;
    }
    if (_dprtInfo.dprtDstrTypeCd == null || _dprtInfo.dprtDstrTypeCd == "") {
      return false;
    }
    if (_dprtInfo.dprtDstrTypeCd != null && _dprtInfo.dprtDstrTypeCd == "DPTP0002") {
      if (_dprtInfo.inhpAsgnYn == null || _dprtInfo.inhpAsgnYn == "") {
        return false;
      }
    }
    if (_dprtInfo.reqDstr1Cd == null || _dprtInfo.reqDstr1Cd!.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  late final PatientRepository _repository;

  final OriginInfoModel _dprtInfo = OriginInfoModel();
}

final originInfoProvider = AsyncNotifierProvider<OriginInfoPresenter, OriginInfoModel>(
  () => OriginInfoPresenter(),
);
