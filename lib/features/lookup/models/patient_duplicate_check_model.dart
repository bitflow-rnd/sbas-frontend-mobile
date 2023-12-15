class PatientDuplicateCheckModel {
  String? ptNm;
  String? rrno1;
  String? rrno2;
  String? dstr1Cd;
  String? dstr2Cd;
  String? mpno;

  PatientDuplicateCheckModel({
    this.ptNm,
    this.rrno1,
    this.rrno2,
    this.dstr1Cd,
    this.dstr2Cd,
    this.mpno,
  });

  PatientDuplicateCheckModel.fromJson(Map<String, dynamic> json) {
    if (json["ptNm"] is String) {
      ptNm = json["ptNm"];
    }
    if (json["rrno1"] is String) {
      rrno1 = json["rrno1"];
    }
    if (json["rrno2"] is String) {
      rrno2 = json["rrno2"];
    }
    if (json["dstr1Cd"] is String) {
      dstr1Cd = json["dstr1Cd"];
    }
    if (json["dstr2Cd"] is String) {
      dstr2Cd = json["dstr2Cd"];
    }
    if (json["mpno"] is String) {
      mpno = json["mpno"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["ptNm"] = ptNm;
    data["rrno1"] = rrno1;
    data["rrno2"] = rrno2;
    data["dstr1Cd"] = dstr1Cd;
    data["dstr2Cd"] = dstr2Cd;
    data["mpno"] = mpno;

    return data;
  }
}