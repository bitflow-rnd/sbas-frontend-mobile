class UserRegModel {
  String? id;
  String? pw;
  String? userNm;
  String? userCi;
  String? pushKey;
  String? gndr;
  String? telno;
  String? jobCd;
  String? ocpCd;
  String? ptTypeCd;
  String? instTypeCd;
  String? instId;
  String? instNm;
  String? dutyDstr1Cd;
  String? dutyDstr2Cd;
  String? dutyAddr;
  String? attcId;
  String? statClas;
  String? btDt;

  UserRegModel({
    this.id,
    this.pw,
    this.userNm,
    this.userCi,
    this.pushKey,
    this.gndr,
    this.telno,
    this.jobCd,
    this.ocpCd,
    this.ptTypeCd,
    this.instTypeCd,
    this.instId,
    this.instNm,
    this.dutyDstr1Cd,
    this.dutyDstr2Cd,
    this.dutyAddr,
    this.attcId,
    this.statClas,
    this.btDt,
  });

  UserRegModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["pw"] is String) {
      pw = json["pw"];
    }
    if (json["userNm"] is String) {
      userNm = json["userNm"];
    }
    if (json["userCi"] is String) {
      userCi = json["userCi"];
    }
    if (json["pushKey"] is String) {
      pushKey = json["pushKey"];
    }
    if (json["gndr"] is String) {
      gndr = json["gndr"];
    }
    if (json["telno"] is String) {
      telno = json["telno"];
    }
    if (json["jobCd"] is String) {
      jobCd = json["jobCd"];
    }
    if (json["ocpCd"] is String) {
      ocpCd = json["ocpCd"];
    }
    if (json["ptTypeCd"] is String) {
      ptTypeCd = json["ptTypeCd"];
    }
    if (json["instTypeCd"] is String) {
      instTypeCd = json["instTypeCd"];
    }
    if (json["instId"] is String) {
      instId = json["instId"];
    }
    if (json["instNm"] is String) {
      instNm = json["instNm"];
    }
    if (json["dutyDstr1Cd"] is String) {
      dutyDstr1Cd = json["dutyDstr1Cd"];
    }
    if (json["dutyDstr2Cd"] is String) {
      dutyDstr2Cd = json["dutyDstr2Cd"];
    }
    if (json["dutyAddr"] is String) {
      dutyAddr = json["dutyAddr"];
    }
    if (json["attcId"] is String) {
      attcId = json["attcId"];
    }
    if (json["statClas"] is String) {
      statClas = json["statClas"];
    }
    if (json["btDt"] is String) {
      btDt = json["btDt"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["id"] = id;
    data["pw"] = pw;
    data["userNm"] = userNm;
    data["userCi"] = userCi;
    data["pushKey"] = pushKey;
    data["gndr"] = gndr;
    data["telno"] = telno;
    data["jobCd"] = jobCd;
    data["ocpCd"] = ocpCd;
    data["ptTypeCd"] = ptTypeCd;
    data["instTypeCd"] = instTypeCd;
    data["instId"] = instId;
    data["instNm"] = instNm;
    data["dutyDstr1Cd"] = dutyDstr1Cd;
    data["dutyDstr2Cd"] = dutyDstr2Cd;
    data["dutyAddr"] = dutyAddr;
    data["attcId"] = attcId;
    data["statClas"] = statClas;
    data["btDt"] = btDt;

    return data;
  }
}
