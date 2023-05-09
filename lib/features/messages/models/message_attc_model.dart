class MessageAttcModel {
  String? fileTypeCd;
  String? file;

  MessageAttcModel({
    this.fileTypeCd,
    this.file,
  });

  MessageAttcModel.fromJson(Map<String, dynamic> json) {
    if (json["fileTypeCd"] is String) {
      fileTypeCd = json["fileTypeCd"];
    }
    if (json["file"] is String) {
      file = json["file"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["fileTypeCd"] = fileTypeCd;
    data["file"] = file;
    return data;
  }
}
