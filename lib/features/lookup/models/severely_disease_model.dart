class SeverelyDiseaseModel {
  String? ptId;
  String? ptTypeCd;
  String? undrDsesCd;
  String? undrDsesEtc;
  String? reqBedTypeCd;
  String? dnrAgreYn;
  late Iterable<String> pttp;
  late Iterable<String> udds;

  SeverelyDiseaseModel({
    this.ptId,
    this.ptTypeCd,
    this.undrDsesCd,
    this.undrDsesEtc,
    this.reqBedTypeCd,
    this.dnrAgreYn,
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
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["ptId"] = ptId;
    data["undrDsesEtc"] = undrDsesEtc;
    data["reqBedTypeCd"] = reqBedTypeCd;
    data["dnrAgreYn"] = dnrAgreYn;

    data["ptTypeCd"] = ptTypeCd;
    data["undrDsesCd"] = undrDsesCd;

    return data;
  }
}
