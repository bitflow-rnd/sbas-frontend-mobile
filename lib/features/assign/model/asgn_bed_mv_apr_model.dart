class AsgnBdMvAprReq {
  String? ptId;
  int? bdasSeq;
  String? instId;
  String? ambsNm;
  String? chfTelno;
  String? crew1Id;
  String? crew1Pstn;
  String? crew1Nm;
  String? crew1Telno;
  String? crew2Id;
  String? crew2Pstn;
  String? crew2Nm;
  String? crew2Telno;
  String? crew3Id;
  String? crew3Pstn;
  String? crew3Nm;
  String? crew3Telno;
  String? vecno;
  String? msg;

  AsgnBdMvAprReq({
    this.ptId,
    this.bdasSeq,
    this.instId,
    this.ambsNm,
    this.chfTelno,
    this.crew1Id,
    this.crew1Pstn,
    this.crew1Nm,
    this.crew1Telno,
    this.crew2Id,
    this.crew2Pstn,
    this.crew2Nm,
    this.crew2Telno,
    this.crew3Id,
    this.crew3Pstn,
    this.crew3Nm,
    this.crew3Telno,
    this.vecno,
    this.msg,
  });

  void clear() {
    ptId = '';
    bdasSeq = 0;
    instId = null;
    ambsNm = null;
    chfTelno = null;
    crew1Id = null;
    crew1Pstn = null;
    crew1Nm = null;
    crew1Telno = null;
    crew2Id = null;
    crew2Pstn = null;
    crew2Nm = null;
    crew2Telno = null;
    crew3Id = null;
    crew3Pstn = null;
    crew3Nm = null;
    crew3Telno = null;
    vecno = null;
    msg = '';
  }

  AsgnBdMvAprReq.fromJson(Map<String, dynamic> json)
      : ptId = json['ptId'] as String?,
        bdasSeq = json['bdasSeq'] as int?,
        instId = json['instId'] as String?,
        ambsNm = json['ambsNm'] as String?,
        chfTelno = json['chfTelno'] as String?,
        crew1Id = json['crew1Id'] as String?,
        crew1Pstn = json['crew1Pstn'] as String?,
        crew1Nm = json['crew1Nm'] as String?,
        crew1Telno = json['crew1Telno'] as String?,
        crew2Id = json['crew2Id'] as String?,
        crew2Pstn = json['crew2Pstn'] as String?,
        crew2Nm = json['crew2Nm'] as String?,
        crew2Telno = json['crew2Telno'] as String?,
        crew3Id = json['crew3Id'] as String?,
        crew3Pstn = json['crew3Pstn'] as String?,
        crew3Nm = json['crew3Nm'] as String?,
        crew3Telno = json['crew3Telno'] as String?,
        vecno = json['vecno'] as String?,
        msg = json['msg'] as String?;

  Map<String, dynamic> toJson() => {
        'ptId': ptId,
        'bdasSeq': bdasSeq,
        'instId': instId,
        'ambsNm': ambsNm,
        'chfTelno': chfTelno,
        'crew1Id': crew1Id,
        'crew1Pstn': crew1Pstn,
        'crew1Nm': crew1Nm,
        'crew1Telno': crew1Telno,
        'crew2Id': crew2Id,
        'crew2Pstn': crew2Pstn,
        'crew2Nm': crew2Nm,
        'crew2Telno': crew2Telno,
        'crew3Id': crew3Id,
        'crew3Pstn': crew3Pstn,
        'crew3Nm': crew3Nm,
        'crew3Telno': crew3Telno,
        'vecno': vecno,
        'msg': msg
      };
}
