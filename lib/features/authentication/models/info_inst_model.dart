class InfoInstModel {
  String? rgstUserId;
  String? rgstDttm;
  String? updtUserId;
  String? updtDttm;
  String? id;
  String? instId;
  String? instTypeCd;
  String? instNm;
  String? dstr1Cd;
  String? dstr2Cd;
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
    this.dstr1Cd,
    this.dstr2Cd,
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
    if (json["dstr1Cd"] is String) {
      dstr1Cd = json["dstr1Cd"];
    }
    if (json["dstr2Cd"] is String) {
      dstr2Cd = json["dstr2Cd"];
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
    data["dstr1Cd"] = dstr1Cd;
    data["dstr2Cd"] = dstr2Cd;
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
