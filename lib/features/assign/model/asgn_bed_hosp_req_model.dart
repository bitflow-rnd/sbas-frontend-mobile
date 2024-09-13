class AsgnBdHospReq {
  String? ptId;
  int? bdasSeq;
  String? hospId;
  String? pid;
  String? deptNm;
  String? wardNm;
  String? roomNm;
  String? spclNm;
  String? chrgTelno;
  String? dschRsnCd;
  String? msg;
  String? admsStatCd;

  void clear() {
    ptId = null;
    bdasSeq = null;
    hospId = null;
    pid = null;
    deptNm = null;
    wardNm = null;
    roomNm = null;
    spclNm = null;
    chrgTelno = null;
    dschRsnCd = null;
    msg = null;
    admsStatCd = null;
  }

  AsgnBdHospReq({
    this.ptId,
    this.bdasSeq,
    this.hospId,
    this.pid,
    this.deptNm,
    this.wardNm,
    this.roomNm,
    this.spclNm,
    this.chrgTelno,
    this.dschRsnCd,
    this.msg,
    this.admsStatCd,
  });

  AsgnBdHospReq.fromJson(Map<String, dynamic> json)
      : ptId = json['ptId'] as String?,
        bdasSeq = json['bdasSeq'] as int?,
        hospId = json['hospId'] as String?,
        pid = json['pid'] as String?,
        deptNm = json['deptNm'] as String?,
        wardNm = json['wardNm'] as String?,
        roomNm = json['roomNm'] as String?,
        spclNm = json['spclNm'] as String?,
        chrgTelno = json['chrgTelno'] as String?,
        dschRsnCd = json['dschRsnCd'] as String?,
        msg = json['msg'] as String?,
        admsStatCd = json['admsStatCd'] as String?;

  Map<String, dynamic> toJson() => {
        'ptId': ptId,
        'bdasSeq': bdasSeq,
        'hospId': hospId,
        'pid': pid,
        'deptNm': deptNm,
        'wardNm': wardNm,
        'roomNm': roomNm,
        'spclNm': spclNm,
        'chrgTelno': chrgTelno,
        'dschRsnCd': dschRsnCd,
        'msg': msg,
        'admsStatCd': admsStatCd
      };
}
