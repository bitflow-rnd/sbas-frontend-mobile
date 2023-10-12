class NoticeList {
  late String noticeId;
  late String title;
  late String content;
  late String noticeType;
  late String startNoticeDt;
  late bool isRead;
  late bool hasFile;

  NoticeList({
    required this.noticeId,
    required this.title,
    required this.content,
    required this.noticeType,
    required this.startNoticeDt,
    required this.isRead,
    required this.hasFile,
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
    if (json["hasFile"] is bool) {
      hasFile = json["hasFile"];
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
    data["hasFile"] = hasFile;

    return data;
  }
}