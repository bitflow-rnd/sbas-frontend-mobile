import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/messages/models/message_attc_model.dart';

class MessageAttcProvider with ChangeNotifier {
  MessageAttcModel? _file;
  final String _baseUrl = '${dotenv.env['BASE_URL']}/v1/public/common';
  final Dio _client = Dio();

  MessageAttcModel? get file => _file;

  Future<MessageAttcModel?> fetchFile(String attcId) async {
    try {
      final res = await _client.get('$_baseUrl/image/$attcId');
      if (res.statusCode == 200) {
        _file = MessageAttcModel.fromJson(res.data);
        notifyListeners();
        return _file;
      } else {
        return null;
      }
    } catch (exception) {
      if (kDebugMode) {
        print({
          'exception': exception,
        });
      }
    } finally {
      _client.close();
    }
    return null;
  }
}

final messageAttcProvider = ChangeNotifierProvider.autoDispose
    .family<MessageAttcProvider, String>((ref, attcId) {
  final messageAttcProvider = MessageAttcProvider();
  messageAttcProvider.fetchFile(attcId);
  return messageAttcProvider;
});
