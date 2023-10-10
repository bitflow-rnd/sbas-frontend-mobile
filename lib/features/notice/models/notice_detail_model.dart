class NoticeDetailModel {
  String? title;
  String? content;
  bool? isActive;
  String? noticeType;
  String? startNoticeDt;
  String? startNoticeTm;
  String? endNoticeDt;
  String? endNoticeTm;
  bool? isUnlimited;
  String? attcGrpId;
  String? rgstUserId;
  String? rgstDttm;
  String? updtUserId;
  String? updtDttm;
  String? noticeId;

  NoticeDetailModel({
    this.title,
    this.content,
    this.isActive,
    this.noticeType,
    this.startNoticeDt,
    this.startNoticeTm,
    this.endNoticeDt,
    this.endNoticeTm,
    this.isUnlimited,
    this.attcGrpId,
    this.rgstUserId,
    this.rgstDttm,
    this.updtUserId,
    this.updtDttm,
    this.noticeId,
  });

  NoticeDetailModel.fromJson(Map<String, dynamic> json) {
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["content"] is String) {
      content = json["content"];
    }
    if (json["isActive"] is bool) {
      isActive = json["isActive"];
    }
    if (json["noticeType"] is String) {
      noticeType = json["noticeType"];
    }
    if (json["startNoticeDt"] is String) {
      startNoticeDt = json["startNoticeDt"];
    }
    if (json["startNoticeTm"] is String) {
      startNoticeTm = json["startNoticeTm"];
    }
    if (json["endNoticeDt"] is String) {
      endNoticeDt = json["endNoticeDt"];
    }
    if (json["endNoticeTm"] is String) {
      endNoticeTm = json["endNoticeTm"];
    }
    if (json["isUnlimited"] is bool) {
      isUnlimited = json["isUnlimited"];
    }
    if (json["attcGrpId"] is String) {
      attcGrpId = json["attcGrpId"];
    }
    if (json["rgstUserId"] is String) {
      rgstUserId = json["rgstUserId"];
    }
    if (json["rgstDttm"] is String) {
      rgstDttm = json["rgstDttm"];
    }
    if (json["updtUserId"] is String) {
      updtUserId = json["updtUserId"];
    }
    if (json["updtDttm"] is String) {
      updtDttm = json["updtDttm"];
    }
    if (json["noticeId"] is String) {
      noticeId = json["noticeId"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["title"] = title;
    data["content"] = content;
    data["isActive"] = isActive;
    data["noticeType"] = noticeType;
    data["startNoticeDt"] = startNoticeDt;
    data["startNoticeTm"] = startNoticeTm;
    data["endNoticeDt"] = endNoticeDt;
    data["endNoticeTm"] = endNoticeTm;
    data["isUnlimited"] = isUnlimited;
    data["attcGrpId"] = attcGrpId;
    data["rgstUserId"] = rgstUserId;
    data["rgstDttm"] = rgstDttm;
    data["updtUserId"] = updtUserId;
    data['updtDttm'] = updtDttm;
    data['noticeId'] = noticeId;

    return data;
  }
}