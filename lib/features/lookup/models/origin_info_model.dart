class OriginInfoModel {
  String? ptId;
  String? reqDstr1Cd;
  String? reqDstr2Cd;
  String? dprtDstrTypeCd;
  String? dprtDstrBascAddr;
  String? dprtDstrDetlAddr;
  String? dprtDstrZip;
  String? nok1Telno;
  String? nok2Telno;
  String? inhpAsgnYn;
  String? deptNm;
  String? spclNm;
  String? chrgTelno;
  String? msg;

  OriginInfoModel({
    this.ptId,
    this.reqDstr1Cd,
    this.reqDstr2Cd,
    this.dprtDstrTypeCd,
    this.dprtDstrBascAddr,
    this.dprtDstrDetlAddr,
    this.dprtDstrZip,
    this.nok1Telno,
    this.nok2Telno,
    this.inhpAsgnYn,
    this.deptNm,
    this.spclNm,
    this.chrgTelno,
    this.msg,
  });
  OriginInfoModel.fromJson(Map<String, dynamic> json) {
    if (json["ptId"] is String) {
      ptId = json["ptId"];
    }
    if (json["reqDstr1Cd"] is String) {
      reqDstr1Cd = json["reqDstr1Cd"];
    }
    if (json["reqDstr2Cd"] is String) {
      reqDstr2Cd = json["reqDstr2Cd"];
    }
    if (json["dprtDstrTypeCd"] is String) {
      dprtDstrTypeCd = json["dprtDstrTypeCd"];
    }
    if (json["dprtDstrBascAddr"] is String) {
      dprtDstrBascAddr = json["dprtDstrBascAddr"];
    }
    if (json["dprtDstrDetlAddr"] is String) {
      dprtDstrDetlAddr = json["dprtDstrDetlAddr"];
    }
    if (json["dprtDstrZip"] is String) {
      dprtDstrZip = json["dprtDstrZip"];
    }
    if (json["nok1Telno"] is String) {
      nok1Telno = json["nok1Telno"];
    }
    if (json["nok2Telno"] is String) {
      nok2Telno = json["nok2Telno"];
    }
    if (json["inhpAsgnYn"] is String) {
      inhpAsgnYn = json["inhpAsgnYn"];
    }
    if (json["deptNm"] is String) {
      deptNm = json["deptNm"];
    }
    if (json["spclNm"] is String) {
      spclNm = json["spclNm"];
    }
    if (json["chrgTelno"] is String) {
      chrgTelno = json["chrgTelno"];
    }
    if (json["msg"] is String) {
      msg = json["msg"];
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["ptId"] = ptId;
    data["reqDstr1Cd"] = reqDstr1Cd;
    data["reqDstr2Cd"] = reqDstr2Cd;
    data["dprtDstrTypeCd"] = dprtDstrTypeCd;
    data["dprtDstrBascAddr"] = dprtDstrBascAddr;
    data["dprtDstrDetlAddr"] = dprtDstrDetlAddr;
    data["dprtDstrZip"] = dprtDstrZip;
    data["nok1Telno"] = nok1Telno;
    data["nok2Telno"] = nok2Telno;
    data["inhpAsgnYn"] = inhpAsgnYn;
    data["deptNm"] = deptNm;
    data["spclNm"] = spclNm;
    data["chrgTelno"] = chrgTelno;
    data["msg"] = msg;

    return data;
  }
}
