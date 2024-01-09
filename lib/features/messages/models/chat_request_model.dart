class ChatRequestModel {
  String id;
  String userId;

  ChatRequestModel({
    required this.id,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["id"] = id;
    data["userId"] = userId;

    return data;
  }

}