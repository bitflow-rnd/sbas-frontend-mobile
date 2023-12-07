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
    controller: scrollController,
    itemCount: snapshot.data!.length,
    itemBuilder: (context, index) {
      var chat = snapshot.data![index];
      bool isMyMessage = chat.updtUserId == currentUserId;
      bool isText = chat.attcId == null;

      return Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: isMyMessage
            ? (isText
                ? myChatWidget(chat, scrollController)
                : myChatPhotoAttachedWidget(chat, scrollController, context))
            : (isText
                ? othersChatWidget(chat, scrollController)
                : othersPhotoChatWidget(chat, scrollController, context)),
      );
    },
  );
}
