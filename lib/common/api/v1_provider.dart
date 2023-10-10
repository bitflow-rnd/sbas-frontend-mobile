import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sbas/util.dart';

class V1Provider {
  Future<dynamic> getAsync(String route) async {
    final client = Dio();

    try {
      client.options.contentType = 'application/json';
      client.options.headers = authToken;

      final res = await client.getUri(
        Uri.parse('$_baseUrl/$route'),
      );
      if (kDebugMode) {
        showToast(res.data['message']);
      }
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

  Future<dynamic> getAsyncWithJson(String route, String json) async {
    final client = Dio();

    try {
      client.options.contentType = 'application/json';
      client.options.headers = authToken;

      final res = await client.getUri(
        Uri.parse('$_baseUrl/$route'),
        data: json,
      );
      if (kDebugMode) {
        showToast(res.data['message']);
      }
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

  Future<dynamic> postAsync(String route, String json) async {
    final client = Dio();

    try {
      client.options.contentType = 'application/json';
      client.options.headers = authToken;

      final res = await client.postUri(
        Uri.parse('$_baseUrl/$route'),
        data: json,
      );
      if (kDebugMode) {
        showToast(res.data['message']);
      }
      if (res.statusCode == 200) {
        if (!!kDebugMode) {
          print(res.data);
        }
        return res.data['result'] ?? res.data['message'];
      }
    } on DioException catch (exception) {
      if (kDebugMode) {
        if (route.contains("bedassignreq")) {
          showToast(exception.toString());
        }
        if (exception.response?.data['message'] == 'check push token') {
          // 백엔드 토큰이슈
          return true;
        }

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

      final res = await client.postUri(Uri.parse('${dotenv.env['BASE_URL']}/send'));
      if (kDebugMode) {
        print(res.toString());
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  final String _baseUrl = '${dotenv.env['BASE_URL']}/v1';
}
