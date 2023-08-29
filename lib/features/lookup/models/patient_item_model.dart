class PatientItemModel {
  String? ptId;
  int? bdasSeq;
  String? ptNm;
  String? gndr;
  String? dstr1Cd;
  String? dstr2Cd;
  String? dstr1CdNm;
  String? dstr2CdNm;
  String? mpno;
  String? chrgInstId;
  String? hospNm;
  String? telno;
  String? natiCd;
  String? statCd;
  String? statCdNm;
  String? updtDttm;
  int? age;
  late List<String> tagList;

  PatientItemModel({
    this.ptId,
    this.bdasSeq,
    this.ptNm,
    this.gndr,
    this.dstr1Cd,
    this.dstr2Cd,
    this.telno,
    this.natiCd,
    this.statCd,
    this.statCdNm,
    this.updtDttm,
    this.age,
    this.dstr1CdNm,
    this.dstr2CdNm,
    this.mpno,
    this.chrgInstId,
    this.hospNm,
    required this.tagList,
  });
  PatientItemModel.fromJson(Map<String, dynamic> json) {
    if (json["dstr1CdNm"] is String) {
      dstr1CdNm = json["dstr1CdNm"];
    }
    if (json["dstr2CdNm"] is String) {
      dstr2CdNm = json["dstr2CdNm"];
    }
    if (json["mpno"] is String) {
      mpno = json["mpno"];
    }
    if (json["chrgInstId"] is String) {
      chrgInstId = json["chrgInstId"];
    }
    if (json["hospNm"] is String) {
      hospNm = json["hospNm"];
    }
    if (json["ptId"] is String) {
      ptId = json["ptId"];
    }
    if (json["bdasSeq"] is int) {
      bdasSeq = json["bdasSeq"];
    }
    if (json["ptNm"] is String) {
      ptNm = json["ptNm"];
    }
    if (json["gndr"] is String) {
      gndr = json["gndr"];
    }
    if (json["dstr1Cd"] is String) {
      dstr1Cd = json["dstr1Cd"];
    }
    if (json["dstr2Cd"] is String) {
      dstr2Cd = json["dstr2Cd"];
    }
    if (json["telno"] is String) {
      telno = json["telno"];
    }
    if (json["natiCd"] is String) {
      natiCd = json["natiCd"];
    }
    if (json["statCd"] is String) {
      statCd = json["statCd"];
    }
    if (json["statCdNm"] is String) {
      statCdNm = json["statCdNm"];
    }
    if (json["updtDttm"] is String) {
      updtDttm = json["updtDttm"];
    }
    if (json["age"] is int) {
      age = json["age"];
    }
    if (json["tagList"] is List) {
      tagList = List<String>.from(json["tagList"]);
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["ptId"] = ptId;
    data["bdasSeq"] = bdasSeq;
    data["ptNm"] = ptNm;
    data["gndr"] = gndr;
    data["dstr1Cd"] = dstr1Cd;
    data["dstr2Cd"] = dstr2Cd;
    data["telno"] = telno;
    data["natiCd"] = natiCd;
    data["statCd"] = statCd;
    data["statCdNm"] = statCdNm;
    data["updtDttm"] = updtDttm;
    data["age"] = age;
    data["tagList"] = tagList;
    data['dstr1CdNm'] = dstr1CdNm;
    data['dstr2CdNm'] = dstr2CdNm;
    data['mpno'] = mpno;
    data['chrgInstId'] = chrgInstId;
    data['hospNm'] = hospNm;

    return data;
  }
}
