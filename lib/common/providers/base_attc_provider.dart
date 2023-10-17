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

  Future<void> downloadPublicImageFile(String attcGrpId, String attcId, String fileNm) async {
    await _api.downloadPublicImageFile(attcGrpId, attcId, fileNm);
  }

  Future<void> downloadPublicFile(String attcGrpId, String attcId, String fileNm) async {
    await _api.downloadPublicFile(attcGrpId, attcId, fileNm);
  }

  final String _privateRoute = 'private/common';
  final String _publicRoute = 'public/common';

  final _api = V1Provider();
}
