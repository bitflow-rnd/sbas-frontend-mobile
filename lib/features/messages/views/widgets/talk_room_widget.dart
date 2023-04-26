import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sbas/features/authentication/repos/login_repo.dart';
import 'package:sbas/features/messages/models/talk_rooms_response_model.dart';

ListView talkRoomWidget(List<TalkRoomsResponseModel> snapshot, Function onTap) {
  return ListView.separated(
    itemBuilder: (context, index) {
      var talkRoom = snapshot[index];

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
          onTap(userToken.name!, talkRoom.tkrmId!);
        },
      );
    },
    separatorBuilder: (context, index) => const Divider(height: 1.0),
    itemCount: snapshot.length,
  );
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
