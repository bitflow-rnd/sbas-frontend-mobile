class PatientTimelineModel {
  int? count;
  late List<TimeLine> items;

  PatientTimelineModel({
    this.count,
    required this.items,
  });

  PatientTimelineModel.fromJson(Map<String, dynamic> json) {
    if (json["count"] is int) {
      count = json["count"];
    }
    if (json["items"] is List) {
      items = (json["items"] as List).map((e) => TimeLine.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["count"] = count;
    data["items"] = items.map((e) => e.toJson()).toList();

    return data;
  }
}

class TimeLine {
  String? title;
  String? by;
  String? updtDttm;
  String? msg;
  String? timeLineStatus;
  String? chrgInstId;
  String? chrgUserId;
  int? asgnReqSeq;
  String? chrgInstNm;

  TimeLine({
    this.title,
    this.by,
    this.updtDttm,
    this.msg,
    this.timeLineStatus,
    this.chrgInstId,
    this.chrgUserId,
    this.asgnReqSeq,
    this.chrgInstNm,
  });

  TimeLine.fromJson(Map<String, dynamic> json) {
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["by"] is String) {
      by = json["by"];
    }
    if (json["updtDttm"] is String) {
      updtDttm = json["updtDttm"];
    }
    if (json["msg"] is String) {
      msg = json["msg"];
    }
    if (json["timeLineStatus"] is String) {
      timeLineStatus = json["timeLineStatus"];
    }
    if (json["chrgInstId"] is String) {
      chrgInstId = json["chrgInstId"];
    }
    if (json["chrgUserId"] is String) {
      chrgUserId = json["chrgUserId"];
    }
    if (json["asgnReqSeq"] is int) {
      asgnReqSeq = json["asgnReqSeq"];
    }
    if (json["chrgInstNm"] is String) {
      chrgInstNm = json["chrgInstNm"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["title"] = title;
    data["by"] = by;
    data["updtDttm"] = updtDttm;
    data["msg"] = msg;
    data["timeLineStatus"] = timeLineStatus;
    data["chrgInstId"] = chrgInstId;
    data["chrgUserId"] = chrgUserId;
    data["asgnReqSeq"] = asgnReqSeq;
    data["chrgInstNm"] = chrgInstNm;

    return data;
  }
}
