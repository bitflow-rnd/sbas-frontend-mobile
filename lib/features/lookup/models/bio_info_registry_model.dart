class BioInfoRegistryModel {
  String? ptId;
  String? svrtIptTypeCd;
  String? avpuCd;
  String? oxyYn;
  double? bdtp;
  double? spo2;
  int? hr;
  int? resp;
  int? sbp;
  int? newsScore;
  String? svrtTypeCd;

  BioInfoRegistryModel({
    this.ptId,
    this.svrtIptTypeCd,
    this.avpuCd,
    this.oxyYn,
    this.bdtp,
    this.hr,
    this.resp,
    this.spo2,
    this.sbp,
    this.newsScore,
    this.svrtTypeCd,
  });
  BioInfoRegistryModel.fromJson(Map<String, dynamic> json) {
    if (json["ptId"] is String) {
      ptId = json["ptId"];
    }
    if (json["svrtIptTypeCd"] is String) {
      svrtIptTypeCd = json["svrtIptTypeCd"];
    }
    if (json["avpuCd"] is String) {
      avpuCd = json["avpuCd"];
    }
    if (json["oxyYn"] is String) {
      oxyYn = json["oxyYn"];
    }
    if (json["bdtp"] is double) {
      bdtp = json["bdtp"];
    }
    if (json["hr"] is int) {
      hr = json["hr"];
    }
    if (json["resp"] is int) {
      resp = json["resp"];
    }
    if (json["spo2"] is double) {
      spo2 = json["spo2"];
    }
    if (json["sbp"] is int) {
      sbp = json["sbp"];
    }
    if (json["newsScore"] is int) {
      newsScore = json["newsScore"];
    }
    if (json["svrtTypeCd"] is String) {
      svrtTypeCd = json["svrtTypeCd"];
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["ptId"] = ptId;
    data["svrtIptTypeCd"] = svrtIptTypeCd;
    data["avpuCd"] = avpuCd;
    data["oxyYn"] = oxyYn;
    data["bdtp"] = bdtp;
    data["hr"] = hr;
    data["resp"] = resp;
    data["spo2"] = spo2;
    data["sbp"] = sbp;
    data["newsScore"] = newsScore;
    data["svrtTypeCd"] = svrtTypeCd;

    return data;
  }
}
