import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/features/authentication/repos/user_reg_req_repo.dart';
import 'package:sbas/features/lookup/models/epidemiological_report_model.dart';
import 'package:sbas/features/lookup/models/infectious_disease_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';

class InfectiousDiseaseBloc extends AsyncNotifier<InfectiousDiseaseModel> {
  @override
  FutureOr<InfectiousDiseaseModel> build() {
    _diseaseRepository = ref.read(patientRepoProvider);
    _regRepository = ref.read(userRegReqProvider);
    _patientDiseaseModel = InfectiousDiseaseModel.empty();

    return _patientDiseaseModel;
  }

  Future<void> registry(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      _patientDiseaseModel.ptId = id;

      final imageFile = ref.read(infectiousImageProvider);

      if (imageFile != null) {
        _patientDiseaseModel.diagAttcId = await _regRepository.uploadImage(imageFile);
      }
      await _diseaseRepository.registerDiseaseInfo(
        _patientDiseaseModel.toJson(),
      );
      return _patientDiseaseModel;
    });
    if (state.hasError) {}
    if (state.hasValue) {}
  }

  String? init(int index, EpidemiologicalReportModel report) {
    //V2 로 변경완료
    switch (index) {
      case 0: //입원여부
        _patientDiseaseModel.diagNm ??= report.diagNm; // 질병명
        _patientDiseaseModel.rcptPhc ??= report.rcptPhc; // 수신보건소
        _patientDiseaseModel.rptType ??= report.rptType; // 신고구분

        //상기 3항목은 들어갈 곳이 없어서 여기서 초기화
        _patientDiseaseModel.admsYn ??= report.admsYn;
        return _patientDiseaseModel.admsYn;
      case 1: //보건소명 직접입력 //현재 보건소 선택결과 저장안됨.TODO
        _patientDiseaseModel.rptType ??= report.rptType; //신고구분
        return _patientDiseaseModel.rcptPhc;
      case 2: //코로나증상여부
        _patientDiseaseModel.cv19Symp ??= report.cv19Symp;
        return _patientDiseaseModel.cv19Symp;
      case 3: //확진검사결과
        _patientDiseaseModel.dfdgExamRslt ??= report.dfdgExamRslt;
        return _patientDiseaseModel.dfdgExamRslt;
      case 4: //질병급
        _patientDiseaseModel.diagGrde ??= report.diagGrde;
        return _patientDiseaseModel.diagGrde;
      case 5: //발병일
        _patientDiseaseModel.occrDt ??= report.occrDt;
        return _patientDiseaseModel.occrDt;
      case 6: //진단일
        _patientDiseaseModel.diagDt ??= report.diagDt;
        return _patientDiseaseModel.diagDt;
      case 7: //신고일
        _patientDiseaseModel.rptDt ??= report.rptDt;
        return _patientDiseaseModel.rptDt;
      case 8: //환자등분류
        _patientDiseaseModel.ptCatg ??= report.ptCatg;
        return _patientDiseaseModel.ptCatg;
      case 9: //비고
        _patientDiseaseModel.rmk ??= report.rmk;
        return _patientDiseaseModel.rmk;
      case 10: //요양기관명
        _patientDiseaseModel.instNm ??= report.instNm;
        return _patientDiseaseModel.instNm;
      case 11: //요양병원기호
        _patientDiseaseModel.instId ??= report.instId;
        return _patientDiseaseModel.instId;
      case 12: //상세주소
        //TODO::상세주소 중 instBascAddr,+ instAddr  = instAddr 이 되어야 하지만 기존 코드에서 없어서 keep
        _patientDiseaseModel.instAddr ??= report.instAddr;
        return _patientDiseaseModel.instAddr;
      case 13: //전화번호
        _patientDiseaseModel.instTelno ??= report.instTelno;
        return _patientDiseaseModel.instTelno;
      case 14: //진단의사 성명
        _patientDiseaseModel.diagDrNm ??= report.diagDrNm;
        return _patientDiseaseModel.diagDrNm;
      case 15: //신고기관장 성명
        _patientDiseaseModel.rptChfNm ??= report.rptChfNm;
        return _patientDiseaseModel.rptChfNm;
    }
    return null;
  }

  String? getOccrDt() => _patientDiseaseModel.occrDt;

  void setTextEditingController(int index, String? value) {
    switch (index) {
      case 0: //입원여부
        _patientDiseaseModel.admsYn = value;
        break;
      case 1: //보건소명 직접입력
        _patientDiseaseModel.rcptPhc = value;
        break;
      case 2: //코로나증상여부
        _patientDiseaseModel.cv19Symp = value;
        break;
      case 3: //확진검사결과
        _patientDiseaseModel.dfdgExamRslt = value;
        break;
      case 4: //질병급
        _patientDiseaseModel.diagGrde = value;
        break;
      case 5: //발병일
        _patientDiseaseModel.occrDt = value;
        break;
      case 6: //진단일
        _patientDiseaseModel.diagDt = value;
        break;
      case 7: //신고일
        _patientDiseaseModel.rptDt = value;
        break;
      case 8: //환자등분류
        _patientDiseaseModel.ptCatg = value;
        break;
      case 9: //비고
        _patientDiseaseModel.rmk = value;
        break;
      case 10: //요양기관명
        _patientDiseaseModel.instNm = value;
        break;
      case 11: //요양병원기호
        _patientDiseaseModel.instId = value;
        break;
      case 12: //상세주소
        _patientDiseaseModel.instAddr = value;
        break;
      case 13: //전화번호
        _patientDiseaseModel.instTelno = value;
        break;
      case 14: //진단의사 성명
        _patientDiseaseModel.diagDrNm = value;
        break;
      case 15: //신고기관장 성명
        _patientDiseaseModel.rptChfNm = value;
        break;
    }
  }

  late final PatientRepository _diseaseRepository;
  late final InfectiousDiseaseModel _patientDiseaseModel;
  late final UserRegRequestRepository _regRepository;
}

final infectiousDiseaseProvider = AsyncNotifierProvider<InfectiousDiseaseBloc, InfectiousDiseaseModel>(
  () => InfectiousDiseaseBloc(),
);
final infectiousImageProvider = StateProvider<XFile?>((ref) => null);
final infectiousAttcProvider = StateProvider<String?>((ref) => null);
final infectiousIsUploadProvider = StateProvider<bool>((ref) => true);
