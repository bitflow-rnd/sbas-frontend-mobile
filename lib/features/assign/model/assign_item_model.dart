class AssignItemModel {
  String? ptId;
  int? bdasSeq;
  String? ptNm;
  String? gndr;
  int? age;
  String? bascAddr;
  String? updtDttm;
  String? diagNm;
  String? bedStatCd;
  String? bedStatCdNm;
  String? chrgInstNm;
  List<String>? tagList;
  String? inhpAsgnYn;

  AssignItemModel({
    this.ptId,
    this.bdasSeq,
    this.ptNm,
    this.gndr,
    this.age,
    this.bascAddr,
    this.updtDttm,
    this.diagNm,
    this.bedStatCd,
    this.bedStatCdNm,
    this.tagList,
    this.chrgInstNm,
    this.inhpAsgnYn,
  });
  AssignItemModel.fromJson(Map<String, dynamic> json) {
    if (json["chrgInstNm"] is String) {
      chrgInstNm = json["chrgInstNm"];
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
    if (json["age"] is int) {
      age = json["age"];
    }
    if (json["bascAddr"] is String) {
      bascAddr = json["bascAddr"];
    }
    if (json["updtDttm"] is String) {
      updtDttm = json["updtDttm"];
    }
    if (json["diagNm"] is String) {
      diagNm = json["diagNm"];
    }
    if (json["bedStatCd"] is String) {
      bedStatCd = json["bedStatCd"];
    }
    if (json["bedStatCdNm"] is String) {
      bedStatCdNm = json["bedStatCdNm"];
    }
    if (json["tagList"] is List) {
      tagList = json["tagList"] == null ? null : List<String>.from(json["tagList"]);
    }
    if (json["inhpAsgnYn"] is String) {
      inhpAsgnYn = json["inhpAsgnYn"];
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['chrgInstNm'] = chrgInstNm;
    data["ptId"] = ptId;
    data["bdasSeq"] = bdasSeq;
    data["ptNm"] = ptNm;
    data["gndr"] = gndr;
    data["age"] = age;
    data["bascAddr"] = bascAddr;
    data["updtDttm"] = updtDttm;
    data["diagNm"] = diagNm;
    data["bedStatCd"] = bedStatCd;
    data["bedStatCdNm"] = bedStatCdNm;

    if (tagList != null) {
      data["tagList"] = tagList;
    }
    data["inhpAsgnYn"] = inhpAsgnYn;
    return data;
  }
}
