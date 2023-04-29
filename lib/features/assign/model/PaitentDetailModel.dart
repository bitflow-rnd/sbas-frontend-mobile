import 'package:sbas/features/lookup/models/patient_info_model.dart';

class PatientDetailModel {
  PatientDetailModel(
    this.patient,
    this.timeLines,
  );
  Patient patient;
  List<TimeLine> timeLines;
}

class TimeLine {}
