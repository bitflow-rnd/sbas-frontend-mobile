import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/messages/providers/talk_rooms_provider.dart';

class TalkRoomWidget extends ConsumerWidget {
  final Function onTap;

  const TalkRoomWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final talkRooms = ref.watch(talkRoomsProvider);

    return ListView.separated(
      itemBuilder: (context, index) {
        var talkRoom = talkRooms[index];

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/message/doctor_icon.png',
                    height: 36.h,
                  ),
                  Gaps.h10,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              talkRoom.tkrmNm!,
                              style: CTS.bold(
                                fontSize: 15,
                              ),
                            ),
                            Gaps.h4,
                            Image.asset(
                              "assets/message/unread_msg.png",
                              width: 16.w,
                              height: 16.w,
                            )
                          ],
                        ),
                        Gaps.v8,
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                talkRoom.msg ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Gaps.v8,
              Row(
                children: [
                  Gaps.h52,
                  Text(
                    formatDateTime(talkRoom.rgstDttm!),
                    style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          onTap: () {
            onTap(talkRoom.tkrmId!, talkRoom.tkrmNm!);
          },
        );
      },
      separatorBuilder: (context, index) => Divider(height: 1.0.h),
      itemCount: talkRooms.length,
    );
  }
}

String formatDateTime(String dateTimeString) {
  final dateTime = DateTime.parse(dateTimeString);
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays > 0) {
    final formatter = DateFormat('yyyy.MM.dd');
    return formatter.format(dateTime);
  } else if (difference.inHours > 0) {
    return '${difference.inHours}시간 전';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes}분 전';
  } else {
    return '방금 전';
  }
}
