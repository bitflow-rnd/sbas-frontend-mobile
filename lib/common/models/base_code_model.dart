class BaseCodeModel {
  String? rgstUserId;
  String? rgstDttm;
  String? updtUserId;
  String? updtDttm;
  Id? id;
  String? cdGrpNm;
  String? cdNm;
  dynamic cdVal;
  int? cdSeq;
  String? rmk;

  BaseCodeModel(
      {this.rgstUserId,
      this.rgstDttm,
      this.updtUserId,
      this.updtDttm,
      this.id,
      this.cdGrpNm,
      this.cdNm,
      this.cdVal,
      this.cdSeq,
      this.rmk});

  BaseCodeModel.fromJson(Map<String, dynamic> json) {
    if (json["rgstUserId"] is String) {
      rgstUserId = json["rgstUserId"];
    }
    if (json["rgstDttm"] is String) {
      rgstDttm = json["rgstDttm"];
    }
    if (json["updtUserId"] is String) {
      updtUserId = json["updtUserId"];
    }
    if (json["updtDttm"] is String) {
      updtDttm = json["updtDttm"];
    }
    if (json["id"] is Map) {
      id = json["id"] == null ? null : Id.fromJson(json["id"]);
    }
    if (json["cdGrpNm"] is String) {
      cdGrpNm = json["cdGrpNm"];
    }
    if (json["cdNm"] is String) {
      cdNm = json["cdNm"];
    }
    cdVal = json["cdVal"];
    if (json["cdSeq"] is int) {
      cdSeq = json["cdSeq"];
    }
    if (json["rmk"] is String) {
      rmk = json["rmk"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["rgstUserId"] = rgstUserId;
    data["rgstDttm"] = rgstDttm;
    data["updtUserId"] = updtUserId;
    data["updtDttm"] = updtDttm;
    if (id != null) {
      data["id"] = id?.toJson();
    }
    data["cdGrpNm"] = cdGrpNm;
    data["cdNm"] = cdNm;
    data["cdVal"] = cdVal;
    data["cdSeq"] = cdSeq;
    data["rmk"] = rmk;
    return data;
  }
}

class Id {
  String? cdGrpId;
  String? cdId;

  Id({this.cdGrpId, this.cdId});

  Id.fromJson(Map<String, dynamic> json) {
    if (json["cdGrpId"] is String) {
      cdGrpId = json["cdGrpId"];
    }
    if (json["cdId"] is String) {
      cdId = json["cdId"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["cdGrpId"] = cdGrpId;
    data["cdId"] = cdId;
    return data;
  }
}
