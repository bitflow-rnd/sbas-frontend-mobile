class RegNoticeRequestModel {
  String? title;
  String? content;
  bool? isActive;
  String? noticeType;
  String? startNoticeDt;
  String? startNoticeTm;
  String? endNoticeDt;
  String? endNoticeTm;
  bool? isUnlimited;

  RegNoticeRequestModel({
    this.title,
    this.content,
    this.isActive,
    this.noticeType,
    this.startNoticeDt,
    this.startNoticeTm,
    this.endNoticeDt,
    this.endNoticeTm,
    this.isUnlimited,
  });

  RegNoticeRequestModel.fromJson(Map<String, dynamic> json) {
    if (json['title'] is String) {
      title = json['title'];
    }
    if (json['content'] is String) {
      content = json['content'];
    }
    if (json['isActive'] is bool) {
      isActive = json['isActive'];
    }
    if (json['noticeType'] is String) {
      noticeType = json['noticeType'];
    }
    if (json['startNoticeDt'] is String) {
      startNoticeDt = json['startNoticeDt'];
    }
    if (json['startNoticeTm'] is String) {
      startNoticeTm = json['startNoticeTm'];
    }
    if (json['endNoticeDt'] is String) {
      endNoticeDt = json['endNoticeDt'];
    }
    if (json['endNoticeTm'] is String) {
      endNoticeTm = json['endNoticeTm'];
    }
    if (json['isUnlimited'] is bool) {
      isUnlimited = json['isUnlimited'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['title'] = title;
    data['content'] = content;
    data['isActive'] = isActive;
    data['noticeType'] = noticeType;
    data['startNoticeDt'] = startNoticeDt;
    data['startNoticeTm'] = startNoticeTm;
    data['endNoticeDt'] = endNoticeDt;
    data['endNoticeTm'] = endNoticeTm;
    data['isUnlimited'] = isUnlimited;

    return data;
  }
}
