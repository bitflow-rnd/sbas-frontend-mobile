class SeverelyDiseaseModel {
  String? ptId;
  String? ptTypeCd;
  String? undrDsesCd;
  String? undrDsesEtc;
  String? reqBedTypeCd;
  String? dnrAgreYn;
  String? svrtIptTypeCd;
  String? svrtTypeCd;
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
    required this.pttp,
    required this.udds,
  });
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
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["ptId"] = ptId;
    data["undrDsesEtc"] = undrDsesEtc;
    data["reqBedTypeCd"] = reqBedTypeCd;
    data["dnrAgreYn"] = dnrAgreYn;
    data["svrtIptTypeCd"] = svrtIptTypeCd;
    data["svrtTypeCd"] = svrtTypeCd;

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
}
