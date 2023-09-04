import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kpostal/kpostal.dart';
import 'package:sbas/features/authentication/repos/user_reg_req_repo.dart';
import 'package:sbas/features/lookup/models/epidemiological_report_model.dart';
import 'package:sbas/features/lookup/models/infectious_disease_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';

class InfectiousDiseaseBloc extends AsyncNotifier<InfectiousDiseaseModel> {
  String get address => _infectiousDiseaseModel.instBascAddr ?? '';

  @override
  FutureOr<InfectiousDiseaseModel> build() {
    _patientRepository = ref.read(patientRepoProvider);
    _regRepository = ref.read(userRegReqProvider);
    _infectiousDiseaseModel = InfectiousDiseaseModel.empty();

    return _infectiousDiseaseModel;
  }

  Future<bool> registry(String ptId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      _infectiousDiseaseModel.ptId = ptId;

      final imageFile = ref.read(infectiousImageProvider);

      if (imageFile != null) {
        _infectiousDiseaseModel.diagAttcId = await _regRepository.uploadImage(imageFile);
      }
      await _patientRepository.registerDiseaseInfo(
        _infectiousDiseaseModel.toJson(),
      );

      return _infectiousDiseaseModel;
    });
    if (state.hasError) {
      return false;
    }
    if (state.hasValue) {
      return true;
    }
    return false;
  }

  reset() {
    // 초기화 시점에 대한 고려 필요
    ref.watch(infectiousImageProvider.notifier).state = null;
    ref.watch(infectiousAttcProvider.notifier).state = null;
    ref.watch(infectiousIsUploadProvider.notifier).state = true;
    _infectiousDiseaseModel.clear();
  }

  updateRegion(String? rcptPhc) {
    _infectiousDiseaseModel.rcptPhc = rcptPhc;
  }

  Future<void> setAddress(Kpostal postal) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      _infectiousDiseaseModel.instBascAddr = postal.roadAddress;
      _infectiousDiseaseModel.instZip = postal.postCode;

      return _infectiousDiseaseModel;
    });
  }

  String? init(int index, EpidemiologicalReportModel report) {
    //V2 로 변경완료
    switch (index) {
      case 0: //입원여부
        _infectiousDiseaseModel.diagNm ??= report.diagNm; // 질병명
        _infectiousDiseaseModel.rptType ??= report.rptType; // 신고구분

        //상기 3항목은 들어갈 곳이 없어서 여기서 초기화
        _infectiousDiseaseModel.admsYn ??= report.admsYn;
        return _infectiousDiseaseModel.admsYn;
      case 1: //보건소명 직접입력 //현재 보건소 선택결과 저장안됨.TODO
        _infectiousDiseaseModel.rcptPhc ??= report.rcptPhc; //신고구분
        return _infectiousDiseaseModel.rcptPhc;
      case 2: //코로나증상여부
        _infectiousDiseaseModel.cv19Symp ??= report.cv19Symp;
        return _infectiousDiseaseModel.cv19Symp;
      case 3: //확진검사결과
        _infectiousDiseaseModel.dfdgExamRslt ??= report.dfdgExamRslt;
        return _infectiousDiseaseModel.dfdgExamRslt;
      case 4: //질병급
        _infectiousDiseaseModel.diagGrde ??= report.diagGrde;
        return _infectiousDiseaseModel.diagGrde;
      case 5: //발병일
        _infectiousDiseaseModel.occrDt ??= report.occrDt;
        return _infectiousDiseaseModel.occrDt;
      case 6: //진단일
        _infectiousDiseaseModel.diagDt ??= report.diagDt;
        return _infectiousDiseaseModel.diagDt;
      case 7: //신고일
        _infectiousDiseaseModel.rptDt ??= report.rptDt;
        return _infectiousDiseaseModel.rptDt;
      case 8: //환자등분류
        _infectiousDiseaseModel.ptCatg ??= report.ptCatg;
        return _infectiousDiseaseModel.ptCatg;
      case 9: //비고
        _infectiousDiseaseModel.rmk ??= report.rmk;
        return _infectiousDiseaseModel.rmk;
      case 10: //요양기관명
        _infectiousDiseaseModel.instNm ??= report.instNm;
        return _infectiousDiseaseModel.instNm;
      case 11: //요양병원기호
        _infectiousDiseaseModel.instId ??= report.instId;
        return _infectiousDiseaseModel.instId;
      case 12: //상세주소
        //TODO::상세주소 중 instBascAddr,+ instAddr  = instAddr 이 되어야 하지만 기존 코드에서 없어서 keep
        _infectiousDiseaseModel.instAddr ??= report.instAddr;
        return _infectiousDiseaseModel.instAddr;
      case 13: //전화번호
        _infectiousDiseaseModel.instTelno ??= report.instTelno;
        return _infectiousDiseaseModel.instTelno;
      case 14: //진단의사 성명
        _infectiousDiseaseModel.diagDrNm ??= report.diagDrNm;
        return _infectiousDiseaseModel.diagDrNm;
      case 15: //신고기관장 성명
        _infectiousDiseaseModel.rptChfNm ??= report.rptChfNm;
        return _infectiousDiseaseModel.rptChfNm;
    }
    return null;
  }

  String? getOccrDt() => _infectiousDiseaseModel.occrDt;

  void setTextEditingController(int index, String? value) {
    switch (index) {
      case 0: //입원여부
        _infectiousDiseaseModel.admsYn = value;
        break;
      case 1: //보건소명 직접입력
        _infectiousDiseaseModel.rcptPhc = value;
        break;
      case 2: //코로나증상여부
        _infectiousDiseaseModel.cv19Symp = value;
        break;
      case 3: //확진검사결과
        _infectiousDiseaseModel.dfdgExamRslt = value;
        break;
      case 4: //질병급
        _infectiousDiseaseModel.diagGrde = value;
        break;
      case 5: //발병일
        _infectiousDiseaseModel.occrDt = value;
        break;
      case 6: //진단일
        _infectiousDiseaseModel.diagDt = value;
        break;
      case 7: //신고일
        _infectiousDiseaseModel.rptDt = value;
        break;
      case 8: //환자등분류
        _infectiousDiseaseModel.ptCatg = value;
        break;
      case 9: //비고
        _infectiousDiseaseModel.rmk = value;
        break;
      case 10: //요양기관명
        _infectiousDiseaseModel.instNm = value;
        break;
      case 11: //요양병원기호
        _infectiousDiseaseModel.instId = value;
        break;
      case 12: //상세주소
        _infectiousDiseaseModel.instAddr = value;
        break;
      case 13: //전화번호
        _infectiousDiseaseModel.instTelno = value;
        break;
      case 14: //진단의사 성명
        _infectiousDiseaseModel.diagDrNm = value;
        break;
      case 15: //신고기관장 성명
        _infectiousDiseaseModel.rptChfNm = value;
        break;
    }
  }

  void initByOCR(EpidemiologicalReportModel report) {
    _infectiousDiseaseModel.admsYn ??= report.admsYn;
    _infectiousDiseaseModel.rcptPhc ??= report.rcptPhc;
    _infectiousDiseaseModel.cv19Symp ??= report.cv19Symp;
    _infectiousDiseaseModel.rcptPhc = report.rcptPhc;
    _infectiousDiseaseModel.diagNm = report.diagNm;
    _infectiousDiseaseModel.diagGrde = report.diagGrde;
    _infectiousDiseaseModel.cv19Symp = report.cv19Symp;
    _infectiousDiseaseModel.occrDt = report.occrDt;
    _infectiousDiseaseModel.diagDt = report.diagDt;
    _infectiousDiseaseModel.rptDt = report.rptDt;
    _infectiousDiseaseModel.dfdgExamRslt = report.dfdgExamRslt;
    _infectiousDiseaseModel.ptCatg = report.ptCatg;
    _infectiousDiseaseModel.admsYn = report.admsYn;
    _infectiousDiseaseModel.rptType = report.rptType;
    _infectiousDiseaseModel.rmk = report.rmk;
    _infectiousDiseaseModel.instNm = report.instNm;
    _infectiousDiseaseModel.instId = report.instId;
    _infectiousDiseaseModel.instTelno = report.instTelno;
    _infectiousDiseaseModel.instAddr = report.instAddr;
    _infectiousDiseaseModel.diagDrNm = report.diagDrNm;
    _infectiousDiseaseModel.rptChfNm = report.rptChfNm;
  }

  late final PatientRepository _patientRepository;
  late final InfectiousDiseaseModel _infectiousDiseaseModel;
  late final UserRegRequestRepository _regRepository;
}

final infectiousDiseaseProvider = AsyncNotifierProvider<InfectiousDiseaseBloc, InfectiousDiseaseModel>(
  () => InfectiousDiseaseBloc(),
);
final infectiousImageProvider = StateProvider<XFile?>((ref) => null);
final infectiousAttcProvider = StateProvider<String?>((ref) => null);
final infectiousIsUploadProvider = StateProvider<bool>((ref) => true);
