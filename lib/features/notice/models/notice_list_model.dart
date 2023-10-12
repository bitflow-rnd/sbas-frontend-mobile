import 'notice_model.dart';

class NoticeListModel {
  int? totalCnt;
  late List<NoticeList> items;

  NoticeListModel({
    this.totalCnt,
    required this.items,
  });

  NoticeListModel.fromJson(Map<String, dynamic> json) {
    if (json["totalCnt"] is int) {
      totalCnt = json["totalCnt"];
    }
    if (json["items"] is List) {
      items = (json["items"] as List).map((item) => NoticeList.fromJson(item)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["totalCnt"] = totalCnt;
    data["items"] = items.map((item) => item.toJson()).toList();

    return data;
  }
}