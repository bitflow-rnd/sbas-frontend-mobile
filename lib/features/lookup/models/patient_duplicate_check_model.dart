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

class PatientCheckResponse {
  String? ptId;
  String? ptNm;
  String? rrno1;
  String? rrno2;
  String? gndr;
  String? dstr1Cd;
  String? dstr1CdNm;
  String? dstr2Cd;
  String? dstr2CdNm;
  String? telno;
  String? natiCd;
  String? dethYn;
  String? nokNm;
  String? mpno;
  String? job;
  String? bascAddr;
  String? detlAddr;
  String? zip;
  String? natiNm;

  PatientCheckResponse.fromJson(Map<String, dynamic> json) {
    if (json["ptId"] is String) {
      ptId = json["ptId"];
    }
    if (json["ptNm"] is String) {
      ptNm = json["ptNm"];
    }
    if (json["rrno1"] is String) {
      rrno1 = json["rrno1"];
    }
    if (json["rrno2"] is String) {
      rrno2 = json["rrno2"];
    }
    if (json["gndr"] is String) {
      gndr = json["gndr"];
    }
    if (json["dstr1Cd"] is String) {
      dstr1Cd = json["dstr1Cd"];
    }
    if (json["dstr1CdNm"] is String) {
      dstr1CdNm = json["dstr1CdNm"];
    }
    if (json["dstr2Cd"] is String) {
      dstr2Cd = json["dstr2Cd"];
    }
    if (json["dstr2CdNm"] is String) {
      dstr2CdNm = json["dstr2CdNm"];
    }
    if (json["telno"] is String) {
      telno = json["telno"];
    }
    if (json["natiCd"] is String) {
      natiCd = json["natiCd"];
    }
    if (json["dethYn"] is String) {
      dethYn = json["dethYn"];
    }
    if (json["nokNm"] is String) {
      nokNm = json["nokNm"];
    }
    if (json["mpno"] is String) {
      mpno = json["mpno"];
    }
    if (json["job"] is String) {
      job = json["job"];
    }
    if (json["bascAddr"] is String) {
      bascAddr = json["bascAddr"];
    }
    if (json["detlAddr"] is String) {
      detlAddr = json["detlAddr"];
    }
    if (json["zip"] is String) {
      zip = json["zip"];
    }
    if (json["natiNm"] is String) {
      natiNm = json["natiNm"];
    }
  }
}