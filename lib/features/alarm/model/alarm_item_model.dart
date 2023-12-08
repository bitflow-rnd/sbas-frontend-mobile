class AlarmItemModel {
  String? title;
  String? body;
  int? year;
  int? month;
  String? dateTime;
  String? userId;
  String? receivedTime;

  AlarmItemModel({
    this.title,
    this.body,
    this.year,
    this.month,
    this.dateTime,
    this.userId,
    this.receivedTime,
  });

  AlarmItemModel.fromJson(Map<String, dynamic> json) {
    if (json['title'] is String) {
      title = json['title'];
    }
    if (json['body'] is String) {
      body = json['body'];
    }
    if (json['year'] is int) {
      year = json['year'];
    }
    if (json['month'] is int) {
      month = json['month'];
    }
    if (json['date_time'] is String) {
      dateTime = json['date_time'];
    }
    if (json['user_id'] is String) {
      userId = json['user_id'];
    }
    if (json['received_time'] is String) {
      receivedTime = json['received_time'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['title'] = title;
    data['body'] = body;
    data['year'] = year;
    data['month'] = month;
    data['date_time'] = dateTime;
    data['user_id'] = userId;
    data['received_time'] = receivedTime;

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