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
  dynamic chrgInstId;
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
    this.chrgInstId,
    this.hospNm,
    this.age,
    this.bedStatCdNm,
    this.tagList,
    this.undrDsesCd,
    this.undrDsesCdNm,
  });

  Patient.fromJson(Map<String, dynamic> json) {
    bedStatCd = json["bedStatCd"] as String?;
    bedStatNm = json["bedStatNm"] as String?;
    rgstUserId = json["rgstUserId"] as String?;
    rgstDttm = json["rgstDttm"] as String?;
    updtUserId = json["updtUserId"] as String?;
    updtDttm = json["updtDttm"] as String?;
    bascAddr = json["bascAddr"] as String?;
    detlAddr = json["detlAddr"] as String?;
    zip = json["zip"] as String?;
    natiNm = json["natiNm"] as String?;
    ptId = json["ptId"] as String?;
    ptNm = json["ptNm"] as String?;
    gndr = json["gndr"] as String?;
    rrno1 = json["rrno1"] as String?;
    rrno2 = json["rrno2"] as String?;
    dstr1Cd = json["dstr1Cd"] as String?;
    dstr2Cd = json["dstr2Cd"] as String?;
    addr = json["addr"] as String?;
    telno = json["telno"] as String?;
    natiCd = json["natiCd"] as String?;
    picaVer = json["picaVer"] as String?;
    dethYn = json["dethYn"] as String?;
    nokNm = json["nokNm"] as String?;
    mpno = json["mpno"] as String?;
    job = json["job"] as String?;
    attcId = json["attcId"] as String?;
    bdasSeq = json['bdasSeq'] as int?;
    dstr1CdNm = json['dstr1CdNm'] as String?;
    dstr2CdNm = json['dstr2CdNm'] as String?;
    chrgInstId = json['chrgInstId'];
    hospNm = json['hospNm'] as String?;
    age = json['age'] as int?;
    bedStatCdNm = json['bedStatCdNm'] as String?;
    tagList = (json['tagList'] as List?)?.map((e) => e as String).toList() ?? [];
    undrDsesCd = (json['undrDsesCd'] as List?)?.map((e) => e as String).toList() ?? [];
    undrDsesCdNm = (json['undrDsesCdNm'] as List?)?.map((e) => e as String).toList() ?? [];
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
    data['chrgInstId'] = chrgInstId;
    data['hospNm'] = hospNm;
    data['age'] = age;
    data['bedStatCdNm'] = bedStatCdNm;
    data['tagList'] = tagList;
    data['undrDsesCd'] = undrDsesCd;
    data['undrDsesCdNm'] = undrDsesCdNm;

    return data;
  }
}
