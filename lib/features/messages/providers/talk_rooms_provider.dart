import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/authentication/repos/login_repo.dart';
import 'package:sbas/features/messages/models/talk_rooms_response_model.dart';
import 'package:web_socket_channel/io.dart';

class TalkRoomsProvider {
  late final String userId;
  final _chatRoomListController =
      StreamController<List<TalkRoomsResponseModel>>();

  static TalkRoomsProvider? _instance;

  static TalkRoomsProvider getInstance({String? userId}) {
    _instance ??= TalkRoomsProvider._(userId: userId);
    return _instance!;
  }

  TalkRoomsProvider._({String? userId}) {
    this.userId = userId ?? '';
    _fetchChatRoomList();
  }

  Stream<List<TalkRoomsResponseModel>> get chatRoomListStream =>
      _chatRoomListController.stream;

  late final List<TalkRoomsResponseModel> chatRoomList;

  late final channel = IOWebSocketChannel.connect(
    '$_wsUrl/$userId',
    pingInterval: const Duration(seconds: 30),
    connectTimeout: const Duration(seconds: 5),
  );

  void _fetchChatRoomList() async {
    channel.stream.listen((message) {
      final parsedData = json.decode(message);

      if (parsedData is List) {
        print(parsedData);
        chatRoomList = TalkRoomsResponseModel.fromArrJson(parsedData);
        _chatRoomListController.add(chatRoomList);
      } else if (parsedData is Map<String, dynamic>) {
        print(parsedData);
        final modifyData = TalkRoomsResponseModel.fromJson(parsedData);
        if (chatRoomList.isEmpty) {
          chatRoomList.add(modifyData);
        } else {
          for (var i = 0; i < chatRoomList.length; i++) {
            if (chatRoomList[i].tkrmId == modifyData.tkrmId) {
              chatRoomList[i] = modifyData;
            }
          }
        }
      } else {
        throw Exception('Invalid data type received from server');
      }
      _chatRoomListController.add(chatRoomList);
    }, onError: (error) {
      _chatRoomListController.addError(error);
    });
  }

  Future<void> sendMessage(String message) async {
    channel.sink.add(message);
  }

  void dispose() {
    _chatRoomListController.close();
  }

  final String _wsUrl = '${dotenv.env['WS_URL']}/chat-rooms';
}

final talkRoomsProvider = Provider(
  (ref) => TalkRoomsProvider.getInstance(userId: userToken.name),
);

final talkRoomsStateProvider =
    StreamProvider<List<TalkRoomsResponseModel>>((ref) {
  final provider = ref.watch(talkRoomsProvider);
  return provider.chatRoomListStream.asBroadcastStream();
});