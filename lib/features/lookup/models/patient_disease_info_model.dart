import 'dart:convert';

PatientDiseaseInfoModel patientDiseaseInfoModelFromJson(String str) => PatientDiseaseInfoModel.fromJson(json.decode(str));

String patientDiseaseInfoModelToJson(PatientDiseaseInfoModel data) => json.encode(data.toJson());

class PatientDiseaseInfoModel {
  String? rcptPhc;
  String? diagNm;
  String? dfdgExamRslt;
  String? diagGrde;
  String? occrDt;
  String? diagDt;
  String? rptDt;
  String? ptCatg;
  String? rmk;
  late List<String> undrDsesNms;
  late List<String> ptTypeNms;
  late List<String> svrtTypeNms;
  double? bdtp;
  int? hr;
  int? resp;
  int? spo2;
  int? sbp;
  String? dnrAgreYn;
  String? admsYn;
  String? instNm;
  String? instId;
  String? instAddr;
  String? instTelno;
  String? diagDrNm;
  String? rptChfNm;
  String? reqBedTypeNm;

  PatientDiseaseInfoModel({
    this.rcptPhc,
    this.diagNm,
    this.dfdgExamRslt,
    this.diagGrde,
    this.occrDt,
    this.diagDt,
    this.rptDt,
    this.ptCatg,
    this.rmk,
    required this.undrDsesNms,
    required this.ptTypeNms,
    required this.svrtTypeNms,
    this.bdtp,
    this.hr,
    this.resp,
    this.spo2,
    this.sbp,
    this.dnrAgreYn,
    this.admsYn,
    this.instNm,
    this.instId,
    this.instAddr,
    this.instTelno,
    this.diagDrNm,
    this.rptChfNm,
    this.reqBedTypeNm,
  });

  factory PatientDiseaseInfoModel.fromJson(Map<String, dynamic> json) => PatientDiseaseInfoModel(
    rcptPhc: json["rcptPhc"],
    diagNm: json["diagNm"],
    dfdgExamRslt: json["dfdgExamRslt"],
    diagGrde: json["diagGrde"],
    occrDt: json["occrDt"],
    diagDt: json["diagDt"],
    rptDt: json["rptDt"],
    ptCatg: json["ptCatg"],
    rmk: json["rmk"],
    undrDsesNms: json["undrDsesNms"] != null ? List<String>.from(json["undrDsesNms"].map((x) => x)) : [],
    ptTypeNms: json["ptTypeNms"] != null ? List<String>.from(json["ptTypeNms"].map((x) => x)) : [],
    svrtTypeNms: json["svrtTypeNms"] != null ? List<String>.from(json["svrtTypeNms"].map((x) => x)) : [],
    bdtp: json["bdtp"],
    hr: json["hr"],
    resp: json["resp"],
    spo2: json["spo2"],
    sbp: json["sbp"],
    dnrAgreYn: json["dnrAgreYn"],
    admsYn: json["admsYn"],
    instNm: json["instNm"],
    instId: json["instId"],
    instAddr: json["instAddr"],
    instTelno: json["instTelno"],
    diagDrNm: json["diagDrNm"],
    rptChfNm: json["rptChfNm"],
    reqBedTypeNm: json["reqBedTypeNm"],
  );

  Map<String, dynamic> toJson() => {
    "rcptPhc": rcptPhc,
    "diagNm": diagNm,
    "dfdgExamRslt": dfdgExamRslt,
    "diagGrde": diagGrde,
    "occrDt": occrDt,
    "diagDt": diagDt,
    "rptDt": rptDt,
    "ptCatg": ptCatg,
    "rmk": rmk,
    "undrDsesNms": List<dynamic>.from(undrDsesNms.map((x) => x)),
    "ptTypeNms": List<dynamic>.from(ptTypeNms.map((x) => x)),
    "svrtTypeNms": List<dynamic>.from(svrtTypeNms.map((x) => x)),
    "bdtp": bdtp,
    "hr": hr,
    "resp": resp,
    "spo2": spo2,
    "sbp": sbp,
    "dnrAgreYn": dnrAgreYn,
    "admsYn": admsYn,
    "instNm": instNm,
    "instId": instId,
    "instAddr": instAddr,
    "instTelno": instTelno,
    "diagDrNm": diagDrNm,
    "rptChfNm": rptChfNm,
    "reqBedTypeNm": reqBedTypeNm,
  };
}
