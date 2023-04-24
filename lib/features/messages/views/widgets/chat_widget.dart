import 'package:flutter/material.dart';
import 'package:sbas/features/messages/models/talk_msg_model.dart';
import 'package:sbas/features/messages/views/widgets/talk_room_widget.dart';

ListView ChatWidget(AsyncSnapshot<List<TalkMsgModel>> snapshot) {
  return ListView.separated(
    itemBuilder: (context, index) {
      var chat = snapshot.data![index];
      return ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        leading: Image.asset(
          'assets/message/doctor_icon.png',
          height: 45,
        ),
        title: Text(
          chat.rgstUserId!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          chat.msg ?? '',
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: Text(
          formatDateTime(chat.updtDttm!),
          style: const TextStyle(fontSize: 12.0, color: Colors.grey),
        ),
      );
    },
    separatorBuilder: (context, index) => const Divider(
      height: 1.0,
    ),
    itemCount: snapshot.data!.length,
  );
}
