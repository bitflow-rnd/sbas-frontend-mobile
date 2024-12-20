import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kpostal/kpostal.dart';
import 'package:sbas/features/assign/repos/assign_repo.dart';
import 'package:sbas/features/lookup/presenters/infectious_disease_provider.dart';
import 'package:sbas/features/lookup/presenters/patient_info_presenter.dart';
import 'package:sbas/features/lookup/presenters/patient_lookup_provider.dart';
import 'package:sbas/features/lookup/models/epidemiological_report_model.dart';
import 'package:sbas/features/lookup/models/patient_duplicate_check_model.dart';
import 'package:sbas/features/lookup/models/patient_reg_info_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';
import 'package:sbas/features/patient/models/patient_model.dart';
import 'package:sbas/features/patient/providers/patient_provider.dart';

class PatientRegisterNotifier extends AsyncNotifier<PatientRegInfoModel> {
  @override
  FutureOr<PatientRegInfoModel> build() {
    patientInfoModel = PatientRegInfoModel();
    // _regRepository = ref.read(userRegReqProvider);
    _patientRepository = ref.read(patientRepoProvider);

    return patientInfoModel;
  }

  init() {
    patientInfoModel.clear();
    ref.watch(patientInfoIsChangedProvider.notifier).state = false;
    ref.invalidate(patientImageProvider);
    ref.invalidate(patientAttcProvider);
    patientInfoModel.natiCd = "NATI0001";
    patientInfoModel.natiNm = "대한민국"; //대한민국 기본 Default
    patientInfoModel.dethYn = "N"; //생존으로 initialization
  }

  patientInit(Patient patient) {
    patientInfoModel.ptNm = patient.ptNm ?? "";
    patientInfoModel.gndr = patient.gndr ?? "";
    patientInfoModel.rrno1 = patient.rrno1 ?? "";
    patientInfoModel.rrno2 = patient.rrno2 ?? "";
    patientInfoModel.dstr1Cd = patient.dstr1Cd ?? "";
    patientInfoModel.dstr2Cd = patient.dstr2Cd ?? "";
    patientInfoModel.addr = patient.addr ?? "";
    patientInfoModel.telno = patient.telno ?? "";
    patientInfoModel.natiCd = patient.natiCd ?? "";
    patientInfoModel.picaVer = patient.picaVer ?? "";
    patientInfoModel.dethYn = patient.dethYn ?? "";
    patientInfoModel.nokNm = patient.nokNm ?? "";
    patientInfoModel.mpno = patient.mpno ?? "";
    patientInfoModel.job = patient.job ?? "";
    patientInfoModel.attcId = patient.attcId ?? "";
    patientInfoModel.bascAddr = patient.bascAddr ?? "";
    patientInfoModel.detlAddr = patient.detlAddr ?? "";
    patientInfoModel.zip = patient.zip ?? "";
    patientInfoModel.natiNm = patient.natiNm ?? "";
    patientInfoModel.ptId = patient.ptId ?? "";
  }

