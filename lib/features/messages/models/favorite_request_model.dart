class FavoriteRequestModel {
  String id;
  String mbrId;

  FavoriteRequestModel({
    required this.id,
    required this.mbrId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["id"] = id;
    data["mbrId"] = mbrId;

    return data;
  }

}