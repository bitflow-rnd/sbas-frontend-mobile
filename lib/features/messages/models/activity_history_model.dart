class ActivityHistoryModel {
  final int id;
  final String userId;
  final String ptId;
  final String ptNm;
  final String gndr;
  final int age;
  final String dstr1Cd;
  final String dstr1CdNm;
  final String dstr2Cd;
  final String dstr2CdNm;
  final String activityDetail;
  final DateTime rgstDttm;

  ActivityHistoryModel({
    required this.id,
    required this.userId,
    required this.ptId,
    required this.ptNm,
    required this.gndr,
    required this.age,
    required this.dstr1Cd,
    required this.dstr1CdNm,
    required this.dstr2Cd,
    required this.dstr2CdNm,
    required this.activityDetail,
    required this.rgstDttm,
  });

  factory ActivityHistoryModel.fromJson(Map<String, dynamic> json) {
    return ActivityHistoryModel(
      id: json['id'],
      userId: json['userId'],
      ptId: json['ptId'],
      ptNm: json['ptNm'],
      gndr: json['gndr'],
      age: json['age'],
      dstr1Cd: json['dstr1Cd'],
      dstr1CdNm: json['dstr1CdNm'],
      dstr2Cd: json['dstr2Cd'],
      dstr2CdNm: json['dstr2CdNm'],
      activityDetail: json['activityDetail'],
      rgstDttm: DateTime.parse(json['rgstDttm']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'ptId': ptId,
      'ptNm': ptNm,
      'gndr': gndr,
      'age': age,
      'dstr1Cd': dstr1Cd,
      'dstr1CdNm': dstr1CdNm,
      'dstr2Cd': dstr2Cd,
      'dstr2CdNm': dstr2CdNm,
      'activityDetail': activityDetail,
      'rgstDttm': rgstDttm.toIso8601String(),
    };
  }
}
