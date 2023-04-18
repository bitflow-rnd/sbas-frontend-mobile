import 'package:flutter/cupertino.dart';
import 'package:sbas/features/messages/models/talk_rooms_response_model.dart';

ListView TalkRoomWidget(AsyncSnapshot<List<TalkRoomsResponseModel>> snapshot) {
  return ListView.separated(
    itemBuilder: (context, index) {
      var talkRoomTkrmId = snapshot.data![index].tkrmId;
      var talkRoomTkrmNm = snapshot.data![index].tkrmNm;
      var talkRoomMsg = snapshot.data![index].msg;
      var talkRoomDttm = snapshot.data![index].rgstDttm;

      return Column(
        children: [
          Text('$talkRoomDttm'),
          Text('$talkRoomMsg'),
          Text('$talkRoomTkrmId'),
          Text('$talkRoomTkrmNm'),
        ],
      );
    },
    separatorBuilder: (context, index) => const SizedBox(
      height: 40,
    ),
    itemCount: snapshot.data!.length,
  );
}
