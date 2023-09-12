import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/authentication/repos/login_repo.dart';
import 'package:sbas/features/messages/models/talk_rooms_response_model.dart';
import 'package:web_socket_channel/io.dart';

class TalkRoomsProvider extends StateNotifier<List<TalkRoomsResponseModel>> {
  late final String userId;
  late StreamSubscription subscription;
  TalkRoomsProvider({required this.userId}) : super([]) {
    _fetchChatRoomList();
  }

  late final channel = IOWebSocketChannel.connect(
    '$_wsUrl/$userId',
    pingInterval: const Duration(seconds: 30),
    connectTimeout: const Duration(seconds: 5),
  );

  void _fetchChatRoomList() async {
    print(userId);
    subscription = channel.stream.listen((message) {
      final parsedData = json.decode(message.toString());
      print(parsedData);

      if (parsedData is List) {
        state = List.from(TalkRoomsResponseModel.fromArrJson(parsedData));
      } else if (parsedData is Map<String, dynamic>) {
        final modifyData = TalkRoomsResponseModel.fromJson(parsedData);
        if (state.isEmpty) {
          state = List.from(state)..add(modifyData);
        } else {
          for (var i = 0; i < state.length; i++) {
            if (state[i].tkrmId == modifyData.tkrmId) {
              state[i] = modifyData;
            }
          }
          state = List.from(state);
        }
      } else {
        throw Exception('Invalid data type received from server');
      }
    }, onError: (error) {});
  }

  Future<void> sendMessage(String message) async {
    channel.sink.add(message);
  }

  Future<void> disconnect() async {
    state = [];

    await channel.sink.close();
    // await subscription.cancel();
    // await channel.stream.drain();
    if (mounted) super.dispose();
  }

  final String _wsUrl = '${dotenv.env['WS_URL']}/chat-rooms';
}

final talkRoomsProvider = StateNotifierProvider<TalkRoomsProvider, List<TalkRoomsResponseModel>>(
  (ref) => TalkRoomsProvider(userId: userToken.name!),
);
