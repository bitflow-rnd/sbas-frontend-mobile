class AuthenticateReqModel {
  String userNm;
  String telno;

  AuthenticateReqModel({
    required this.userNm,
    required this.telno,
  });

  factory AuthenticateReqModel.fromJson(Map<String, dynamic> json) {
    return AuthenticateReqModel(
      userNm: json['userNm'],
      telno: json['telno'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userNm': userNm,
      'telno': telno,
    };
  }
}