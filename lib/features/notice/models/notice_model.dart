class NoticeList {
  String? noticeId;
  String? title;
  String? content;
  String? noticeType;
  String? startNoticeDt;
  bool? isRead;

  NoticeList({
    this.noticeId,
    this.title,
    this.content,
    this.noticeType,
    this.startNoticeDt,
    this.isRead,
  });

  NoticeList.fromJson(Map<String, dynamic> json) {
    if (json["noticeId"] is String) {
      noticeId = json["noticeId"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["content"] is String) {
      content = json["content"];
    }
    if (json["noticeType"] is String) {
      noticeType = json["noticeType"];
    }
    if (json["startNoticeDt"] is String) {
      startNoticeDt = json["startNoticeDt"];
    }
    if (json["isRead"] is bool) {
      isRead = json["isRead"];
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['noticeId'] = noticeId;
    data['title'] = title;
    data["content"] = content;
    data["noticeType"] = noticeType;
    data["startNoticeDt"] = startNoticeDt;
    data["isRead"] = isRead;

    return data;
  }
}