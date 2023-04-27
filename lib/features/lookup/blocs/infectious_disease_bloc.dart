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
        _patientDiseaseModel.diagAttcId =
            await _regRepository.uploadImage(imageFile);
      }
      await _diseaseRepository.registerDiseaseInfo(
        _patientDiseaseModel.toJson(),
      );
      return _patientDiseaseModel;
    });
    if (state.hasError) {}
    if (state.hasValue) {}
  }

  void setTextEditingController(int index, String? value) {
    switch (index) {
      case 0:
        _patientDiseaseModel.rcptPhc = value;
        break;

      case 1:
        _patientDiseaseModel.cv19Symp = value;
        break;

      case 2:
        _patientDiseaseModel.dfdgExamRslt = value;
        break;

      case 3:
        _patientDiseaseModel.diagGrde = value;
        break;

      case 4:
        _patientDiseaseModel.occrDt = value;
        break;

      case 100:
        _patientDiseaseModel.diagDt = value;
        break;

      case 101:
        _patientDiseaseModel.rptDt = value;
        break;

      case 5:
        _patientDiseaseModel.ptCatg = value;
        break;

      case 6:
        _patientDiseaseModel.rmk = value;
        break;

      case 7:
        _patientDiseaseModel.admsYn = value;
        break;

      case 8:
        _patientDiseaseModel.instNm = value;
        break;

      case 9:
        _patientDiseaseModel.instId = value;
        break;

      case 10:
        _patientDiseaseModel.instAddr = value;
        break;

      case 11:
        _patientDiseaseModel.instTelno = value;
        break;

      case 12:
        _patientDiseaseModel.diagDrNm = value;
        break;

      case 13:
        _patientDiseaseModel.rptChfNm = value;
        break;
    }
  }

  String? init(int index, EpidemiologicalReportModel report) {
    switch (index) {
      case 0:
        _patientDiseaseModel.rcptPhc ??= report.rcptPhc;
        _patientDiseaseModel.admsYn ??= report.admsYn;

        return _patientDiseaseModel.rcptPhc;

      case 1:
        _patientDiseaseModel.cv19Symp ??= report.cv19Symp;

        return _patientDiseaseModel.cv19Symp;

      case 2:
        _patientDiseaseModel.dfdgExamRslt ??= report.dfdgExamRslt;

        return _patientDiseaseModel.dfdgExamRslt;

      case 3:
        _patientDiseaseModel.diagGrde ??= report.diagGrde;

        return _patientDiseaseModel.diagGrde;

      case 4:
        _patientDiseaseModel.occrDt ??= report.occrDt;

        return _patientDiseaseModel.occrDt;

      case 100:
        _patientDiseaseModel.diagDt ??= report.diagDt;

        return _patientDiseaseModel.diagDt;

      case 101:
        _patientDiseaseModel.rptDt ??= report.rptDt;

        return _patientDiseaseModel.rptDt;

      case 5:
        _patientDiseaseModel.ptCatg ??= report.ptCatg;

        return _patientDiseaseModel.ptCatg;

      case 6:
        _patientDiseaseModel.rmk ??= report.rmk;

        return _patientDiseaseModel.rmk;

      case 7:
        _patientDiseaseModel.admsYn ??= report.admsYn;

        return _patientDiseaseModel.admsYn;

      case 8:
        _patientDiseaseModel.instNm ??= report.instNm;

        return _patientDiseaseModel.instNm;

      case 9:
        _patientDiseaseModel.instId ??= report.instId;

        return _patientDiseaseModel.instId;

      case 10:
        _patientDiseaseModel.instAddr ??= report.instAddr;

        return _patientDiseaseModel.instAddr;

      case 11:
        _patientDiseaseModel.instTelno ??= report.instTelno;

        return _patientDiseaseModel.instTelno;

      case 12:
        _patientDiseaseModel.diagDrNm ??= report.diagDrNm;

        return _patientDiseaseModel.diagDrNm;

      case 13:
        _patientDiseaseModel.rptChfNm ??= report.rptChfNm;

        return _patientDiseaseModel.rptChfNm;

      case 14:
    }
    return null;
  }

  late final PatientRepository _diseaseRepository;
  late final InfectiousDiseaseModel _patientDiseaseModel;
  late final UserRegRequestRepository _regRepository;
}

final infectiousDiseaseProvider =
    AsyncNotifierProvider<InfectiousDiseaseBloc, InfectiousDiseaseModel>(
  () => InfectiousDiseaseBloc(),
);
final infectiousImageProvider = StateProvider<XFile?>((ref) => null);
final infectiousAttcProvider = StateProvider<String?>((ref) => null);
final infectiousIsUploadProvider = StateProvider<bool>((ref) => true);
