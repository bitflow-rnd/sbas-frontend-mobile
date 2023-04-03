class AuthTokenModel {
  String? token;

  AuthTokenModel({
    this.token,
  });
  AuthTokenModel.fromJson(Map<String, dynamic> json) {
    if (json["result"] is String) {
      token = json["result"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["result"] = token;

    return data;
  }
}
