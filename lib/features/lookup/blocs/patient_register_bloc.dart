import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kpostal/kpostal.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/features/lookup/blocs/patient_info_presenter.dart';
// import 'package:sbas/features/authentication/repos/user_reg_req_repo.dart';
import 'package:sbas/features/lookup/blocs/patient_lookup_bloc.dart';
import 'package:sbas/features/lookup/models/epidemiological_report_model.dart';
import 'package:sbas/features/lookup/models/patient_model.dart';
import 'package:sbas/features/lookup/models/patient_reg_info_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';
import 'package:sbas/features/lookup/views/patient_lookup_screen.dart';

class PatientRegisterPresenter extends AsyncNotifier<PatientRegInfoModel> {
  @override
  FutureOr<PatientRegInfoModel> build() {
    _patientInfoModel = PatientRegInfoModel.empty();
    // _regRepository = ref.read(userRegReqProvider);
    _patientRepository = ref.read(patientRepoProvider);

    return _patientInfoModel;
  }

  init() {
    _patientInfoModel.clear();
    ref.watch(patientInfoIsChangedProvider.notifier).state = false;
  }

  patientInit(Patient patient) {
    _patientInfoModel.rgstUserId = patient.rgstUserId ?? "";
    _patientInfoModel.rgstDttm = patient.rgstDttm ?? "";
    _patientInfoModel.updtUserId = patient.updtUserId ?? "";
    _patientInfoModel.updtDttm = patient.updtDttm ?? "";
    _patientInfoModel.ptNm = patient.ptNm ?? "";
    _patientInfoModel.gndr = patient.gndr ?? "";
    _patientInfoModel.rrno1 = patient.rrno1 ?? "";
    _patientInfoModel.rrno2 = patient.rrno2 ?? "";
    _patientInfoModel.dstr1Cd = patient.dstr1Cd ?? "";
    _patientInfoModel.dstr2Cd = patient.dstr2Cd ?? "";
    _patientInfoModel.addr = patient.addr ?? "";
    _patientInfoModel.telno = patient.telno ?? "";
    _patientInfoModel.natiCd = patient.natiCd ?? "";
    _patientInfoModel.picaVer = patient.picaVer ?? "";
    _patientInfoModel.dethYn = patient.dethYn ?? "";
    _patientInfoModel.nokNm = patient.nokNm ?? "";
    _patientInfoModel.mpno = patient.mpno ?? "";
    _patientInfoModel.job = patient.job ?? "";
    _patientInfoModel.attcId = patient.attcId ?? "";
    _patientInfoModel.bedStatCd = patient.bedStatCd ?? "";
    _patientInfoModel.bedStatNm = patient.bedStatNm ?? "";
    _patientInfoModel.bascAddr = patient.bascAddr ?? "";
    _patientInfoModel.detlAddr = patient.detlAddr ?? "";
    _patientInfoModel.zip = patient.zip ?? "";
    _patientInfoModel.natiNm = patient.natiNm ?? "";
    _patientInfoModel.ptId = patient.ptId ?? "";
  }

