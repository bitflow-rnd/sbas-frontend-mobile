import 'package:sbas/common/api/v1_provider.dart';

import '../models/base_attc_model.dart';

class BaseAttcProvider {
  Future<List<BaseAttcModel>> getFileList(String attcGrpId) async {
    final response = await _api.getAsync('$_privateRoute/files/$attcGrpId');

    if (response is List<dynamic>) {
      return response.map((item) => BaseAttcModel.fromJson(item as Map<String, dynamic>)).toList();
    } else {
      throw Exception("Invalid response format");
    }
  }

  Future<dynamic> downloadFile(String attcGrpId, String attcId) async =>
      await _api.getAsync('$_publicRoute/download/$attcGrpId/$attcId');

  final String _privateRoute = 'private/common';
  final String _publicRoute = 'public/common';

  final _api = V1Provider();
}
