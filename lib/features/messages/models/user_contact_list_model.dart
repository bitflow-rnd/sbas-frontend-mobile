import 'package:sbas/features/messages/models/user_contact_model.dart';

class UserContactList {
  int? totalCnt;
  List<UserContact>? contacts;

  UserContactList({
    this.totalCnt,
    this.contacts,
  });

  UserContactList.fromJson(Map<String, dynamic> json)
      : totalCnt = json['totalCnt'] as int?,
        contacts = (json['items'] as List?)?.map((dynamic e) => UserContact.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {'totalCnt': totalCnt, 'items': contacts?.map((e) => e.toJson()).toList()};
}
