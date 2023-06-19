class BaseCodeModel {
  String? cdGrpId;
  String? cdGrpNm;
  String? cdId;
  String? cdNm;
  String? cdVal;
  int? cdSeq;
  String? rmk;

  BaseCodeModel({
    this.cdGrpId,
    this.cdGrpNm,
    this.cdId,
    this.cdNm,
    this.cdVal,
    this.cdSeq,
    this.rmk,
  });
  BaseCodeModel.fromJson(Map<String, dynamic> json) {
    if (json["cdGrpId"] is String) {
      cdGrpId = json["cdGrpId"];
    }
    if (json["cdGrpNm"] is String) {
      cdGrpNm = json["cdGrpNm"];
    }
    if (json["cdId"] is String) {
      cdId = json["cdId"];
    }
    if (json["cdNm"] is String) {
      cdNm = json["cdNm"];
    }
    if (json["cdVal"] is String) {
      cdVal = json["cdVal"];
    }
    if (json["cdSeq"] is int) {
      cdSeq = json["cdSeq"];
    }
    if (json["rmk"] is String) {
      rmk = json["rmk"];
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["cdGrpId"] = cdGrpId;
    data["cdGrpNm"] = cdGrpNm;
    data["cdId"] = cdId;
    data["cdNm"] = cdNm;
    data["cdVal"] = cdVal;
    data["cdSeq"] = cdSeq;
    data["rmk"] = rmk;
    return data;
  }
}