class ActivityHistoryModel {
  int? id;
  String? userId;
  String? ptId;
  String? ptNm;
  String? gndr;
  int? age;
  String? dstr1Cd;
  String? dstr1CdNm;
  String? dstr2Cd;
  String? dstr2CdNm;
  String? activityDetail;
  String? rgstDttm;

  ActivityHistoryModel({
    this.id,
    this.userId,
    this.ptId,
    this.ptNm,
    this.gndr,
    this.age,
    this.dstr1Cd,
    this.dstr1CdNm,
    this.dstr2Cd,
    this.dstr2CdNm,
    this.activityDetail,
    this.rgstDttm,
  });

  ActivityHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['id'] is int) {
      id = json['id'];
    }
    if (json['userId'] is String) {
      userId = json['userId'];
    }
    if (json['ptId'] is String) {
      ptId = json['ptId'];
    }
    if (json['ptNm'] is String) {
      ptNm = json['ptNm'];
    }
    if (json['gndr'] is String) {
      gndr = json['gndr'];
    }
    if (json['age'] is int) {
      age = json['age'];
    }
    if (json['dstr1Cd'] is String) {
      dstr1Cd = json['dstr1Cd'];
    }
    if (json['dstr1CdNm'] is String) {
      dstr1CdNm = json['dstr1CdNm'];
    }
    if(json['dstr2Cd'] is String) {
      dstr2Cd = json['dstr2Cd'];
    }
    if(json['dstr2CdNm'] is String) {
      dstr2CdNm = json['dstr2CdNm'];
    }
    if(json['activityDetail'] is String) {
      activityDetail = json['activityDetail'];
    }
    if(json['rgstDttm'] is String) {
      rgstDttm = json['rgstDttm'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['userId'] = userId;
    data['ptId'] = ptId;
    data['ptNm'] = ptNm;
    data['gndr'] = gndr;
    data['age'] = age;
    data['dstr1Cd'] = dstr1Cd;
    data['dstr1CdNm'] = dstr1CdNm;
    data['dstr2Cd'] = dstr2Cd;
    data['dstr2CdNm'] = dstr2CdNm;
    data['activityDetail'] = activityDetail;
    data['rgstDttm'] = rgstDttm;

    return data;
  }
}
