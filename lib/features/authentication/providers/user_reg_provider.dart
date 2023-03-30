import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:http/retry.dart';
import 'package:sbas/util.dart';

class UserRegProvider {
  Future<void> sendAuthMessage(Map<String, dynamic> map) async {
    final client = RetryClient(Client());

    try {
      await client.post(
        Uri.parse('$_baseUrl/smssend'),
        headers: json,
        body: toJson(map),
      );
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

  Future<void> reqUserReg(Map<String, dynamic> map) async {
    final client = RetryClient(Client());

    try {
      final res = await client.post(
        Uri.parse('$_baseUrl/requserreg'),
        headers: json,
        body: toJson(map),
      );
      if (kDebugMode) {
        print(res.statusCode);
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

  final String _baseUrl = '${dotenv.env['BASE_URL']}/v1/public/user';
}
