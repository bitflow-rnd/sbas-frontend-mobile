import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:http/retry.dart';
import 'package:sbas/util.dart';

class UserRegProvider {
  Future<int> sendAuthMessage(Map<String, dynamic> map) async {
    final client = RetryClient(Client());

    try {
      final res = await client.post(
        Uri.parse('$_baseUrl/smssend'),
        headers: json,
        body: toJson(map),
      );
      return res.statusCode;
    } catch (exception) {
      if (kDebugMode) {
        print({
          'exception': exception,
        });
      }
    } finally {
      client.close();
    }
    return 0;
  }

  Future<int> reqUserReg(Map<String, dynamic> map) async {
    final client = RetryClient(Client());

    try {
      final res = await client.post(
        Uri.parse('$_baseUrl/requserreg'),
        headers: json,
        body: toJson(map),
      );
      return res.statusCode;
    } catch (exception) {
      if (kDebugMode) {
        print({
          'exception': exception,
        });
      }
    } finally {
      client.close();
    }
    return 0;
  }

  Future<Map<String, dynamic>> confirm(Map<String, dynamic> map) async {
    final client = RetryClient(Client());

    try {
      final res = await client.post(
        Uri.parse('$_baseUrl/confirmsms'),
        headers: json,
        body: toJson(map),
      );
      return {
        'statusCode': res.statusCode,
          'code': fromJson(res.body)['code'],
        'message': fromJson(res.body)['message'],
      };
    } catch (exception) {
      if (kDebugMode) {
        print({
          'exception': exception,
        });
      }
    } finally {
      client.close();
    }
    return {};
  }

  Future<String> findId(Map<String, dynamic> map) async {
    final client = RetryClient(Client());

    try {
      final res = await client.post(
        Uri.parse('$_baseUrl/find-id'),
        headers: json,
        body: toJson(map),
      );
      print(fromJson(res.body)['message']);
      return fromJson(res.body)['result'];
    } catch (exception) {
      if (kDebugMode) {
        print({
          'exception': exception,
        });
      }
    } finally {
      client.close();
    }
    return '';
  }

  Future<String> initPw(Map<String, dynamic> map) async {
    final client = RetryClient(Client());

    try {
      final res = await client.post(
        Uri.parse('$_baseUrl/init-pw'),
        headers: json,
        body: toJson(map),
      );
      print(fromJson(res.body)['message']);
      return fromJson(res.body)['result'];
    } catch (exception) {
      if (kDebugMode) {
        print({
          'exception': exception,
        });
      }
    } finally {
      client.close();
    }
    return '';
  }

  Future<bool> existId(String? userId) async {
    final client = Dio();

    try {
      client.options.contentType = 'application/json';

      final res = await client.post(
        '$_baseUrl/existid',
        data: toJson({'userId': userId}),
      );

      if (res.statusCode == 200) {
        return res.data['result'];
      } else {
        return false;
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
    return false;
  }

  final String _baseUrl = '${dotenv.env['BASE_URL']}/v1/public/user';
}
