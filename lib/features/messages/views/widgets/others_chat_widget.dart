import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/messages/models/talk_msg_model.dart';
import 'package:sbas/features/messages/views/widgets/talk_room_widget.dart';
import 'package:sbas/common/bitflow_theme.dart';

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
      CircleAvatar(backgroundImage: AssetImage(userImage), radius: 20.r),
      Gaps.h10,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            chat.rgstUserId!,
            style: CTS(
              fontWeight: FontWeight.bold,
              fontSize: 13.sp,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: 0.63.sw,
                ),
                padding: EdgeInsets.only(top: 10.h),
                child: Container(
                  margin: EdgeInsets.only(right: 5.w),
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(8.r), topRight: Radius.circular(8.r), bottomLeft: Radius.circular(8.r)),
                    color: Colors.white,
                  ),
                  child: Text(
                    input.msg ?? '',
                    textAlign: TextAlign.start,
                    style: CTS(
                      color: Colors.black,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ),
              Text(
                textAlign: TextAlign.left,
                formatDateTime(input.updtDttm!),
                style: CTS(fontSize: 11.sp, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
