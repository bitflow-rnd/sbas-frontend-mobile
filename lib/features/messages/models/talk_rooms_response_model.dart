class TalkRoomsResponseModel {
  final String? tkrmId;
  final String? tkrmNm;
  final String? msg;
  final String? rgstDttm;

  const TalkRoomsResponseModel({
    this.tkrmId,
    this.tkrmNm,
    this.msg,
    this.rgstDttm,
  });

  TalkRoomsResponseModel.empty()
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

  List<Map<String, Object?>> toArrJson(List<TalkRoomsResponseModel> models) {
    return models.map((model) => model.toJson()).toList();
  }

  static TalkRoomsResponseModel fromJson(Map<String, dynamic> json) {
    return TalkRoomsResponseModel(
        tkrmId: json['tkrmId'] == null ? null : json['tkrmId'] as String,
        tkrmNm: json['tkrmNm'] == null ? null : json['tkrmNm'] as String,
        msg: json['msg'] == null ? null : json['msg'] as String,
        rgstDttm: json['rgstDttm'] == null ? null : json['rgstDttm'] as String);
  }

  static List<TalkRoomsResponseModel> fromArrJson(List<dynamic> jsonList) {
    return jsonList
        .map((json) => TalkRoomsResponseModel.fromJson(json))
        .toList();
  }
}
