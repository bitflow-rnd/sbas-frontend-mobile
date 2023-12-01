import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:http/retry.dart';
import 'package:sbas/features/authentication/models/info_inst_model.dart';
import 'package:sbas/util.dart';

class InfoInstProvider {
  Future<List<InfoInstModel>> getOrganCode(Map<String, String?> query) async {
    final client = RetryClient(Client());
    final filteredQuery =
        Map.fromEntries(query.entries.where((e) => e.value != null));

    try {
      final res = await client.get(
        Uri.parse(_baseUrl).replace(queryParameters: filteredQuery),
      );
      if (res.statusCode == 200) {
        final List<InfoInstModel> list = [];
        final items = fromJson(res.body);

        items['result']['items'].forEach((element) {
          list.add(InfoInstModel.fromJson(element));
        });

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

  final String _baseUrl = '${dotenv.env['BASE_URL']}/v1/public/organ/codes';
}
