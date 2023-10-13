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

  final String _privateRoute = 'private/common';

  final _api = V1Provider();
}
