import 'package:sbas/features/lookup/models/patient_model.dart';

class PatientListModel {
  int? count;
  late List<Patient> items;

  PatientListModel({
    this.count,
    required this.items,
  });
  PatientListModel.fromJson(Map<String, dynamic> json) {
    if (json["count"] is int) {
      count = json["count"];
    }
    if (json["items"] is List) {
      items = (json["items"] as List).map((e) => Patient.fromJson(e)).toList();
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["count"] = count;

    data["items"] = items.map((e) => e.toJson()).toList();

    return data;
  }
}
