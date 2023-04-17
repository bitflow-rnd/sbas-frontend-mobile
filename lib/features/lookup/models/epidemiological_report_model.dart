class EpidemiologicalReportModel {
  String? rcptPhc;
  String? ptNm;
  String? rrno1;
  String? rrno2;
  String? gndr;
  String? dstr1Cd;
  String? dstr2Cd;
  String? baseAddr;
  String? dtlAddr;
  String? fullAddr;
  String? telno;
  String? diagNm;
  String? diagGrde;
  String? job;
  String? occrDt;
  String? diagDt;
  String? rptDt;
  String? dfdgExamRslt;
  String? ptCatg;
  String? admsYn;
  String? dethYn;
  String? rmk;
  String? instNm;
  String? instId;
  String? instTelno;
  String? instAddr;
  String? diagDrNm;
  String? rptChfNm;
  String? cv19Symp;

  EpidemiologicalReportModel({
    this.cv19Symp,
    this.rcptPhc,
    this.ptNm,
    this.rrno1,
    this.rrno2,
    this.gndr,
    this.dstr1Cd,
    this.dstr2Cd,
    this.baseAddr,
    this.dtlAddr,
    this.fullAddr,
    this.telno,
    this.diagNm,
    this.diagGrde,
    this.job,
    this.occrDt,
    this.diagDt,
    this.rptDt,
    this.dfdgExamRslt,
    this.ptCatg,
    this.admsYn,
    this.dethYn,
    this.rmk,
    this.instNm,
    this.instId,
    this.instTelno,
    this.instAddr,
    this.diagDrNm,
    this.rptChfNm,
  });
  EpidemiologicalReportModel.empty()
      : rcptPhc = '',
        ptNm = '',
        rrno1 = '',
        rrno2 = '',
        gndr = '',
        dstr1Cd = '',
        dstr2Cd = '',
        baseAddr = '',
        dtlAddr = '',
        fullAddr = '',
        telno = '',
        diagNm = '',
        diagGrde = '',
        job = '',
        occrDt = '',
        diagDt = '',
        rptDt = '',
        dfdgExamRslt = '',
        ptCatg = '',
        admsYn = '',
        dethYn = '',
        rmk = '',
        instNm = '',
        instId = '',
        instTelno = '',
        instAddr = '',
        diagDrNm = '',
        cv19Symp = '',
        rptChfNm = '';

  EpidemiologicalReportModel.fromJson(Map<String, dynamic> json) {
    if (json["rcptPhc"] is String) {
      rcptPhc = json["rcptPhc"];
    }
    if (json["ptNm"] is String) {
      ptNm = json["ptNm"];
    }
    if (json["rrno1"] is String) {
      rrno1 = json["rrno1"];
    }
    if (json["rrno2"] is String) {
      rrno2 = json["rrno2"];
    }
    if (json["gndr"] is String) {
      gndr = json["gndr"];
    }
    if (json["dstr1Cd"] is String) {
      dstr1Cd = json["dstr1Cd"];
    }
    if (json["dstr2Cd"] is String) {
      dstr2Cd = json["dstr2Cd"];
    }
    if (json["baseAddr"] is String) {
      baseAddr = json["baseAddr"];
    }
    if (json["dtlAddr"] is String) {
      dtlAddr = json["dtlAddr"];
    }
    if (json["fullAddr"] is String) {
      fullAddr = json["fullAddr"];
    }
    if (json["telno"] is String) {
      telno = json["telno"];
    }
    if (json["diagNm"] is String) {
      diagNm = json["diagNm"];
    }
    if (json["diagGrde"] is String) {
      diagGrde = json["diagGrde"];
    }
    if (json["job"] is String) {
      job = json["job"];
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
    if (json["dethYn"] is String) {
      dethYn = json["dethYn"];
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
    if (json["cv19Symp"] is String) {
      cv19Symp = json["cv19Symp"];
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["rcptPhc"] = rcptPhc;
    data["ptNm"] = ptNm;
    data["rrno1"] = rrno1;
    data["rrno2"] = rrno2;
    data["gndr"] = gndr;
    data["dstr1Cd"] = dstr1Cd;
    data["dstr2Cd"] = dstr2Cd;
    data["baseAddr"] = baseAddr;
    data["dtlAddr"] = dtlAddr;
    data["fullAddr"] = fullAddr;
    data["telno"] = telno;
    data["diagNm"] = diagNm;
    data["diagGrde"] = diagGrde;
    data["job"] = job;
    data["occrDt"] = occrDt;
    data["diagDt"] = diagDt;
    data["rptDt"] = rptDt;
    data["dfdgExamRslt"] = dfdgExamRslt;
    data["ptCatg"] = ptCatg;
    data["admsYn"] = admsYn;
    data["dethYn"] = dethYn;
    data["rmk"] = rmk;
    data["instNm"] = instNm;
    data["instId"] = instId;
    data["instTelno"] = instTelno;
    data["instAddr"] = instAddr;
    data["diagDrNm"] = diagDrNm;
    data["rptChfNm"] = rptChfNm;
    data["cv19Symp"] = cv19Symp;

    return data;
  }
}
