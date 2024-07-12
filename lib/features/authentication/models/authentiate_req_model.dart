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

  // toJson 메서드는 User 객체를 JSON 맵으로 변환합니다.
  Map<String, dynamic> toJson() {
    return {
      'userNm': userNm,
      'telno': telno,
    };
  }
}