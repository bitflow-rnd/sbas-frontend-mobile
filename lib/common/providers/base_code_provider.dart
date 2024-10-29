import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:http/retry.dart';
import 'package:sbas/common/api/v1_provider.dart';
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

  Future<String> getBaseCodeNm(String route) async {
    final client = RetryClient(Client());

    try {
      final res = await client.get(
        Uri.parse('$_baseUrl/code/$route'),
      );
      if (res.statusCode == 200) {
        return fromJson(res.body)['result'];
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

  Future<List<BaseCodeModel>> getSido() async {
    final response = await _api.getAsync('public/common/sidos');
    if (response is List<dynamic>) {
      return response.map((item) => BaseCodeModel.fromJson(item as Map<String, dynamic>)).toList();
    } else {
      throw Exception("Invalid response format");
    }
  }

  Future<List<BaseCodeModel>> getGugun(String cdGrpId) async {
    final response = await _api.getAsync('public/common/guguns/$cdGrpId');
    if (response is List<dynamic>) {
      return response.map((item) => BaseCodeModel.fromJson(item as Map<String, dynamic>)).toList();
    } else {
      throw Exception("Invalid response format");
    }
  }

  final _api = V1Provider();
  final String _baseUrl = '${dotenv.env['BASE_URL']}/v1/public/common';
}
