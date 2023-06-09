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
      items = (json["items"] as List)
          .map((e) => TimeLine.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String ,dynamic> data = <String, dynamic>{};

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

  TimeLine({
    this.title,
    this.by,
    this.updtDttm,
    this.msg,
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
  }

  Map<String, dynamic> toJson() {
    final Map<String ,dynamic> data = <String, dynamic>{};

    data["title"] = title;
    data["by"] = by;
    data["updtDttm"] = updtDttm;
    data["msg"] = msg;

    return data;
  }
}
