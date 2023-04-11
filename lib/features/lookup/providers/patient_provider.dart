import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:sbas/util.dart';

class PatientProvider {
  Future<dynamic> lookupPatientInfo() async {
    final client = Dio();

    try {
      client.options.contentType = 'application/json';
      client.options.headers = authToken;

      final res = await client.getUri(
        Uri.parse('$_baseUrl/search'),
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

  Future<dynamic> getAllocationHistory(String id) async {
    final client = Dio();

    try {
      client.options.contentType = 'application/json';
      client.options.headers = authToken;

      final res = await client.getUri(
        Uri.parse('$_baseUrl/basicinfo/$id'),
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

  Future<dynamic> upldepidreport(MultipartFile file) async {
    final client = Dio();

    try {
      client.options.contentType = 'multipart/form-data';
      client.options.headers = authToken;

      final res = await client.postUri(
        Uri.parse('$_baseUrl/upldepidreport'),
        data: FormData.fromMap(
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

  Future<dynamic> registerPatientInfo(String json) async {
    final client = Dio();

    try {
      client.options.contentType = 'application/json';
      client.options.headers = authToken;

      final res = await client.postUri(
        Uri.parse('$_baseUrl/regbasicinfo'),
        data: json,
      );
      if (res.statusCode == 200) {
        if (kDebugMode) {
          print(res.data);
        }
        return res.data;
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

  Future<dynamic> amendPatientInfo(String id, String json) async {
    final client = Dio();

    try {
      client.options.contentType = 'application/json';
      client.options.headers = authToken;

      final res = await client.postUri(
        Uri.parse('$_baseUrl/modinfo/$id'),
        data: json,
      );
      if (res.statusCode == 200) {
        if (kDebugMode) {
          print(res.data);
        }
        return res.data;
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
