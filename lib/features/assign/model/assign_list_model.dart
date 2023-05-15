import 'package:sbas/features/assign/model/assign_item_model.dart';

class AssignListModel {
  int? count;
  late List<AssignItemModel> items;

  AssignListModel({
    this.count,
    required this.items,
  });
  AssignListModel.fromJson(Map<String, dynamic> json) {
    if (json["count"] is int) {
      count = json["count"];
    }
    if (json["items"] is List) {
      items = (json["items"] as List)
          .map((e) => AssignItemModel.fromJson(e))
          .toList();
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["items"] = items.map((e) => e.toJson()).toList();
    data["count"] = count;

    return data;
  }
}
