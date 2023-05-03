import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sbas/util.dart';

class V1Provider {
  Future<Map<String, dynamic>> getAsync(String route) async {
    final client = Dio();

    try {
      client.options.contentType = 'application/json';
      client.options.headers = authToken;

      final res = await client.getUri(
        Uri.parse('$_baseUrl/$route'),
      );
      if (res.statusCode == 200) {
        return res.data['result'];
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

  Future<Map<String, dynamic>> postAsync(String route, String json) async {
    final client = Dio();

    try {
      client.options.contentType = 'application/json';
      client.options.headers = authToken;

      final res = await client.postUri(
        Uri.parse('$_baseUrl/$route'),
        data: json,
      );
      if (res.statusCode == 200) {
        if (kDebugMode) {
          print(res.data);
        }
        return res.data['result'];
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

  Future<void> sendPushMessage(String userId, String body, String token) async {
    final client = Dio();

    try {
      client.options.contentType = 'application/json';

      final res =
          await client.postUri(Uri.parse('${dotenv.env['BASE_URL']}/send'));
    } catch (e) {
      print(e);
    }
  }

  final String _baseUrl = '${dotenv.env['BASE_URL']}/v1';
}
