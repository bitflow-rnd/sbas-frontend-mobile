class UserModel {
  String? id;
  String? password;

  UserModel({
    this.id,
    this.password,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["pw"] is String) {
      password = json["pw"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["id"] = id;
    data["pw"] = password;

    return data;
  }
}
