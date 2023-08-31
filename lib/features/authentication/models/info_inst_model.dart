class InfoInstModel {
  String? rgstUserId;
  String? rgstDttm;
  String? updtUserId;
  String? updtDttm;
  String? id;
  String? instId;
  String? instTypeCd;
  String? instNm;
  String? dstrCd1;
  String? dstrCd2;
  String? chrgUserId;
  String? chrgTelno;
  String? chrgNm;
  String? baseAddr;
  String? lat;
  String? lon;
  String? rmk;
  String? attcId;

  InfoInstModel({
    this.rgstUserId,
    this.rgstDttm,
    this.updtUserId,
    this.updtDttm,
    this.id,
    this.instId,
    this.instTypeCd,
    this.instNm,
    this.dstrCd1,
    this.dstrCd2,
    this.chrgUserId,
    this.chrgNm,
    this.chrgTelno,
    this.baseAddr,
    this.lat,
    this.lon,
    this.rmk,
    this.attcId,
  });

  InfoInstModel.fromJson(Map<String, dynamic> json) {
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
    if (json["instId"] is String) {
      instId = json["instId"];
    }
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["instTypeCd"] is String) {
      instTypeCd = json["instTypeCd"];
    }
    if (json["instNm"] is String) {
      instNm = json["instNm"];
    }
    if (json["dstrCd1"] is String) {
      dstrCd1 = json["dstrCd1"];
    }
    if (json["dstrCd2"] is String) {
      dstrCd2 = json["dstrCd2"];
    }
    if (json["chrgUserId"] is String) {
      chrgUserId = json["chrgUserId"];
    }
    chrgNm = json["chrgNm"];
    if (json["chrgTelno"] is String) {
      chrgTelno = json["chrgTelno"];
    }
    baseAddr = json["baseAddr"];
    lat = json["lat"];
    lon = json["lon"];
    rmk = json["rmk"];
    attcId = json["attcId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["rgstUserId"] = rgstUserId;
    data["rgstDttm"] = rgstDttm;
    data["updtUserId"] = updtUserId;
    data["updtDttm"] = updtDttm;
    data["id"] = id;
    data["instTypeCd"] = instTypeCd;
    data["instNm"] = instNm;
    data["dstrCd1"] = dstrCd1;
    data["dstrCd2"] = dstrCd2;
    data["chrgUserId"] = chrgUserId;
    data["chrgNm"] = chrgNm;
    data["chrgTelno"] = chrgTelno;
    data["baseAddr"] = baseAddr;
    data["lat"] = lat;
    data["lon"] = lon;
    data["rmk"] = rmk;
    data["attcId"] = attcId;
    return data;
  }
}
