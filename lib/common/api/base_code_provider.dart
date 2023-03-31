import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:http/retry.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/util.dart';

class BaseCodeProvider {
  Future<List<BaseCodeModel>> getBaseCode(String route) async {
    final client = RetryClient(Client());

    try {
      final res = await client.get(
        Uri.parse('$_baseUrl/codes/$route'),
      );
      if (res.statusCode == 200) {
        final List<BaseCodeModel> list = [];

        for (var element in fromJson(res.body)['result']) {
          list.add(BaseCodeModel.fromJson(element));
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

  Future<String> uploadImage(dio.MultipartFile file) async {
    final client = dio.Dio();
    try {
      client.options.contentType = 'multipart/form-data';

      final res = await client.postUri(
        Uri.parse('$_baseUrl/upload'),
        data: dio.FormData.fromMap(
          {
            'param1': '',
            'param2': file,
          },
        ),
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

  final String _baseUrl = '${dotenv.env['BASE_URL']}/v1/public/common';
}
