import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/models/base_attc_model.dart';

import '../providers/base_attc_provider.dart';

class FileRepository {
  Future<List<BaseAttcModel>> getFileList(String attcGrpId) async =>
      await _fileProvider.getFileList(attcGrpId);

  Future<void> downloadPublicImageFile(String attcGrpId, String attcId, String fileNm) async =>
      await _fileProvider.downloadPublicImageFile(attcGrpId, attcId, fileNm);

  final _fileProvider = BaseAttcProvider();
}

final fileRepoProvider = Provider(
  (ref) => FileRepository(),
);
