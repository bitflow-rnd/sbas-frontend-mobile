import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sbas/util.dart';
import 'package:http/http.dart' as http;

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

      // if (kDebugMode) {
      //   showToast(res.data['message']);
      // }
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
        if (! !kDebugMode) {
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

      final res = await client.postUri(
          Uri.parse('${dotenv.env['BASE_URL']}/send'));
      if (kDebugMode) {
        print(res.toString());
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> downloadPublicImageFile(String attcGrpId, String attcId, String fileNm) async {
    final url = '$_baseUrl/public/common/download/$attcGrpId/$attcId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      final contentDisposition = response.headers['content-disposition'];

      final result = await ImageGallerySaver.saveImage(bytes);

      if (result['isSuccess']) {
        print('Image has been saved to gallery');
      } else {
        print('Failed to save image to gallery');
      }
    } else {
      print('Error during file download: ${response.statusCode}');
    }
  }

  String? _extractFileName(String? contentDisposition) {
    if (contentDisposition == null) return null;
    final match = RegExp(r'filename="(.+)"').firstMatch(contentDisposition);
    if (match != null && match.groupCount >= 1) {
      return match.group(1);
    }
    return null;
  }

  final String _baseUrl = '${dotenv.env['BASE_URL']}/v1';
}
