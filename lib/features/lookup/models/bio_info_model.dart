class BioInfoModel {
  String? avpu;
  String? o2Apply;
  double? bdTemp;
  double? pulse;
  double? breath;
  double? spo2;
  double? sbp;
  int? score;

  BioInfoModel({
    this.avpu,
    this.o2Apply,
    this.bdTemp,
    this.pulse,
    this.breath,
    this.spo2,
    this.sbp,
    this.score,
  });
  BioInfoModel.fromJson(Map<String, dynamic> json) {
    if (json["avpu"] is String) {
      avpu = json["avpu"];
    }
    if (json["o2Apply"] is String) {
      o2Apply = json["o2Apply"];
    }
    if (json["bdTemp"] is double) {
      bdTemp = json["bdTemp"];
    }
    if (json["pulse"] is double) {
      pulse = json["pulse"];
    }
    if (json["breath"] is double) {
      breath = json["breath"];
    }
    if (json["spo2"] is double) {
      spo2 = json["spo2"];
    }
    if (json["sbp"] is double) {
      sbp = json["sbp"];
    }
    if (json['score'] is int) {
      score = json['score'];
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["avpu"] = avpu;
    data["o2Apply"] = o2Apply;
    data["bdTemp"] = bdTemp;
    data["pulse"] = pulse;
    data["breath"] = breath;
    data["spo2"] = spo2;
    data["sbp"] = sbp;
    data['score'] = score;

    return data;
  }
}
