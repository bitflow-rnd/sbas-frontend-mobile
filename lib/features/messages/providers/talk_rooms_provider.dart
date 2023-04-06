import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:http/retry.dart';
import 'package:sbas/util.dart';
import 'package:sbas/features/messages/models/talk_rooms_model.dart';

class TalkRoomsProvider {
  Future<List<TalkRoomsModel>> getMyChats() async {
    final client = RetryClient(Client());

    try {
      final response = await client.get(
        Uri.parse('$_baseUrl/my-chats'),
        headers: <String, String>{
          'Authorization': 'Bearer ${prefs.getString('auth_token')}}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final List<TalkRoomsModel> list = [];

        for (var item in fromJson(response.body)['result']) {
          list.add(TalkRoomsModel.fromJson(item));
        }
        return list;
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
    throw ArgumentError();
  }

  final String _baseUrl = '${dotenv.env['BASE_URL']}/v1/private/talk';
}
