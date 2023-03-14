class UserModel {
  String? id;
  String? pw;

  UserModel({
    this.id,
    this.pw,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["pw"] is String) {
      pw = json["pw"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["id"] = id;
    data["pw"] = pw;

    return data;
  }
}
