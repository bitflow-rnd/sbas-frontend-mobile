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
  String? hospId;
  String? chrgId;
  int? asgnReqSeq;

  TimeLine({
    this.title,
    this.by,
    this.updtDttm,
    this.msg,
    this.timeLineStatus,
    this.hospId,
    this.chrgId,
    this.asgnReqSeq,
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
    if (json["hospId"] is String) {
      hospId = json["hospId"];
    }
    if (json["chrgId"] is String) {
      chrgId = json["chrgId"];
    }
    if (json["asgnReqSeq"] is int) {
      asgnReqSeq = json["asgnReqSeq"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["title"] = title;
    data["by"] = by;
    data["updtDttm"] = updtDttm;
    data["msg"] = msg;
    data["timeLineStatus"] = timeLineStatus;
    data["hospId"] = hospId;
    data["chrgId"] = chrgId;
    data["asgnReqSeq"] = asgnReqSeq;

    return data;
  }
}
