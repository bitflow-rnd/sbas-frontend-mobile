import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/messages/models/talk_rooms_model.dart';
import 'package:sbas/features/messages/providers/talk_rooms_provider.dart';

class TalkRoomsRepository {
  Future<List<TalkRoomsModel>> getMyChats() async =>
      await _talkRoomsProvider.getMyChats();

  final _talkRoomsProvider = TalkRoomsProvider();
}

final talkRoomsProvider = Provider(
  (ref) => TalkRoomsRepository(),
);
