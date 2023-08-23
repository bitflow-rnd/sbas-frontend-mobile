class UserContact {
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
  String? attcId;
  String? userStatCd;
  String? aprvUserId;
  String? aprvDttm;
  String? btDt;
  int? pwErrCnt;
  String? authCd;
  String? rgstUserId;
  String? rgstDttm;
  String? updtUserId;
  String? updtDttm;

  UserContact({
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
    this.attcId,
    this.userStatCd,
    this.aprvUserId,
    this.aprvDttm,
    this.btDt,
    this.pwErrCnt,
    this.authCd,
    this.rgstUserId,
    this.rgstDttm,
    this.updtUserId,
    this.updtDttm,
  });

  UserContact.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        pw = json['pw'] as String?,
        userNm = json['userNm'] as String?,
        userCi = json['userCi'] as String?,
        pushKey = json['pushKey'] as String?,
        gndr = json['gndr'] as String?,
        telno = json['telno'] as String?,
        jobCd = json['jobCd'] as String?,
        ocpCd = json['ocpCd'] as String?,
        ptTypeCd = json['ptTypeCd'] as String?,
        instTypeCd = json['instTypeCd'] as String?,
        instId = json['instId'] as String?,
        instNm = json['instNm'] as String?,
        dutyDstr1Cd = json['dutyDstr1Cd'] as String?,
        dutyDstr2Cd = json['dutyDstr2Cd'] as String?,
        attcId = json['attcId'] as String?,
        userStatCd = json['userStatCd'] as String?,
        aprvUserId = json['aprvUserId'] as String?,
        aprvDttm = json['aprvDttm'] as String?,
        btDt = json['btDt'] as String?,
        pwErrCnt = json['pwErrCnt'] as int?,
        authCd = json['authCd'] as String?,
        rgstUserId = json['rgstUserId'] as String?,
        rgstDttm = json['rgstDttm'] as String?,
        updtUserId = json['updtUserId'] as String?,
        updtDttm = json['updtDttm'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'pw': pw,
        'userNm': userNm,
        'userCi': userCi,
        'pushKey': pushKey,
        'gndr': gndr,
        'telno': telno,
        'jobCd': jobCd,
        'ocpCd': ocpCd,
        'ptTypeCd': ptTypeCd,
        'instTypeCd': instTypeCd,
        'instId': instId,
        'instNm': instNm,
        'dutyDstr1Cd': dutyDstr1Cd,
        'dutyDstr2Cd': dutyDstr2Cd,
        'attcId': attcId,
        'userStatCd': userStatCd,
        'aprvUserId': aprvUserId,
        'aprvDttm': aprvDttm,
        'btDt': btDt,
        'pwErrCnt': pwErrCnt,
        'authCd': authCd,
        'rgstUserId': rgstUserId,
        'rgstDttm': rgstDttm,
        'updtUserId': updtUserId,
        'updtDttm': updtDttm
      };
}
