import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sbas/common/api/v1_provider.dart';
import 'package:sbas/util.dart';
import 'package:sbas/common/models/base_attc_model.dart';

class BaseAttcProvider {
  Future<List<BaseAttcModel>> getFileList(String attcGrpId) async {
    final response = await _api.getAsync('$_privateRoute/files/$attcGrpId');

    if (response is List<dynamic>) {
      return response.map((item) => BaseAttcModel.fromJson(item as Map<String, dynamic>)).toList();
    } else {
      throw Exception("Invalid response format");
    }
  }

  Future<void> downloadPublicImageFile(String attcGrpId, String attcId, String fileNm) async {
    await _api.downloadPublicImageFile(attcGrpId, attcId, fileNm);
  }

  Future<void> downloadPublicFile(String attcGrpId, String attcId, String fileNm) async {
    await _api.downloadPublicFile(attcGrpId, attcId, fileNm);
  }

  Future<List<dynamic>> uploadPrivateImage(dio.MultipartFile file) async {
    final client = dio.Dio();

    try {
      client.options.contentType = 'multipart/form-data';
      client.options.headers = authToken;

      final res = await client.postUri(
        Uri.parse('$_privateBaseUrl/upload'),
        data: dio.FormData.fromMap(
          {
            'param1': '',
            'param2': file,
          },
        ),
      );
      if (res.statusCode == 200) {
        return res.data['result']['attcId'];
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

  Future<List<Uint8List>> getDiagImage(String attcGrpId) async {
    final client = dio.Dio();

    try {
      client.options.headers = authToken;
      final res = await client.getUri(
        Uri.parse('$_privateBaseUrl/images/$attcGrpId'),
        options: Options(responseType: ResponseType.json),
      );
      if (res.statusCode == 200) {
        List<Uint8List> imageList = [];
        for(var item in res.data['result']['items']) {
          imageList.add(base64Decode(item));
        }
        return imageList;
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
    throw ArgumentError('Failed to load image');
  }

  final String _privateRoute = 'private/common';
  final String _publicRoute = 'public/common';
  final String _privateBaseUrl = '${dotenv.env['BASE_URL']}/v1/private/common';

  final _api = V1Provider();
}
