import 'package:flutter/material.dart';
import 'package:sbas/features/messages/models/talk_msg_model.dart';
import 'package:sbas/features/messages/views/widgets/my_chat_widget.dart';
import 'package:sbas/features/messages/views/widgets/others_chat_widget.dart';

ListView chatWidget(
  String currentUserId,
  AsyncSnapshot<List<TalkMsgModel>> snapshot,
  ScrollController scrollController,
  BuildContext context,
) {
  return ListView.builder(
    reverse: true,
    controller: scrollController,
    itemCount: snapshot.data!.length,
    itemBuilder: (context, index) {
      var chat = snapshot.data![snapshot.data!.length - 1 - index];
      bool isMyMessage = chat.updtUserId == currentUserId;
      bool isText = chat.attcId == null;

      return Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 4),
        child: isMyMessage
            ? (isText
                ? myChatWidget(chat)
                : myChatPhotoAttachedWidget(chat, context))
            : (isText
                ? othersChatWidget(chat)
                : othersPhotoChatWidget(chat, context)),
      );
    },
  );
}
