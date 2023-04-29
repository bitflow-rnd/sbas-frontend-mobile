import 'package:flutter/material.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/messages/models/talk_msg_model.dart';
import 'package:sbas/features/messages/views/widgets/talk_room_widget.dart';

import '../../../../common/bitflow_theme.dart';

Row othersChatWidget(
  TalkMsgModel input,
  ScrollController scrollController,
) {
  var chat = input;
  String? userImage = 'assets/message/doctor_icon.png';

  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Gaps.h16,
      CircleAvatar(
        backgroundImage: AssetImage(userImage),
        radius: 20,
      ),
      Gaps.h10,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            chat.rgstUserId!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 260,
                ),
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  margin: const EdgeInsets.only(right: 5),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(8), topRight: Radius.circular(8), bottomLeft: Radius.circular(8)),
                    color: Colors.white,
                  ),
                  child: Text(
                    input.msg ?? '',
                    textAlign: TextAlign.start,
                    style: CTS(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              Text(
                textAlign: TextAlign.left,
                formatDateTime(input.updtDttm!),
                style: CTS(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
