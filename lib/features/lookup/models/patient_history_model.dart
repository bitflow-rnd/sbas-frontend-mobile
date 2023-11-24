class PatientHistoryModel {
  String? ptId;
  int? bdasSeq;
  String? bedStatCd;
  String? bedStatCdNm;
  String? diagNm;
  String? hospNm;
  String? updtDttm;
  String? order;
  List<String>? tagList;

  PatientHistoryModel({
    this.ptId,
    this.bdasSeq,
    this.bedStatCd,
    this.bedStatCdNm,
    this.diagNm,
    this.hospNm,
    this.updtDttm,
    this.order,
    this.tagList,
  });

  PatientHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json["ptId"] is String) {
      ptId = json["ptId"];
    }
    if (json["bdasSeq"] is int) {
      bdasSeq = json["bdasSeq"];
    }
    if (json["bedStatCd"] is String) {
      bedStatCd = json["bedStatCd"];
    }
    if (json["bedStatCdNm"] is String) {
      bedStatCdNm = json["bedStatCdNm"];
    }
    if (json["diagNm"] is String) {
      diagNm = json["diagNm"];
    }
    if (json["hospNm"] is String) {
      hospNm = json["hospNm"];
    }
    if (json["updtDttm"] is String) {
      updtDttm = json["updtDttm"];
    }
    if (json["order"] is String) {
      order = json["order"];
    }
    if (json["tagList"] is List) {
      tagList = List<String>.from(json["tagList"]);
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["ptId"] = ptId;
    data["bdasSeq"] = bdasSeq;
    data["bedStatCd"] = bedStatCd;
    data["bedStatCdNm"] = bedStatCdNm;
    data["diagNm"] = diagNm;
    data["hospNm"] = hospNm;
    data["updtDttm"] = updtDttm;
    data["order"] = order;
    data["tagList"] = tagList;

    return data;
  }
}

class PatientHistoryList {
  int? count;
  late List<PatientHistoryModel> items;

  PatientHistoryList({
    this.count,
    required this.items,
  });

  PatientHistoryList.fromJson(Map<String, dynamic> json) {
    if (json["count"] is int) {
      count = json["count"];
    }
    if (json["items"] is List) {
      items = (json["items"] as List).map((e) => PatientHistoryModel.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["count"] = count;
    data["items"] = items.map((e) => e.toJson()).toList();

    return data;
  }
}