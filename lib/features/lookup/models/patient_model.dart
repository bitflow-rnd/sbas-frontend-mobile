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
  //  추가
  int? bdasSeq;
  String? dstr1CdNm;
  String? dstr2CdNm;
  dynamic hospId;
  String? hospNm;
  int? age;
  String? bedStatCdNm;
  List<String>? tagList;
  List<String>? undrDsesCd;
  List<String>? undrDsesCdNm;

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
    //추가
    this.bdasSeq,
    this.dstr1CdNm,
    this.dstr2CdNm,
    this.hospId,
    this.hospNm,
    this.age,
    this.bedStatCdNm,
    this.tagList,
    this.undrDsesCd,
    this.undrDsesCdNm,
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
    //추가

    if (json['bdasSeq'] is String) {
      bdasSeq = json['bdasSeq'];
    }
    if (json['dstr1CdNm'] is String) {
      dstr1CdNm = json['dstr1CdNm'];
    }
    if (json['dstr2CdNm'] is String) {
      dstr2CdNm = json['dstr2CdNm'];
    }
    if (json['hospId'] is String) {
      hospId = json['hospId'];
    }
    if (json['hospNm'] is String) {
      hospNm = json['hospNm'];
    }
    if (json['age'] is int) {
      age = json['age'];
    }
    if (json['bedStatCdNm'] is String) {
      bedStatCdNm = json['bedStatCdNm'];
    }
    tagList = (json['tagList'] as List?)?.map((dynamic e) => e as String).toList();
    undrDsesCd = (json['undrDsesCd'] as List?)?.map((dynamic e) => e as String).toList();
    undrDsesCdNm = (json['undrDsesCdNm'] as List?)?.map((dynamic e) => e as String).toList();
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
    //추가
    data['bdasSeq'] = bdasSeq;
    data['dstr1CdNm'] = dstr1CdNm;
    data['dstr2CdNm'] = dstr2CdNm;
    data['hospId'] = hospId;
    data['hospNm'] = hospNm;
    data['age'] = age;
    data['bedStatCdNm'] = bedStatCdNm;
    data['tagList'] = tagList;
    data['undrDsesCd'] = undrDsesCd;
    data['undrDsesCdNm'] = undrDsesCdNm;

    return data;
  }
}
