class AuthTokenModel {
  String? token;

  AuthTokenModel({this.token});

  AuthTokenModel.fromJson(Map<String, dynamic> json) {
    if (json["token"] is String) {
      token = json["token"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["token"] = token;

    return data;
  }
}
