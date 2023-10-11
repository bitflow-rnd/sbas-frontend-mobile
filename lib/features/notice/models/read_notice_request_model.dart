class ReadNoticeRequestModel {
  String? userId;
  String? noticeId;

  ReadNoticeRequestModel({
    this.userId,
    this.noticeId,
  });

  ReadNoticeRequestModel.fromJson(Map<String, dynamic> json) {
    if (json["userId"] is String) {
      userId = json["userId"];
    }
    if (json["noticeId"] is String) {
      noticeId = json["noticeId"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["userId"] = userId;
    data["noticeId"] = noticeId;

    return data;
  }
}
