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
      items = (json["items"] as List)
          .map((e) => AvailableHospital.fromJson(e))
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

class AvailableHospital {
  String? hospId;
  String? hospNm;
  String? distance;
  String? addr;
  List<String>? tagList;

  AvailableHospital({
    this.hospId,
    this.hospNm,
    this.distance,
    this.addr,
    this.tagList,
  });
  AvailableHospital.fromJson(Map<String, dynamic> json) {
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
    if (json["tagList"] is List) {
      tagList =
          json["tagList"] == null ? null : List<String>.from(json["tagList"]);
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['hospId'] = hospId;
    data["hospNm"] = hospNm;
    data["distance"] = distance;
    data["addr"] = addr;

    if (tagList != null) {
      data["tagList"] = tagList;
    }
    return data;
  }
}