  Future<void> registry(String? id, BuildContext context) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      if (id == null) {
        await _patientRepository.registerPatientInfo(_patientInfoModel.toJson());
      } else {
        await _patientRepository.amendPatientInfo(
          id,
          _patientInfoModel.toJson(),
        );
      }
      return _patientInfoModel;
    });
    if (state.hasError) {}
    if (state.hasValue) {
      //get back page
      Navigator.of(context).pop();
      Navigator.of(context).pop();

      _patientInfoModel.clear();

      ref.read(patientImageProvider.notifier).state = null;
      ref.read(patientAttcProvider.notifier).state = null;

      ref.read(patientLookupProvider.notifier).refresh();
    }
  }

  Future<void> uploadImage(XFile imageFile) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      try {
        final report = EpidemiologicalReportModel.fromJson(
          await _patientRepository.getOpticalCharacterRecognition(imageFile),
        );
        ref.read(patientAttcProvider.notifier).state = report.attcId;
        _patientInfoModel.bascAddr = report.baseAddr;
        _patientInfoModel.detlAddr = report.dtlAddr;
        _patientInfoModel.zip = report.zip;
        _patientInfoModel.attcId = report.attcId;
        _patientInfoModel.gndr = report.rrno2 == '1' || report.rrno2 == '3' ? '남' : '여';
        _patientInfoModel.job = report.job;
        _patientInfoModel.ptNm = report.ptNm;
        _patientInfoModel.rrno1 = report.rrno1;
        _patientInfoModel.rrno2 = report.rrno2;
        _patientInfoModel.dethYn = report.dethYn == '사망' ? 'Y' : 'N';
        _patientInfoModel.dstr1Cd = report.dstr1Cd;
        _patientInfoModel.dstr2Cd = report.dstr2Cd;
        _patientInfoModel.telno = report.telno; //mpn
        _patientInfoModel.mpno = report.mpno;
        _patientInfoModel.nokNm = report.nokNm;
        _patientInfoModel.natiCd = report.natiCd;
      } catch (exception) {
        if (kDebugMode) {
          print(exception);
        }
      }
      return _patientInfoModel;
    });
    if (state.hasError) {}
    if (state.hasValue) {}
  }

  Future<void> uploadPatientGender(String gender) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      if (_patientInfoModel.rrno1 != null) {
        if (gender == '여') {
          _patientInfoModel.rrno2 = '20'.compareTo(_patientInfoModel.rrno1!.substring(0, 2)) < 0 ? '2' : '4';
        }
        if (gender == '남') {
          _patientInfoModel.rrno2 = '20'.compareTo(_patientInfoModel.rrno1!.substring(0, 2)) < 0 ? '1' : '3';
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
      _patientInfoModel.dstr1Cd = region.cdId;

      return _patientInfoModel;
    });
    if (state.hasError) {}
    if (state.hasValue) {}
  }

  Future<void> updatePatientCounty(BaseCodeModel region) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      _patientInfoModel.dstr2Cd = region.cdId;

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

  Future<void> setAddress(Kpostal postal) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      _patientInfoModel.bascAddr = postal.roadAddress;
      _patientInfoModel.zip = postal.postCode;

      return _patientInfoModel;
    });
  }

  Future<void> setSurvivalStatus(String status) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      _patientInfoModel.dethYn = status == '생존' ? 'N' : 'Y';

      return _patientInfoModel;
    });
  }

  Future<void> setNation(PatientRegInfoModel report) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      report.natiCd = report.natiCd == 'NATI0001' ? 'NATI0002' : 'NATI0001';
      report.natiNm = report.natiCd == 'NATI0001' ? '대한민국' : '';

      _patientInfoModel.natiCd = report.natiCd;
      _patientInfoModel.natiNm = report.natiNm;

      return _patientInfoModel;
    });
  }

  String? get sex => _patientInfoModel.gndr;

  String get age {
    String birthday;
    if (_patientInfoModel.rrno1 != null) {
      if (_patientInfoModel.rrno2 == '3' || _patientInfoModel.rrno2 == '4') {
        //외국인등록번호 관련 출생년도 설정 필요.
        birthday = '20${_patientInfoModel.rrno1}';
      } else {
        birthday = '19${_patientInfoModel.rrno1}';
      }
    } else {
      birthday = '19700101';
    }

    final difference = DateTime.now().difference(DateTime.tryParse(birthday) ?? DateTime.now());

    return (difference.inDays ~/ 365.25).toString();
  }

  String get address => _patientInfoModel.bascAddr ?? '';

  int get isSurvivalStatus => _patientInfoModel.dethYn == 'Y' ? 1 : 0;

  void overrideInfo(Patient patient) {
    _patientInfoModel.addr = patient.addr;
    _patientInfoModel.dethYn = patient.dethYn;
    _patientInfoModel.gndr = patient.gndr;
    _patientInfoModel.job = patient.job;
    _patientInfoModel.ptNm = patient.ptNm;
    _patientInfoModel.rrno1 = patient.rrno1;
    _patientInfoModel.rrno2 = patient.rrno2;
    _patientInfoModel.dstr1Cd = patient.dstr1Cd;
    _patientInfoModel.dstr2Cd = patient.dstr2Cd;
    _patientInfoModel.mpno = patient.mpno;
    _patientInfoModel.natiCd = patient.natiCd;
    _patientInfoModel.telno = patient.telno;
    _patientInfoModel.attcId = patient.attcId;
    _patientInfoModel.nokNm = patient.nokNm;
    _patientInfoModel.picaVer = patient.picaVer;
    _patientInfoModel.natiNm = patient.natiNm;
  }

  void setTextEditingController(int index, String? value) {
    switch (index) {
      case 0:
        _patientInfoModel.ptNm = value;
        return;

      case 1:
        _patientInfoModel.rrno1 = value;
        return;

      case 101:
        _patientInfoModel.rrno2 = value;

        _patientInfoModel.gndr = value == '1' || value == '3' ? '남' : '여';
        return;

      case 2:
        _patientInfoModel.detlAddr = value;
        return;

      case 3:
        _patientInfoModel.dethYn = value;
        return;

      case 4:
        return;

      case 104:
        _patientInfoModel.natiNm = value ?? '대한민국';
        return;

      case 5:
        _patientInfoModel.mpno = value;
        return;

      case 6:
        _patientInfoModel.telno = value;
        return;

      case 7:
        _patientInfoModel.nokNm = value;
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

      case 101:
        return 1;
    }
    return null;
  }

  String? findPatientAddress(List<BaseCodeModel> list, String? findValue) {
    if (list.any((element) => element.cdId == findValue)) {
      return list.firstWhere((e) => e.cdId == findValue).cdNm;
    }
    if (list.any((element) => element.cdNm == findValue)) {
      return findValue;
    }
    return null;
  }

  String getTextEditingController(int index, PatientRegInfoModel report) {
    switch (index) {
      case 0:
        return report.ptNm ?? '';

      case 1:
        return report.rrno1 ?? '';

      case 101:
        return report.rrno2 ?? '';

      case 2:
        return report.detlAddr ?? '';

      case 3:
        return report.dethYn ?? '';

      case 4:
        return report.natiCd == 'NATI0001' ? '대한민국' : '기타';

      case 5:
        return report.mpno ?? '';

      case 6:
        return report.telno ?? '';

      case 7:
        return report.nokNm ?? '';

      case 8:
        return report.job ?? '';

      case 104:
        return report.natiNm ?? '대한민국';

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
        if (value == null || value.length != 6 || !RegExp(r'^\d{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])$').hasMatch(value)) {
          return '생년월일을 정확히 입력하세요.';
        }
        break;

      case 101:
        if (value == null || value.length != 1 || !RegExp(r'[1-4]').hasMatch(value)) {
          return '주민번호를 정확히 입력하세요.';
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
        return r'[A-Z|a-z|0-9|()-|가-힝|ㄱ-ㅎ|\s|ㆍ|ᆢ]';

      case 4:
        return r'[A-Z|a-z|-|가-힝|ㄱ-ㅎ|ㆍ|ᆢ]';

      case 101:
        return r'[1-4]';

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
      case 101:
      case 5:
      case 6:
        return TextInputType.number;

      default:
        return TextInputType.none;
    }
  }

  late final PatientRegInfoModel _patientInfoModel;
  late final PatientRepository _patientRepository;
  // late final UserRegRequestRepository _regRepository;
}

final patientRegProvider = AsyncNotifierProvider<PatientRegisterPresenter, PatientRegInfoModel>(
  () => PatientRegisterPresenter(),
);
final patientImageProvider = StateProvider<XFile?>((ref) => null);
final patientAttcProvider = StateProvider<String?>((ref) => null);
final patientIsUploadProvider = StateProvider<bool>((ref) => true);
final patientInfoIsChangedProvider = StateProvider<bool>((ref) => false);
