import 'package:flutter/material.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/messages/models/talk_msg_model.dart';
import 'package:sbas/features/messages/views/widgets/talk_room_widget.dart';

Row myChatWidget(
  TalkMsgModel input,
  ScrollController scrollController,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(
        textAlign: TextAlign.right,
        formatDateTime(input.updtDttm!),
        style: const TextStyle(fontSize: 8.0, color: Colors.grey),
      ),
      Gaps.h5,
      Container(
        constraints: const BoxConstraints(
          maxWidth: 310,
        ),
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          margin: const EdgeInsets.only(right: 15),
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
                bottomLeft: Radius.circular(8)),
            color: Color.fromARGB(255, 183, 225, 245),
          ),
          child: Text(input.msg ?? '',
              textAlign: TextAlign.start,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'OverpassRegular',
                  fontWeight: FontWeight.w300)),
        ),
      ),
    ],
  );
}
