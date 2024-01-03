class ContactConditionModel {
  String? telno;
  String? ptTypeCd;
  String? instTypeCd;
  String? dstr1Cd;
  String? dstr2Cd;
  String? instNm;

  ContactConditionModel({
    this.telno,
    this.ptTypeCd,
    this.instTypeCd,
    this.dstr1Cd,
    this.dstr2Cd,
    this.instNm,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {};

    if (telno != null) {
      map['telno'] = telno;
    }
    if (ptTypeCd != null) {
      map['ptTypeCd'] = ptTypeCd;
    }
    if (instTypeCd != null) {
      map['instTypeCd'] = instTypeCd;
    }
    if (dstr1Cd != null) {
      map['dstr1Cd'] = dstr1Cd;
    }
    if (dstr2Cd != null) {
      map['dstr2Cd'] = dstr2Cd;
    }
    if (instNm != null) {
      map['instNm'] = instNm;
    }

    return map;
  }

  void setCondition({
    String? telno,
    String? ptTypeCd,
    String? instTypeCd,
    String? dstr1Cd,
    String? dstr2Cd,
    String? instNm,
  }) {
    this.telno = telno;
    this.ptTypeCd = ptTypeCd;
    this.instTypeCd = instTypeCd;
    this.dstr1Cd = dstr1Cd;
    this.dstr2Cd = dstr2Cd;
    this.instNm = instNm;
  }
}
