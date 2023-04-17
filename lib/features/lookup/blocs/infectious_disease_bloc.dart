import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/lookup/models/epidemiological_report_model.dart';
import 'package:sbas/features/lookup/models/infectious_disease_model.dart';

class InfectiousDiseaseBloc extends AsyncNotifier<InfectiousDiseaseModel> {
  @override
  FutureOr<InfectiousDiseaseModel> build() {
    _patientDiseaseModel = InfectiousDiseaseModel.empty();

    return _patientDiseaseModel;
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

  late final InfectiousDiseaseModel _patientDiseaseModel;
}

final infectiousDiseaseProvider =
    AsyncNotifierProvider<InfectiousDiseaseBloc, InfectiousDiseaseModel>(
  () => InfectiousDiseaseBloc(),
);
