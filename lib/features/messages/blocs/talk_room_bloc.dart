import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/features/messages/models/talk_msg_model.dart';
import 'package:sbas/features/messages/providers/talk_rooms_provider.dart';
import 'package:sbas/util.dart' as util;
import 'package:web_socket_channel/io.dart';

class TalkRoomBloc {
  final String userId;
  final String tkrmId;
  final TalkRoomsProvider provider;
  final _chatDetailListController = StreamController<List<TalkMsgModel>>();

  TalkRoomBloc({
    required this.userId,
    required this.tkrmId,
    required this.provider,
  }) {
    _fetchChattingRoom();
  }

  Stream<List<TalkMsgModel>> get chatDetailListStream =>
      _chatDetailListController.stream;

  late final List<TalkMsgModel> chatDetailList;

  late final channel = IOWebSocketChannel.connect(
    '$_wsUrl/$tkrmId/$userId',
    pingInterval: const Duration(seconds: 30),
    connectTimeout: const Duration(seconds: 5),
  );

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
    });
  }

  Future<void> sendMessage(String message) async {
    channel.sink.add(message);
  }

  Future<void> uploadFile(XFile? file) async {
    var client = dio.Dio();
    var uploadFile = await dio.MultipartFile.fromFile(
      file!.path,
      filename: file.name,
    );
    try {
      client.options.contentType = 'multipart/form-data';
      client.options.headers = util.authToken;

      final res = await client.postUri(
        Uri.parse('$_baseUrl/upload'),
        data: dio.FormData.fromMap(
          {
            'param1': '',
            'param2': uploadFile,
          },
        ),
      );
      if (res.statusCode == 200) {
        var attcId = res.data['result'];
        sendMessage('attcId:$attcId');
      }
    } catch (exception) {
      if (kDebugMode) {
        print({
          'exception': exception,
        });
      }
    } finally {
      client.close();
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    _chatDetailListController.close();
  }

  final String _wsUrl = '${dotenv.env['WS_URL']}/chat-rooms';
  final String _baseUrl = '${dotenv.env['BASE_URL']}/v1/public/common';
}
