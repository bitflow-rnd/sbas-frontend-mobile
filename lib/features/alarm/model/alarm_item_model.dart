class AlarmItemModel {
  String? title;
  String? body;
  int? year;
  int? month;
  String? dateTime;

  AlarmItemModel({
    this.title,
    this.body,
    this.year,
    this.month,
    this.dateTime,
  });

  AlarmItemModel.fromJson(Map<String, dynamic> json) {
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["body"] is String) {
      body = json["body"];
    }
    if (json["year"] is int) {
      year = json["year"];
    }
    if (json["month"] is int) {
      month = json["month"];
    }
    if (json["date_time"] is String) {
      dateTime = json["date_time"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['title'] = title;
    data['body'] = body;
    data['year'] = year;
    data['month'] = month;
    data['date_time'] = dateTime;

    return data;
  }
}

class AlarmListModel {
  late int count;
  late List<AlarmItemModel> items;

  AlarmListModel({
    required this.count,
    required this.items,
  });

  AlarmListModel.fromJson(Map<String, dynamic> json) {
    if (json["count"] is int) {
      count = json["count"];
    }
    if (json["items"] is List) {
      items = (json["items"] as List)
          .map((e) => AlarmItemModel.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["count"] = count;
    data["items"] = items.map((e) => e.toJson()).toList();

    return data;
  }

}