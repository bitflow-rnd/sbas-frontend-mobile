class InitPwModel {
  String userNm;
  String id;
  String telno;

  InitPwModel({
    required this.userNm,
    required this.id,
    required this.telno,
  });

  factory InitPwModel.fromJson(Map<String, dynamic> json) {
    return InitPwModel(
      userNm: json['userNm'],
      id: json['id'],
      telno: json['telno'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userNm': userNm,
      'id': id,
      'telno': telno,
    };
  }
}