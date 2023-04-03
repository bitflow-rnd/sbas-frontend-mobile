import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:http/retry.dart';
import 'package:sbas/util.dart';

class LoginProvider {
  Future<Map<String, dynamic>?> postSignIn(Map<String, dynamic> map) async {
    final client = RetryClient(Client());

    try {
      final res = await client.post(
        Uri.parse('$_baseUrl/v1/public/user/login'),
        headers: json,
        body: toJson(map),
      );
      if (res.statusCode == 200) {
        return fromJson(res.body);
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
    return null;
  }

  Future<Map<String, dynamic>?> getUser(String authToken) async {
    final client = RetryClient(Client());

    try {
      final res = await client.get(
        Uri.parse('$_baseUrl/v1/test/user'),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );
      if (res.statusCode == 200) {
        return fromJson(res.body);
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
    return null;
  }

  final String _baseUrl = dotenv.env['BASE_URL']!;
}
