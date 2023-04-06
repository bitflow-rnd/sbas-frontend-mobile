import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/features/authentication/repos/user_reg_req_repo.dart';
import 'package:sbas/features/lookup/models/epidemiological_report_model.dart';
import 'package:sbas/features/lookup/models/patient_reg_info_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';

class PatientRegisterPresenter extends AsyncNotifier<PatientRegInfoModel> {
  @override
  FutureOr<PatientRegInfoModel> build() {
    _patientInfoModel = PatientRegInfoModel.empty();
    _regRepository = ref.read(userRegReqProvider);
    _patientRepository = ref.read(patientRepoProvider);

    return _patientInfoModel;
  }

  Future<void> registry() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return _patientInfoModel;
    });
    if (state.hasError) {}
    if (state.hasValue) {}
  }

  Future<void> uploadImage(XFile imageFile) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final attcId = await _regRepository.uploadImage(imageFile);
      ref.read(patientAttcProvider.notifier).state = attcId;

      final report =
          EpidemiologicalReportModel.fromJson(await _patientRepository.getOpticalCharacterRecognition(imageFile));

      _patientInfoModel.addr = report.baseAddr;
      _patientInfoModel.attcId = attcId;
      _patientInfoModel.dethYn = report.dethYn;
      _patientInfoModel.gndr = report.rrno2 == '1' || report.rrno2 == '3' ? 'M' : 'F';
      _patientInfoModel.job = report.job;
      _patientInfoModel.ptNm = report.ptNm;
      _patientInfoModel.rrno1 = report.rrno1;
      _patientInfoModel.rrno2 = report.rrno2;
      _patientInfoModel.dethYn = report.dethYn == '사망' ? 'N' : 'Y';
      _patientInfoModel.dstr1Cd = report.dstr1Cd;
      _patientInfoModel.dstr2Cd = report.dstr2Cd;
      _patientInfoModel.mpno = report.telno;
      _patientInfoModel.natiCd = 'KR';

      return _patientInfoModel;
    });
    if (state.hasError) {}
    if (state.hasValue) {}
  }

  Future<void> uploadPatientGender(String gender) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      if (_patientInfoModel.rrno1 != null) {
        if (gender == 'F') {
          _patientInfoModel.rrno2 = '20'.compareTo(_patientInfoModel.rrno1!.substring(0, 2)) > 0 ? '2' : '4';
        }
        if (gender == 'M') {
          _patientInfoModel.rrno2 = '20'.compareTo(_patientInfoModel.rrno1!.substring(0, 2)) > 0 ? '1' : '3';
        }
        _patientInfoModel.gndr = gender;
      }
      return _patientInfoModel;
    });
    if (state.hasError) {}
    if (state.hasValue) {}
  }

  Future<void> updatePatientRegion(BaseCodeModel region) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      _patientInfoModel.dstr1Cd = region.id?.cdId;

      return _patientInfoModel;
    });
    if (state.hasError) {}
    if (state.hasValue) {}
  }

  Future<void> updatePatientCounty(BaseCodeModel region) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      _patientInfoModel.dstr2Cd = region.id?.cdId;

      return _patientInfoModel;
    });
    if (state.hasError) {}
    if (state.hasValue) {}
  }

  Future<void> updatePatientNationality(String nationality) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      _patientInfoModel.natiCd = nationality;

      return _patientInfoModel;
    });
    if (state.hasError) {}
    if (state.hasValue) {}
  }

  Future<void> updatePatientCrossroadsOfLife(String life) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      _patientInfoModel.dethYn = life;

      return _patientInfoModel;
    });
    if (state.hasError) {}
    if (state.hasValue) {}
  }

  String? findPatientAddress(List<BaseCodeModel> list, String? findValue) {
    if (list.any((element) => element.id?.cdId == findValue)) {
      return list.firstWhere((e) => e.id?.cdId == findValue).cdNm;
    }
    if (list.any((element) => element.cdNm == findValue)) {
      return findValue;
    }
    return null;
  }

  void setTextEditingController(int index, String? value) {
    switch (index) {
      case 0:
        _patientInfoModel.ptNm = value;
        return;

      case 1:
        _patientInfoModel.rrno1 = value;
        return;

      case 2:
        _patientInfoModel.addr = value;
        return;

      case 3:
        _patientInfoModel.dethYn = value;
        return;

      case 5:
        _patientInfoModel.mpno = value;
        return;

      case 8:
        _patientInfoModel.job = value;
        return;
    }
  }

  int? getMaxLength(int index) {
    switch (index) {
      case 0:
      case 7:
        return 7;

      case 1:
        return 6;

      case 5:
      case 6:
        return 11;

      case 4:
      case 8:
        return 9;
    }
    return null;
  }

  String getTextEditingController(
    int index,
    PatientRegInfoModel report,
  ) {
    switch (index) {
      case 0:
        return report.ptNm ?? '';

      case 1:
        return report.rrno1 ?? '';

      case 2:
        var address = '';
        final strArr = report.addr?.split(' ');

        if (strArr != null && strArr.length > 3) {
          for (int i = 2; i < strArr.length; i++) {
            address += '${strArr[i]} ';
          }
        } else {
          address = report.addr ?? '';
        }
        return address;

      case 3:
        return report.dethYn ?? '';

      case 5:
        return report.mpno ?? '';

      case 8:
        return report.job ?? '';

      default:
        return '';
    }
  }

  String? isValid(int index, String? value) {
    switch (index) {
      case 0:
        if (value == null ||
            value.length < 2 ||
            RegExp(
                  r'[\uac00-\ud7af]',
                  unicode: true,
                ).allMatches(value).length !=
                value.length) {
          return '이름을 정확히 입력하세요.';
        }
        break;

      case 1:
        if (value == null ||
            value.length != 6 ||
            !RegExp(r'^\d{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])$').hasMatch(value)) {
          return '생년월일을 정확히 입력하세요.';
        }
        break;

      case 2:
        if (value == null || value.isEmpty) {
          return '주소를 정확히 입력하세요.';
        }
        break;

      case 5:
        if (value == null || value.length != 11) {
          return '전화번호를 정확히 입력하세요.';
        }
        break;
    }
    return null;
  }

  String getRegExp(int index) {
    switch (index) {
      case 0:
      case 7:
      case 8:
        return r'[가-힝|ㄱ-ㅎ|ㆍ|ᆢ]';

      case 2:
        return r'[A-Z|a-z|0-9|()-|가-힝|ㄱ-ㅎ|ㆍ|ᆢ]';

      case 4:
        return r'[A-Z|a-z|-|가-힝|ㄱ-ㅎ|ㆍ|ᆢ]';

      case 1:
      case 5:
      case 6:
        return r'[0-9]';

      default:
        return '';
    }
  }

  TextInputType getKeyboardType(int index) {
    switch (index) {
      case 0:
      case 7:
      case 8:
        return TextInputType.text;

      case 2:
      case 4:
        return TextInputType.streetAddress;

      case 1:
      case 5:
      case 6:
        return TextInputType.number;

      default:
        return TextInputType.none;
    }
  }

  late final PatientRegInfoModel _patientInfoModel;
  late final PatientRepository _patientRepository;
  late final UserRegRequestRepository _regRepository;
}

final patientRegProvider = AsyncNotifierProvider<PatientRegisterPresenter, PatientRegInfoModel>(
  () => PatientRegisterPresenter(),
);
final patientImageProvider = StateProvider<XFile?>((ref) => null);
final patientAttcProvider = StateProvider<String?>((ref) => null);
