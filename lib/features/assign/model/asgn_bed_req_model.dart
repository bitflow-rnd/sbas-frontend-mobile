class AsgnBdReqModel {
  String? ptId;
  int? bdasSeq;
  int? asgnReqSeq;
  String? aprvYn;
  String? hospId;
  dynamic negCd;
  String? msg;
  String? roomNm; //병실
  String? deptNm; //진료과
  String? spclNm; //담당의
  String? spclId;
  String? chrgTelno; //담당의 연락처

  AsgnBdReqModel({
    this.ptId,
    this.bdasSeq,
    this.asgnReqSeq,
    this.aprvYn,
    this.hospId,
    this.negCd,
    this.msg,
    this.roomNm,
    this.deptNm,
    this.spclNm,
    this.spclId,
    this.chrgTelno,
  });

  AsgnBdReqModel.fromJson(Map<String, dynamic> json)
      : ptId = json['ptId'] as String?,
        bdasSeq = json['bdasSeq'] as int?,
        asgnReqSeq = json['asgnReqSeq'] as int?,
        aprvYn = json['aprvYn'] as String?,
        hospId = json['hospId'] as String?,
        negCd = json['negCd'],
        msg = json['msg'] as String?,
        roomNm = json['roomNm'] as String?,
        deptNm = json['deptNm'] as String?,
        spclNm = json['spclNm'] as String?,
        spclId = json['spclId'] as String?,
        chrgTelno = json['chrgTelno'] as String?;

  Map<String, dynamic> toJson() => {
        'ptId': ptId,
        'bdasSeq': bdasSeq,
        'asgnReqSeq': asgnReqSeq,
        'aprvYn': aprvYn,
        'hospId': hospId,
        'negCd': negCd,
        'msg': msg,
        'roomNm': roomNm,
        'deptNm': deptNm,
        'spclNm': spclNm,
        'spclId': spclId,
        'chrgTelno': chrgTelno
      };
}
