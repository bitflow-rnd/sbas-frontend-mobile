import 'package:sbas/features/lookup/models/patient_model.dart';

class PatientInfoModel {
  List<Patient>? list;
  int? length;

  PatientInfoModel({
    this.list,
    this.length,
  });

  PatientInfoModel.fromJson(Map<String, dynamic> json) {
    if (json["items"] is List) {
      list = json["items"] == null
          ? null
          : (json["items"] as List).map((e) => Patient.fromJson(e)).toList();
    }
    if (json["count"] is int) {
      length = json["count"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (list != null) {
      data["items"] = list?.map((e) => e.toJson()).toList();
    }
    data["count"] = length;

    return data;
  }
}
