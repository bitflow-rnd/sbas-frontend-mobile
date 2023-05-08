import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sbas/common/models/base_attc_model.dart';

class BaseAttcProvider {
  Future<BaseAttcModel> getFile(String attcId) async {
    final client = Dio();

    try {
      final res = await client.get('$_baseUrl/image/$attcId');
      if (res.statusCode == 200) {
        return BaseAttcModel.fromJson(res.data);
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
