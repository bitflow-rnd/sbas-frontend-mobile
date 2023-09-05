import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/messages/models/talk_msg_model.dart';
import 'package:sbas/features/messages/views/widgets/talk_room_widget.dart';

Row myChatPhotoAttachedWidget(
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
        style: CTS(fontSize: 12, color: Colors.grey),
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
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8), bottomLeft: Radius.circular(8)),
            color: const Color(0xfffff700).withOpacity(0.333),
          ),
          child: Column(
            children: [
              Image.asset(
                "assets/auth_group/image_location_small.png",
                height: 55.h,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    input.msg ?? '',
                    textAlign: TextAlign.start,
                    style: CTS(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                  Gaps.h5,
                  Text(
                    '2.3MB',
                    textAlign: TextAlign.start,
                    style: CTS(
                      color: Palette.greyText_60,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Row myChatVideoAttachedWidget(
  //video
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
        style: CTS(fontSize: 12, color: Colors.grey),
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
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8), bottomLeft: Radius.circular(8)),
            color: const Color(0xfffff700).withOpacity(0.333),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.play_circle,
                color: Palette.mainColor,
              ),
              Gaps.h5,
              Text(
                input.msg ?? '',
                textAlign: TextAlign.start,
                style: CTS(
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
              Gaps.h5,
              Text(
                '2.3MB',
                textAlign: TextAlign.start,
                style: CTS(
                  color: Palette.greyText_60,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

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
        style: CTS(fontSize: 12, color: Colors.grey),
      ),
      Gaps.h5,
      Container(
        constraints: BoxConstraints(
          maxWidth: 0.7.sw,
        ),
        padding: EdgeInsets.only(top: 10.h),
        child: Container(
          margin: EdgeInsets.only(right: 15.w),
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8.r), topRight: Radius.circular(8.r), bottomLeft: Radius.circular(8.r)),
            color: const Color(0xfffff700).withOpacity(0.333),
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
    ],
  );
}
