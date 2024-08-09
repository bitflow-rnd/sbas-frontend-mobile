class AlarmItemModel {
  final int alarmId;
  final String title;
  final String detail;
  final String senderId;
  final String senderName;
  final String receiverId;
  final String receiverName;
  final bool isRead;
  final String date;
  final String time;

  AlarmItemModel({
    required this.alarmId,
    required this.title,
    required this.detail,
    required this.senderId,
    required this.senderName,
    required this.receiverId,
    required this.receiverName,
    required this.isRead,
    required this.date,
    required this.time,
  });

  factory AlarmItemModel.fromJson(Map<String, dynamic> json) {
    List<String> parts = json['rgstDttm'].split(' ');

    String date = "${parts[0]} ${parts[1]} ${parts[2]}";

    List<String> timeParts = parts[3].split(':');
    String time = '${timeParts[0]}시 ${timeParts[1]}분 ${timeParts[2]}초';

    return AlarmItemModel(
      alarmId: json['alarmId'],
      title: json['title'],
      detail: json['detail'],
      senderId: json['senderId'],
      senderName: json['senderName'],
      receiverId: json['receiverId'],
      receiverName: json['receiverName'],
      isRead: json['isRead'],
      date: date,
      time: time,
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'alarmId': alarmId,
  //     'title': title,
  //     'detail': detail,
  //     'senderId': senderId,
  //     'senderName': senderName,
  //     'receiverId': receiverId,
  //     'receiverName': receiverName,
  //     'isRead': isRead,
  //     'rgstDttm': rgstDttm,
  //   };
  // }
}

class AlarmListModel {
  int count;
  List<AlarmItemModel> items;

  AlarmListModel({
    required this.count,
    required this.items,
  });

  factory AlarmListModel.fromJson(Map<String, dynamic> json) {
    return AlarmListModel(
      count: json['count'] ?? 0,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => AlarmItemModel.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'count': count,
  //     'items': items.map((e) => e.toJson()).toList(),
  //   };
  // }
}
