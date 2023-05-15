class Patient {
  String? rgstUserId;
  String? rgstDttm;
  String? updtUserId;
  String? updtDttm;
  String? ptNm;
  String? gndr;
  String? rrno1;
  String? rrno2;
  String? dstr1Cd;
  String? dstr2Cd;
  String? addr;
  String? telno;
  String? natiCd;
  String? picaVer;
  String? dethYn;
  String? nokNm;
  String? mpno;
  String? job;
  String? attcId;
  String? bedStatCd;
  String? bedStatNm;
  String? bascAddr;
  String? detlAddr;
  String? zip;
  String? natiNm;
  String? ptId;

  Patient({
    this.bedStatCd,
    this.bedStatNm,
    this.rgstUserId,
    this.rgstDttm,
    this.updtUserId,
    this.updtDttm,
    this.ptNm,
    this.gndr,
    this.rrno1,
    this.rrno2,
    this.dstr1Cd,
    this.dstr2Cd,
    this.addr,
    this.telno,
    this.natiCd,
    this.picaVer,
    this.dethYn,
    this.nokNm,
    this.mpno,
    this.job,
    this.attcId,
    this.bascAddr,
    this.detlAddr,
    this.zip,
    this.natiNm,
    this.ptId,
  });

  Patient.fromJson(Map<String, dynamic> json) {
    if (json["bedStatCd"] is String) {
      bedStatCd = json["bedStatCd"];
    }
    if (json["bedStatNm"] is String) {
      bedStatNm = json["bedStatNm"];
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
    if (json["ptId"] is String) {
      ptId = json["ptId"];
    }
    if (json["ptNm"] is String) {
      ptNm = json["ptNm"];
    }
    if (json["gndr"] is String) {
      gndr = json["gndr"];
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
    if (json["addr"] is String) {
      addr = json["addr"];
    }
    if (json["telno"] is String) {
      telno = json["telno"];
    }
    if (json["natiCd"] is String) {
      natiCd = json["natiCd"];
    }
    if (json["picaVer"] is String) {
      picaVer = json["picaVer"];
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
    if (json["attcId"] is String) {
      attcId = json["attcId"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["rgstUserId"] = rgstUserId;
    data["rgstDttm"] = rgstDttm;
    data["updtUserId"] = updtUserId;
    data["updtDttm"] = updtDttm;
    data['bascAddr'] = bascAddr;
    data['detlAddr'] = detlAddr;
    data['zip'] = zip;
    data['natiNm'] = natiNm;
    data['ptId'] = ptId;
    data["ptNm"] = ptNm;
    data["gndr"] = gndr;
    data["rrno1"] = rrno1;
    data["rrno2"] = rrno2;
    data["dstr1Cd"] = dstr1Cd;
    data["dstr2Cd"] = dstr2Cd;
    data["addr"] = addr;
    data["telno"] = telno;
    data["natiCd"] = natiCd;
    data["picaVer"] = picaVer;
    data["dethYn"] = dethYn;
    data["nokNm"] = nokNm;
    data["mpno"] = mpno;
    data["job"] = job;
    data["attcId"] = attcId;
    data['bedStatCd'] = bedStatCd;
    data['bedStatNm'] = bedStatNm;

    return data;
  }
}