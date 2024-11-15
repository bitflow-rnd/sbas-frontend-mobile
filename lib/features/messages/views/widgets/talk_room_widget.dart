import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/authentication/providers/user_detail_presenter.dart';
import 'package:sbas/features/authentication/repos/login_repo.dart';
import 'package:sbas/features/messages/providers/talk_rooms_provider.dart';
import 'package:sbas/features/messages/views/chatting_screen.dart';
import 'package:sbas/util.dart';

class TalkRoomWidget extends ConsumerWidget {
  const TalkRoomWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final talkRooms = ref.watch(talkRoomsProvider);
    if (talkRooms.isEmpty) {
      return Center(
        child: Text(
          '최근 대화 내역이 없습니다.',
          style: CTS(
            fontSize: 12.sp,
          ),
        ),
      );
    }
    return ListView.separated(
      itemBuilder: (context, index) {
        var talkRoom = talkRooms[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/message/doctor_icon.png',
                height: 36.h,
              ),
              Gaps.h10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 250.w,
                        child: Text(
                          talkRoom.tkrmNm!,
                          style: CTS.bold(
                            fontSize: 15,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      // Gaps.h4,
                      // Image.asset(
                      //   "assets/message/unread_msg.png",
                      //   width: 16.w,
                      //   height: 16.w,
                      // )
                    ],
                  ),
                  if (talkRoom.msg != null && talkRoom.msg != '')
                    Column(
                      children: [
                        Gaps.v4,
                        SizedBox(
                          width: 250.w,
                          child: Text(
                            talkRoom.msg ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                        Gaps.v4,
                      ],
                    ),
                  if (talkRoom.msg == null || talkRoom.msg == '')
                    Gaps.v8,
                  Text(
                    formatDateTime(talkRoom.rgstDttm!),
                    style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChattingScreen(
                  userId: ref.watch(userDetailProvider.notifier).userId,
                  tkrmId: talkRoom.tkrmId!,
                  tkrmNm: talkRoom.tkrmNm!,
                ),
              ),
            );

            ref.read(talkRoomsProvider.notifier).updateUserId(userToken.name!);
          },
        );
      },
      separatorBuilder: (context, index) => Divider(height: 1.0.h),
      itemCount: talkRooms.length,
    );
  }
}


