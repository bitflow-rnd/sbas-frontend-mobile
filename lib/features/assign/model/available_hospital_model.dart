class AvailableHospitalModel {
  int? count;
  late List<AvailableHospital> items;

  AvailableHospitalModel({
    this.count,
    required this.items,
  });

  AvailableHospitalModel.fromJson(Map<String, dynamic> json) {
    if (json["count"] is int) {
      count = json["count"];
    }
    if (json["items"] is List) {
      items = (json["items"] as List).map((e) => AvailableHospital.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["count"] = count;
    data["items"] = items.map((e) => e.toJson()).toList();

    return data;
  }
}

class AvailableHospital {
  String? chrgInstId; //제거필요?
  String? hospId;
  String? hospNm;
  String? distance;
  String? addr;
  int? gnbdIcu;
  int? npidIcu;
  int? gnbdSvrt;
  int? gnbdSmsv;
  int? gnbdModr;
  List<String>? tagList;

  AvailableHospital({
    this.chrgInstId,
    this.hospNm,
    this.distance,
    this.addr,
    this.gnbdIcu,
    this.npidIcu,
    this.gnbdSvrt,
    this.gnbdSmsv,
    this.gnbdModr,
    this.tagList,
  });
  AvailableHospital.fromJson(Map<String, dynamic> json) {
    if (json["chrgInstId"] is String) {
      chrgInstId = json["chrgInstId"];
    }
    if (json["hospId"] is String) {
      hospId = json["hospId"];
    }
    if (json["hospNm"] is String) {
      hospNm = json["hospNm"];
    }
    if (json["distance"] is String) {
      distance = json["distance"];
    }
    if (json["addr"] is String) {
      addr = json["addr"];
    }
    if (json["gnbdIcu"] is int) {
      gnbdIcu = json["gnbdIcu"];
    }
    if (json["npidIcu"] is int) {
      npidIcu = json["npidIcu"];
    }
    if (json["gnbdSvrt"] is int) {
      gnbdSvrt = json["gnbdSvrt"];
    }
    if (json["gnbdSmsv"] is int) {
      gnbdSmsv = json["gnbdSmsv"];
    }
    if (json["gnbdModr"] is int) {
      gnbdModr = json["gnbdModr"];
    }
    if (json["tagList"] is List) {
      tagList = json["tagList"] == null ? null : List<String>.from(json["tagList"]);
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['hospId'] = chrgInstId;
    data['chrgInstId'] = chrgInstId;
    data["hospNm"] = hospNm;
    data["distance"] = distance;
    data["addr"] = addr;
    data["gnbdIcu"] = gnbdIcu;
    data["npidIcu"] = npidIcu;
    data["gnbdSvrt"] = gnbdSvrt;
    data["gnbdSmsv"] = gnbdSmsv;
    data["gnbdModr"] = gnbdModr;

    if (tagList != null) {
      data["tagList"] = tagList;
    }
    return data;
  }
}
