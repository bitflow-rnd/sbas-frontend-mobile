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

  late final channel = IOWebSocketChannel.connect('$_wsUrl/$tkrmId/$userId');

  void _fetchChattingRoom() async {
    channel.stream.listen((message) {
      final parsedData = json.decode(message);

      if (parsedData is List) {
        chatDetailList = TalkMsgModel.fromArrJson(parsedData);
        _chatDetailListController.add(chatDetailList);
      } else if (parsedData is Map<String, dynamic>) {
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
    channel.sink.add(message);

    TalkRoomsBloc(userId: userId).sendMessage(tkrmId);
  }

  void dispose() {
    _chatDetailListController.close();
  }

  final String _wsUrl = '${dotenv.env['WS_URL']}/chat-rooms';
}
