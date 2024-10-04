import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sbas/util.dart';

class PrivateImageProvider {

  Future<String> uploadImages(List<dio.MultipartFile> file, String? rmk) async {
    final client = dio.Dio();

    try {
      client.options.contentType = 'multipart/form-data';
      client.options.headers = authToken;

      final res = await client.postUri(
        Uri.parse('$_baseUrl/upload'),
        data: dio.FormData.fromMap(
          {
            'param1': rmk,
            'param2': file,
          },
        ),
      );
      if (res.statusCode == 200) {
        return res.data['result']['attcGrpId'];
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

  final String _baseUrl = '${dotenv.env['BASE_URL']}/v1/private/common';
}