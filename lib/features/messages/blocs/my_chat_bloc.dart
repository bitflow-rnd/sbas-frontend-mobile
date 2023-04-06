import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sbas/features/messages/models/talk_rooms_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/messages/repos/talk_rooms_repo.dart';

class TalkRoomsBloc extends AsyncNotifier<List<TalkRoomsModel>> {
  @override
  FutureOr<List<TalkRoomsModel>> build() async {
    list.clear();
    list.addAll(await _talkRoomsRepository.getMyChats());
    return list;
  }

  exchangeTheTalkRooms() async {
    list.clear();

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      list.addAll(await _talkRoomsRepository.getMyChats());

      return list;
    });
    if (state.hasError) {
      if (kDebugMode) {
        print(state.error);
      }
    }
  }

  late final List<TalkRoomsModel> list;

  late final TalkRoomsRepository _talkRoomsRepository;
}

final talkRoomsProvider =
    AsyncNotifierProvider<TalkRoomsBloc, List<TalkRoomsModel>>(
  () => TalkRoomsBloc(),
);
