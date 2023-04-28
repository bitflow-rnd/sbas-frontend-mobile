import 'package:flutter/material.dart';
import 'package:sbas/features/messages/models/talk_msg_model.dart';
import 'package:sbas/features/messages/views/widgets/my_chat_widget.dart';
import 'package:sbas/features/messages/views/widgets/others_chat_widget.dart';

ListView chatWidget(
  String currentUserId,
  AsyncSnapshot<List<TalkMsgModel>> snapshot,
  ScrollController scrollController,
) {
  return ListView.builder(
    controller: scrollController,
    itemCount: snapshot.data!.length,
    itemBuilder: (context, index) {
      var chat = snapshot.data![index];
      bool isMyMessage = chat.rgstUserId == currentUserId;

      return Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: isMyMessage
            ? myChatWidget(chat, scrollController)
            : othersChatWidget(chat, scrollController),
      );
    },
  );
}
