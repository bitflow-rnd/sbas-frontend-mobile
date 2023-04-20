import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sbas/features/messages/blocs/talk_rooms_block.dart';
import 'package:web_socket_channel/io.dart';

class TalkRoomBloc {
  final String userId;
  final String tkrmId;

  TalkRoomBloc({
    required this.userId,
    required this.tkrmId,
  });

  Future<void> _sendMessage(String message) async {
    final channel = IOWebSocketChannel.connect('$_wsUrl/$tkrmId/$userId');
    channel.sink.add(message);

    _fetchChatRoomListAfterSendMessage();
  }

  void _fetchChatRoomListAfterSendMessage() async {
    final channel = IOWebSocketChannel.connect('$_wsUrl/$tkrmId/$userId');

    channel.stream.listen((message) {
      TalkRoomsBloc(userId: message).sendMessage(tkrmId);
    });
  }

  final String _wsUrl = '${dotenv.env['WS_URL']}/chat-rooms';
}
