import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sbas/features/messages/blocs/talk_rooms_block.dart';
import 'package:sbas/features/messages/models/talk_msg_model.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class TalkRoomBloc {
  final String userId;
  final String tkrmId;
  final _chatDetailListController = StreamController<List<TalkMsgModel>>();

  TalkRoomBloc({
    required this.userId,
    required this.tkrmId,
  }) {
    _fetchChattingRoom();
  }

  Stream<List<TalkMsgModel>> get chatDetailListStream =>
      _chatDetailListController.stream;

  late final List<TalkMsgModel> chatDetailList;

  void _fetchChattingRoom() async {
    final channel = IOWebSocketChannel.connect('$_wsUrl/$tkrmId/$userId');

    channel.stream.listen((message) {
      print("상세채팅방의 어떠한 데이터 받음");
      final parsedData = json.decode(message);

      if (parsedData is List) {
        print("대화방 전체 내용 데이터 받음");
        chatDetailList = TalkMsgModel.fromArrJson(parsedData);
        _chatDetailListController.add(chatDetailList);
      } else if (parsedData is Map<String, dynamic>) {
        print("추가되는 메시지 데이터 받음");
        final addData = TalkMsgModel.fromJson(parsedData);

        chatDetailList.add(addData);
        _chatDetailListController.add(chatDetailList);
      } else {
        throw Exception('Invalid data type received from server');
      }
    }, onError: (error) {
      _chatDetailListController.addError(error);
    }, onDone: () {
      channel.sink.close(status.goingAway);
    });
  }

  Future<void> sendMessage(String message) async {
    final channel = IOWebSocketChannel.connect('$_wsUrl/$tkrmId/$userId');
    channel.sink.add(message);

    TalkRoomsBloc(userId: userId).sendMessage(tkrmId);
  }

  void dispose() {
    _chatDetailListController.close();
  }

  final String _wsUrl = '${dotenv.env['WS_URL']}/chat-rooms';
}
