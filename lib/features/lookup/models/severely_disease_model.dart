class SeverelyDiseaseModel {
  String? ptId;
  String? ptTypeCd;
  String? undrDsesCd;
  String? undrDsesEtc;
  String? reqBedTypeCd;
  String? dnrAgreYn;
  String? svrtIptTypeCd;
  String? svrtTypeCd;
  String? avpuCd;
  String? oxyYn;
  double? bdtp;
  double? spo2;
  int? hr;
  int? resp;
  int? sbp;
  int? newsScore;
  late List<String> pttp;
  late List<String> udds;

  SeverelyDiseaseModel({
    this.ptId,
    this.ptTypeCd,
    this.undrDsesCd,
    this.undrDsesEtc,
    this.reqBedTypeCd,
    this.dnrAgreYn,
    this.svrtIptTypeCd,
    this.svrtTypeCd,
    this.avpuCd,
    this.oxyYn,
    this.bdtp,
    this.spo2,
    this.hr,
    this.resp,
    this.sbp,
    this.newsScore,
    required this.pttp,
    required this.udds,
  });
  void clear() {
    ptId = null;
    ptTypeCd = null;
    undrDsesCd = null;
    undrDsesEtc = null;
    reqBedTypeCd = null;
    dnrAgreYn = null;
    svrtIptTypeCd = null;
    svrtTypeCd = null;
    avpuCd = null;
    oxyYn = null;
    bdtp = null;
    spo2 = null;
    hr = null;
    resp = null;
    sbp = null;
    newsScore = null;
    pttp = [];
    udds = [];
  }

  SeverelyDiseaseModel.fromJson(Map<String, dynamic> json) {
    if (json["ptId"] is String) {
      ptId = json["ptId"];
    }
    if (json["ptTypeCd"] is String) {
      ptTypeCd = json["ptTypeCd"];
    }
    if (json["undrDsesCd"] is String) {
      undrDsesCd = json["undrDsesCd"];
    }
    if (json["undrDsesEtc"] is String) {
      undrDsesEtc = json["undrDsesEtc"];
    }
    if (json["reqBedTypeCd"] is String) {
      reqBedTypeCd = json["reqBedTypeCd"];
    }
    if (json["dnrAgreYn"] is String) {
      dnrAgreYn = json["dnrAgreYn"];
    }
    if (json["svrtIptTypeCd"] is String) {
      svrtIptTypeCd = json["svrtIptTypeCd"];
    }
    if (json["svrtTypeCd"] is String) {
      svrtTypeCd = json["svrtTypeCd"];
    }
    if (json["avpuCd"] is String) {
      avpuCd = json["avpuCd"];
    }
    if (json["oxyYn"] is String) {
      oxyYn = json["oxyYn"];
    }
    if (json["bdtp"] is String) {
      bdtp = json["bdtp"];
    }
    if (json["spo2"] is String) {
      spo2 = json["spo2"];
    }
    if (json["hr"] is int) {
      hr = json["hr"];
    }
    if (json["resp"] is int) {
      resp = json["resp"];
    }
    if (json["sbp"] is int) {
      sbp = json["sbp"];
    }
    if (json["newsScore"] is int) {
      newsScore = json["newsScore"];
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["ptId"] = ptId;
    data["undrDsesEtc"] = undrDsesEtc;
    data["reqBedTypeCd"] = reqBedTypeCd;
    data["dnrAgreYn"] = dnrAgreYn;
    data["svrtIptTypeCd"] = svrtIptTypeCd;
    data["svrtTypeCd"] = svrtTypeCd;
    data["avpuCd"] = avpuCd;
    data["oxyYn"] = oxyYn;
    data["bdtp"] = bdtp;
    data["spo2"] = spo2;
    data["hr"] = hr;
    data["resp"] = resp;
    data["sbp"] = sbp;
    data["newsScore"] = newsScore;

    ptTypeCd = '';
    undrDsesCd = '';

    for (int i = 0; i < pttp.length; i++) {
      if (i == pttp.length - 1) {
        ptTypeCd = '$ptTypeCd${pttp[i]}';
      } else {
        ptTypeCd = '$ptTypeCd${pttp[i]};';
      }
    }
    for (int i = 0; i < udds.length; i++) {
      if (i == udds.length - 1) {
        undrDsesCd = '$undrDsesCd${udds[i]}';
      } else {
        undrDsesCd = '$undrDsesCd${udds[i]};';
      }
    }
    data["ptTypeCd"] = ptTypeCd;
    data["undrDsesCd"] = undrDsesCd;

    return data;
  }

  SeverelyDiseaseModel.empty()
      : ptId = null,
        ptTypeCd = null,
        undrDsesCd = null,
        undrDsesEtc = null,
        reqBedTypeCd = null,
        dnrAgreYn = null,
        svrtIptTypeCd = null,
        svrtTypeCd = null,
        avpuCd = null,
        oxyYn = null,
        bdtp = null,
        spo2 = null,
        hr = null,
        resp = null,
        sbp = null,
        newsScore = null,
        pttp = [],
        udds = [];
}
