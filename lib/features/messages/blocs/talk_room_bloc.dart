import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/features/messages/models/talk_msg_model.dart';
import 'package:sbas/util.dart' as util;
import 'package:web_socket_channel/io.dart';
import 'dart:developer';

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

  late final channel = IOWebSocketChannel.connect(
    '$_wsUrl/$tkrmId?u=$userId',
    pingInterval: const Duration(seconds: 30),
    connectTimeout: const Duration(seconds: 5),
  );

  void _fetchChattingRoom() async {
    channel.sink.add("hello|$userId");
    print("message_fetchChattingRoom");
    channel.stream.listen((message) {
      print("message" + message);

      try {
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
      } catch (e) {
        log("test");
      }
    }, onError: (error) {
      _chatDetailListController.addError(error);
    });
  }

  Future<void> sendMessage(String message) async {
    log("$userId|$message");
    channel.sink.add("$userId|$message");
  }

  Future<void> uploadFile(XFile? file, String? msg) async {
    var client = dio.Dio();
    const int maxFileSize = 1024 * 1024 * 50;
    var uploadFile = await dio.MultipartFile.fromFile(
      file!.path,
      filename: file.name,
    );

    if (uploadFile.length > maxFileSize) {
      util.showToast("파일 용량이 너무 큽니다. 50MB 미만의 파일을 사용해 주세요.");
      client.close();
      return;
    }

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
        sendMessage('attcId:${attcId}|$msg');
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

  // @override
  Future<void> close() async {
    await channel.sink.close();
    _chatDetailListController.close();
  }

  final String _wsUrl = '${dotenv.env['WS_URL']}/chat-rooms/room';
  final String _baseUrl = '${dotenv.env['BASE_URL']}/v1/public/common';
}
