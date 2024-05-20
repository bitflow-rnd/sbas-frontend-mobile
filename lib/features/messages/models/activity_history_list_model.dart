import 'activity_history_model.dart';

class ActivityHistoryListModel {
  int? count;
  List<ActivityHistoryModel> items;

  ActivityHistoryListModel({
    this.count,
    required this.items,
  });

  ActivityHistoryListModel.fromJson(Map<String, dynamic> json)
      : count = json['count'] as int?,
        items = (json['items'] as List).map((dynamic e) =>
                ActivityHistoryModel.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["count"] = count;
    data["items"] = items.map((e) => e.toJson()).toList();

    return data;
  }
}
