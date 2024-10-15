import 'package:sbas/features/messages/models/user_detail_model.dart';

class UserListModel {
  int? count;
  late List<UserDetailModel> items;

  UserListModel({
    this.count,
    required this.items,
  });
  UserListModel.fromJson(Map<String, dynamic> json) {
    if (json["count"] is int) {
      count = json["count"];
    }
    if (json["items"] is List) {
      items = (json["items"] as List)
          .map((e) => UserDetailModel.fromJson(e)).toList();
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["count"] = count;

    data["items"] = items.map((e) => e.toJson()).toList();

    return data;
  }
}
