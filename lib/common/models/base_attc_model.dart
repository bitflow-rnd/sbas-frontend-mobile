class BaseAttcModel {
  late String attcId;
  late String attcGrpId;
  late String attcDt;
  late String attcTm;
  late String fileTypeCd;
  late String fileNm;
  late String loclPath;
  late String uriPath;
  late String privYn;
  String? rmk;
  late String rgstUserId;
  late String rgstDttm;
  late String updtUserId;
  late String updtDttm;

  BaseAttcModel({
    required this.attcId,
    required this.attcGrpId,
    required this.attcDt,
    required this.attcTm,
    required this.fileTypeCd,
    required this.fileNm,
    required this.loclPath,
    required this.uriPath,
    required this.privYn,
    this.rmk,
    required this.rgstUserId,
    required this.rgstDttm,
    required this.updtUserId,
    required this.updtDttm,
  });

  BaseAttcModel.fromJson(Map<String, dynamic> json) {
    if (json["attcId"] is String) {
      attcId = json["attcId"];
    }
    if (json["attcGrpId"] is String) {
      attcGrpId = json["attcGrpId"];
    }
    if (json["attcDt"] is String) {
      attcDt = json["attcDt"];
    }
    if (json["attcTm"] is String) {
      attcTm = json["attcTm"];
    }
    if (json["fileTypeCd"] is String) {
      fileTypeCd = json["fileTypeCd"];
    }
    if (json["fileNm"] is String) {
      fileNm = json["fileNm"];
    }
    if (json["loclPath"] is String) {
      loclPath = json["loclPath"];
    }
    if (json["uriPath"] is String) {
      uriPath = json["uriPath"];
    }
    if (json["privYn"] is String) {
      privYn = json["privYn"];
    }
    if (json["rmk"] is String) {
      rmk = json["rmk"];
    }
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["attcId"] = attcId;
    data["attcGrpId"] = attcGrpId;
    data["attcDt"] = attcDt;
    data["attcTm"] = attcTm;
    data["fileTypeCd"] = fileTypeCd;
    data["fileNm"] = fileNm;
    data["loclPath"] = loclPath;
    data["uriPath"] = uriPath;
    data["privYn"] = privYn;
    data["rmk"] = rmk;
    data["rgstUserId"] = rgstUserId;
    data["rgstDttm"] = rgstDttm;
    data["updtUserId"] = updtUserId;
    data["updtDttm"] = updtDttm;

    return data;
  }
}
