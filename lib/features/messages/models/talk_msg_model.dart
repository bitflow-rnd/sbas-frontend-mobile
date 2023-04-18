class TalkMsgModel {
  final TalkMsgId? id;
  final String? histCd;
  final String? msg;
  final String? attcId;

  const TalkMsgModel({
    this.id,
    this.histCd,
    this.msg,
    this.attcId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id?.toJson(),
      'histCd': histCd,
      'msg': msg,
      'attcId': attcId,
    };
  }

  static TalkMsgModel fromJson(Map<String, dynamic> json) {
    return TalkMsgModel(
        id: json['id'] == null ? null : TalkMsgId.fromJson(json['id'] as Map<String, dynamic>),
        histCd: json['histCd'] == null ? null : json['histCd'] as String,
        msg: json['msg'] == null ? null : json['msg'] as String,
        attcId: json['attcId'] == null ? null : json['attcId'] as String);
  }
}

class TalkMsgId {
  final String? tkrmId;
  final int? msgSeq;
  final int? histSeq;
  TalkMsgId({
    this.tkrmId,
    this.msgSeq,
    this.histSeq,
  });

  Map<String, Object?> toJson() {
    return {
      'tkrmId': tkrmId,
      'msgSeq': msgSeq,
      'histSeq': histSeq,
    };
  }

  static TalkMsgId fromJson(Map<String, dynamic> json) {
    return TalkMsgId(
        tkrmId: json['tkrmId'] == null ? null : json['tkrmId'] as String,
        msgSeq: json['msgSeq'] == null ? null : json['msgSeq'] as int,
        histSeq: json['histSeq'] == null ? null : json['histSeq'] as int);
  }
}
