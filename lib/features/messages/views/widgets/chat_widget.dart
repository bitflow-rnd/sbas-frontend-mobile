import 'package:flutter/material.dart';
import 'package:sbas/features/messages/models/talk_msg_model.dart';
import 'package:sbas/features/messages/views/widgets/talk_room_widget.dart';

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
      bool hasImage = !isMyMessage;
      String? userImage = hasImage ? 'assets/message/doctor_icon.png' : null;
      String? userName = hasImage ? chat.rgstUserId : null;
      Color messageColor =
          isMyMessage ? const Color.fromARGB(255, 183, 225, 245) : Colors.white;
      CrossAxisAlignment crossAxisAlignment =
          isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start;
      EdgeInsets padding = isMyMessage
          ? const EdgeInsets.fromLTRB(80, 10, 10, 10)
          : const EdgeInsets.fromLTRB(10, 10, 80, 10);

      return Padding(
        padding: const EdgeInsets.only(top: 6.5),
        child: Row(
          children: [
            if (!hasImage)
              Flexible(
                flex: 1,
                child: Container(),
              ),
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: crossAxisAlignment,
                children: [
                  if (hasImage)
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(userImage!),
                            radius: 20,
                          ),
                        ),
                        Text(
                          userName!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  Container(
                    padding: padding,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: messageColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            child: Text(
                              chat.msg ?? '',
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            formatDateTime(chat.updtDttm!),
                            style: const TextStyle(
                                fontSize: 8.0, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

// OtherMsgWidget {
//   return 
// }