import 'activity_history_model.dart';

class ActivityHistoryListModel {
  int? count;
  List<ActivityHistoryModel>? items;

  ActivityHistoryListModel({
    this.count,
    this.items,
  });

  ActivityHistoryListModel.fromJson(Map<String, dynamic> json)
      : count = json['count'] as int?,
        items = (json['items'] as List?)?.map((dynamic e) => ActivityHistoryModel.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {'count': count, 'items': items?.map((e) => e.toJson()).toList()};
}