  Future<void> registry(String? id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      if (id == null) {
        patientInfoModel.ptId = (await _patientRepository
            .registerPatientInfo(patientInfoModel.toJson()));
      } else {
        patientInfoModel.ptId = id;
        await _patientRepository.updatePatientInfo(
          id,
          patientInfoModel.toJson(),
        );
      }
      ref.invalidate(patientInfoProvider);
      return patientInfoModel;
    });
    if (state.hasError) {}
    if (state.hasValue) {
      ref.read(patientImageProvider.notifier).state = null;
      ref.read(patientAttcProvider.notifier).state = null;

      ref.read(patientIdProvider.notifier).state = id;
      ref.read(patientLookupProvider.notifier).refresh();
    }
  }

  Future<void> updatePatient(String? id, BuildContext context) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      if (id != null) {
        patientInfoModel.ptId = id;
        await _patientRepository.updatePatientInfo(id, patientInfoModel.toJson());
      }

      ref.invalidate(patientInfoProvider);
      return patientInfoModel;
    });
    if (state.hasError) {}
    if (state.hasValue) {
      ref.read(patientImageProvider.notifier).state = null;
      ref.read(patientAttcProvider.notifier).state = null;

      ref.read(patientIdProvider.notifier).state = id;
      ref.read(patientLookupProvider.notifier).refresh();
    }
  }

  Future<bool> uploadImage(XFile imageFile) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      try {
        final report = EpidemiologicalReportModel.fromJson(
          await _patientRepository.upldEpidReport(imageFile),
        );
        ref.read(patientAttcProvider.notifier).state = report.attcId;
        patientInfoModel.bascAddr = report.baseAddr;
        patientInfoModel.detlAddr = report.dtlAddr;
        patientInfoModel.zip = report.zip;
        patientInfoModel.attcId = report.attcId;
        patientInfoModel.gndr =
            report.rrno2?[0] == '1' || report.rrno2?[0] == '3' ? '남' : '여';
        patientInfoModel.job = report.job;
        patientInfoModel.ptNm = report.ptNm;
        patientInfoModel.rrno1 = report.rrno1;
        patientInfoModel.rrno2 = report.rrno2;
        patientInfoModel.dethYn = report.dethYn == '사망' ? 'Y' : 'N';
        patientInfoModel.dstr1Cd = report.dstr1Cd;
        patientInfoModel.dstr2Cd = report.dstr2Cd;
        patientInfoModel.telno = report.telno; //mpn
        patientInfoModel.mpno = report.mpno;
        patientInfoModel.nokNm = report.nokNm;
        patientInfoModel.natiCd = report.natiCd;
        ref.watch(infectiousDiseaseProvider.notifier).initByOCR(report);
      } catch (exception) {
        if (kDebugMode) {
          print("uploadImage exception $exception");
          return PatientRegInfoModel();
        }
      }
      return patientInfoModel;
    });
    if (state.hasError || state.value?.ptNm == null) {
      return false;
    }
    if (state.hasValue) {
      return true;
    }
    return true;
  }

  Future<Map<String, dynamic>> exist() async {
    var model = PatientDuplicateCheckModel(
      ptNm: patientInfoModel.ptNm,
      rrno1: patientInfoModel.rrno1,
      rrno2: patientInfoModel.rrno2,
      dstr1Cd: patientInfoModel.dstr1Cd,
      dstr2Cd: patientInfoModel.dstr2Cd,
      mpno: patientInfoModel.mpno,
    );

    return await _patientRepository.postExist(model);
  }

  Future<void> setAddress(Kpostal postal) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      patientInfoModel.bascAddr = postal.roadAddress;
      patientInfoModel.zip = postal.postCode;

      return patientInfoModel;
    });
  }

  Future<void> setSurvivalStatus(String status) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      patientInfoModel.dethYn = status == '생존' ? 'N' : 'Y';

      return patientInfoModel;
    });
  }

  Future<void> setNation(String natiCd) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      patientInfoModel.natiCd = natiCd;
      if (natiCd == "NATI0001") {
        patientInfoModel.natiNm = "대한민국";
      } else {
        patientInfoModel.natiNm = "";
      }
      return patientInfoModel;
    });
  }

  String? get sex => patientInfoModel.gndr;

  String get age {
    String birthday;
    if (patientInfoModel.rrno1 != null) {
      if (patientInfoModel.rrno2 == '3' || patientInfoModel.rrno2 == '4') {
        //외국인등록번호 관련 출생년도 설정 필요.
        birthday = '20${patientInfoModel.rrno1}';
      } else {
        birthday = '19${patientInfoModel.rrno1}';
      }
    } else {
      return '';
    }

    final difference = DateTime.now()
        .difference(DateTime.tryParse(birthday) ?? DateTime.now());

    return (difference.inDays ~/ 365.25).toString();
  }

  String get address => patientInfoModel.bascAddr ?? '';

  int get isSurvivalStatus => patientInfoModel.dethYn == 'Y' ? 1 : 0;

  void overrideInfo(Patient patient) {
    patientInfoModel.addr = patient.addr;
    patientInfoModel.dethYn = patient.dethYn;
    patientInfoModel.gndr = patient.gndr;
    patientInfoModel.job = patient.job;
    patientInfoModel.ptNm = patient.ptNm;
    patientInfoModel.rrno1 = patient.rrno1;
    patientInfoModel.rrno2 = patient.rrno2;
    patientInfoModel.dstr1Cd = patient.dstr1Cd;
    patientInfoModel.dstr2Cd = patient.dstr2Cd;
    patientInfoModel.mpno = patient.mpno;
    patientInfoModel.natiCd = patient.natiCd;
    patientInfoModel.telno = patient.telno;
    patientInfoModel.attcId = patient.attcId;
    patientInfoModel.nokNm = patient.nokNm;
    patientInfoModel.picaVer = patient.picaVer;
    patientInfoModel.natiNm = patient.natiNm;
  }

  void setTextEditingController(int index, String? value) {
    switch (index) {
      case 0:
        patientInfoModel.ptNm = value;
        return;

      case 1:
        patientInfoModel.rrno1 = value;
        return;

      case 101:
        patientInfoModel.rrno2 = value;

        patientInfoModel.gndr =
            value?[0] == '1' || value?[0] == '3' ? '남' : '여';
        return;

      case 2:
        patientInfoModel.detlAddr = value;
        return;

      case 3:
        patientInfoModel.dethYn = value;
        return;

      case 4:
        return;

      case 104:
        patientInfoModel.natiNm = value ?? '대한민국';
        return;

      case 5:
        patientInfoModel.mpno = value;
        return;

      case 6:
        patientInfoModel.telno = value;
        return;

      case 7:
        patientInfoModel.nokNm = value;
        return;

      case 8:
        patientInfoModel.job = value;
        return;
    }
  }

  int? getMaxLength(int index) {
    switch (index) {
      case 0:
      case 7:
        return 7;

      case 101:
        return 1;

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

  String? isFieldValid(int index, String? value) {
    switch (index) {
      case 0:
        if (value == null ||
            value.length < 2 ||
            RegExp(
                  r'[\uac00-\ud7af]',
                  unicode: true,
                ).allMatches(value).length !=
                value.length) {
          return '환자 이름을 입력해 주세요.';
        }
        break;

      case 1:
        if (value == null ||
            value.length != 6 ||
            !RegExp(r'^\d{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])$')
                .hasMatch(value)) {
          return '생년월일을 정확히 입력하세요.';
        }
        break;

      case 101:
        if (value == null ||
            (value.length != 7 && value.length != 1) ||
            !RegExp(r'([1-4])|([1-4]\\d{6})').hasMatch(value)) {
          return '주민번호를 정확히 입력하세요.';
        }
        break;

      case 102:
        if (value == null || value.length < 2) {
          return '기본주소를 입력해 주세요.';
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

      case 1:
      case 5:
      case 6:
      case 101:
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

  late final PatientRegInfoModel patientInfoModel;
  late final PatientRepository _patientRepository;
// late final UserRegRequestRepository _regRepository;
}

final patientRegProvider =
    AsyncNotifierProvider<PatientRegisterNotifier, PatientRegInfoModel>(
  () => PatientRegisterNotifier(),
);
