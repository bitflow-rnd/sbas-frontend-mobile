class InfectiousDiseaseModel {
  String? ptId;
  String? rcptPhc;
  String? diagNm;
  String? diagGrde;
  String? cv19Symp;
  String? occrDt;
  String? diagDt;
  String? rptDt;
  String? dfdgExamRslt;
  String? ptCatg;
  String? admsYn;
  String? rptType;
  String? rmk;
  String? instNm;
  String? instId;
  String? instTelno;
  String? instAddr;
  String? diagDrNm;
  String? rptChfNm;
  String? esvyAttcId;
  String? instBascAddr;
  String? instDetlAddr;
  String? instZip;
  String? diagAttcId;

  InfectiousDiseaseModel({
    this.ptId,
    this.rcptPhc,
    this.diagNm,
    this.diagGrde,
    this.cv19Symp,
    this.occrDt,
    this.diagDt,
    this.rptDt,
    this.dfdgExamRslt,
    this.ptCatg,
    this.admsYn,
    this.rptType,
    this.rmk,
    this.instNm,
    this.instId,
    this.instTelno,
    this.instAddr,
    this.diagDrNm,
    this.rptChfNm,
    this.esvyAttcId,
    this.instBascAddr,
    this.instDetlAddr,
    this.instZip,
    this.diagAttcId,
  });
  InfectiousDiseaseModel.fromJson(Map<String, dynamic> json) {
    if (json["ptId"] is String) {
      ptId = json["ptId"];
    }
    if (json["rcptPhc"] is String) {
      rcptPhc = json["rcptPhc"];
    }
    if (json["diagNm"] is String) {
      diagNm = json["diagNm"];
    }
    if (json["diagGrde"] is String) {
      diagGrde = json["diagGrde"];
    }
    if (json["cv19Symp"] is String) {
      cv19Symp = json["cv19Symp"];
    }
    if (json["occrDt"] is String) {
      occrDt = json["occrDt"];
    }
    if (json["diagDt"] is String) {
      diagDt = json["diagDt"];
    }
    if (json["rptDt"] is String) {
      rptDt = json["rptDt"];
    }
    if (json["dfdgExamRslt"] is String) {
      dfdgExamRslt = json["dfdgExamRslt"];
    }
    if (json["ptCatg"] is String) {
      ptCatg = json["ptCatg"];
    }
    if (json["admsYn"] is String) {
      admsYn = json["admsYn"];
    }
    if (json["rptType"] is String) {
      rptType = json["rptType"];
    }
    if (json["rmk"] is String) {
      rmk = json["rmk"];
    }
    if (json["instNm"] is String) {
      instNm = json["instNm"];
    }
    if (json["instId"] is String) {
      instId = json["instId"];
    }
    if (json["instTelno"] is String) {
      instTelno = json["instTelno"];
    }
    if (json["instAddr"] is String) {
      instAddr = json["instAddr"];
    }
    if (json["diagDrNm"] is String) {
      diagDrNm = json["diagDrNm"];
    }
    if (json["rptChfNm"] is String) {
      rptChfNm = json["rptChfNm"];
    }
    if (json["esvyAttcId"] is String) {
      esvyAttcId = json["esvyAttcId"];
    }
    if (json["instBascAddr"] is String) {
      instBascAddr = json["instBascAddr"];
    }
    if (json["instDetlAddr"] is String) {
      instDetlAddr = json["instDetlAddr"];
    }
    if (json["instZip"] is String) {
      instZip = json["instZip"];
    }
    if (json["diagAttcId"] is String) {
      diagAttcId = json["diagAttcId"];
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["ptId"] = ptId;
    data["rcptPhc"] = rcptPhc;
    data["diagNm"] = diagNm;
    data["diagGrde"] = diagGrde;
    data["cv19Symp"] = cv19Symp;
    data["occrDt"] = occrDt;
    data["diagDt"] = diagDt;
    data["rptDt"] = rptDt;
    data["dfdgExamRslt"] = dfdgExamRslt;
    data["ptCatg"] = ptCatg;
    data["admsYn"] = admsYn;
    data["rptType"] = rptType;
    data["rmk"] = rmk;
    data["instNm"] = instNm;
    data["instId"] = instId;
    data["instTelno"] = instTelno;
    data["instAddr"] = instAddr;
    data["diagDrNm"] = diagDrNm;
    data["rptChfNm"] = rptChfNm;
    data["esvyAttcId"] = esvyAttcId;
    data["instBascAddr"] = instBascAddr;
    data["instDetlAddr"] = instDetlAddr;
    data["instZip"] = instZip;
    data["diagAttcId"] = diagAttcId;

    return data;
  }

  InfectiousDiseaseModel.empty()
      : ptId = null,
        rcptPhc = null,
        diagNm = null,
        diagGrde = null,
        cv19Symp = null,
        occrDt = null,
        diagDt = null,
        rptDt = null,
        dfdgExamRslt = null,
        ptCatg = null,
        admsYn = null,
        rptType = null,
        rmk = null,
        instNm = null,
        instId = null,
        instTelno = null,
        instAddr = null,
        diagDrNm = null,
        esvyAttcId = null,
        instBascAddr = null,
        instDetlAddr = null,
        instZip = null,
        diagAttcId = null,
        rptChfNm = null;
}
