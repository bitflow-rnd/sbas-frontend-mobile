import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart' as dio;
import 'package:sbas/util.dart';

class PatientProvider {
  Future<dynamic> upldepidreport(dio.MultipartFile file) async {
    final client = dio.Dio();

    try {
      client.options.contentType = 'multipart/form-data';
      client.options.headers = authToken;

      final res = await client.postUri(
        Uri.parse('$_baseUrl/upldepidreport'),
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

  final String _baseUrl = '${dotenv.env['BASE_URL']}/v1/private/patient';
}
