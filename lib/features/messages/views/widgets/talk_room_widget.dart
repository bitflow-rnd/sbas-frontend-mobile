import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
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
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          leading: Image.asset(
            'assets/message/doctor_icon.png',
            height: 45,
          ),
          title: Text(
            talkRoom.tkrmNm!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            talkRoom.msg ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.grey),
          ),
          trailing: Text(
            formatDateTime(talkRoom.rgstDttm!),
            style: const TextStyle(fontSize: 12.0, color: Colors.grey),
          ),
          onTap: () {
            onTap(talkRoom.tkrmId!);
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(height: 1.0),
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
