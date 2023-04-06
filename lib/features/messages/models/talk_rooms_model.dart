class TalkRoomsModel {
  final String? tkrmId;
  final String? tkrmNm;
  final String? msg;
  final String? rgstDttm;

  const TalkRoomsModel({
    this.tkrmId,
    this.tkrmNm,
    this.msg,
    this.rgstDttm,
  });

  TalkRoomsModel.empty()
      : tkrmId = '',
        tkrmNm = '',
        msg = '',
        rgstDttm = '';

  Map<String, Object?> toJson() {
    return {
      'tkrmId': tkrmId,
      'tkrmNm': tkrmNm,
      'msg': msg,
      'rgstDttm': rgstDttm
    };
  }

  static TalkRoomsModel fromJson(Map<String, Object?> json) {
    return TalkRoomsModel(
        tkrmId: json['tkrmId'] == null ? null : json['tkrmId'] as String,
        tkrmNm: json['tkrmNm'] == null ? null : json['tkrmNm'] as String,
        msg: json['msg'] == null ? null : json['msg'] as String,
        rgstDttm: json['rgstDttm'] == null ? null : json['rgstDttm'] as String);
  }
}
