class ActiveNoticeRequestModel {
  String? noticeId;
  bool? isActive;

  ActiveNoticeRequestModel({
    this.noticeId,
    this.isActive,
  });

  ActiveNoticeRequestModel.fromJson(Map<String, dynamic> json) {
    if (json["noticeId"] is String) {
      noticeId = json["noticeId"];
    }
    if (json["isActive"] is String) {
      isActive = json["isActive"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["noticeId"] = noticeId;
    data["isActive"] = isActive;

    return data;
  }
}
