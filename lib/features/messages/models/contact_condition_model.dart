class ContactConditionModel {
  String? search;
  String? myInstTypeCd;
  String? instTypeCd;
  String? dstr1Cd;
  String? dstr2Cd;

  ContactConditionModel({
    this.search,
    this.myInstTypeCd,
    this.instTypeCd,
    this.dstr1Cd,
    this.dstr2Cd,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {};

    if (search != null) {
      map['search'] = search;
    }
    if (myInstTypeCd != null) {
      map['myInstTypeCd'] = myInstTypeCd;
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

    return map;
  }

  void setCondition({
    String? search,
    String? myInstTypeCd,
    String? instTypeCd,
    String? dstr1Cd,
    String? dstr2Cd,
  }) {
    this.search = search;
    this.myInstTypeCd = myInstTypeCd;
    this.instTypeCd = instTypeCd;
    this.dstr1Cd = dstr1Cd;
    this.dstr2Cd = dstr2Cd;
  }
}
