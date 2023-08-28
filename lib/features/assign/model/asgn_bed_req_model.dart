class AsgnBdReqModel {
  String? ptId;
  int? bdasSeq;
  int? asgnReqSeq;
  String? aprvYn;
  String? hospId;
  String? msg;

  AsgnBdReqModel({
    this.ptId,
    this.bdasSeq,
    this.asgnReqSeq,
    this.aprvYn,
    this.hospId,
    this.msg,
  });

  AsgnBdReqModel.fromJson(Map<String, dynamic> json)
      : ptId = json['ptId'] as String?,
        bdasSeq = json['bdasSeq'] as int?,
        asgnReqSeq = json['asgnReqSeq'] as int?,
        aprvYn = json['aprvYn'] as String?,
        hospId = json['hospId'] as String?,
        msg = json['msg'] as String?;

  Map<String, dynamic> toJson() => {'ptId': ptId, 'bdasSeq': bdasSeq, 'asgnReqSeq': asgnReqSeq, 'aprvYn': aprvYn, 'hospId': hospId, 'msg': msg};
}
