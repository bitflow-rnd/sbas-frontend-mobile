import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sbas/features/messages/models/talk_rooms_response_model.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class TalkRoomsBloc {
  final String userId;
  final _chatRoomListController =
      StreamController<List<TalkRoomsResponseModel>>();

  TalkRoomsBloc({required this.userId}) {
    _fetchChatRoomList();
  }

  Stream<List<TalkRoomsResponseModel>> get chatRoomListStream =>
      _chatRoomListController.stream;

  late final List<TalkRoomsResponseModel> chatRoomList;

  void _fetchChatRoomList() async {
    final channel = IOWebSocketChannel.connect('$_wsUrl/$userId');

    channel.stream.listen((message) {
      final parsedData = json.decode(message);

      if (parsedData is List) {
        chatRoomList = TalkRoomsResponseModel.fromArrJson(parsedData);
        _chatRoomListController.add(chatRoomList);
      } else if (parsedData is Map<String, dynamic>) {
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
    }, onDone: () {
      channel.sink.close(status.goingAway);
    });
  }

  void dispose() {
    _chatRoomListController.close();
  }

  final String _wsUrl = '${dotenv.env['WS_URL']}/chat-rooms';
}
