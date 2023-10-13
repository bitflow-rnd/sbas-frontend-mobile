import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/models/base_attc_model.dart';

import '../providers/base_attc_provider.dart';

class FileRepository {
  Future<List<BaseAttcModel>> getFileList(String attcGrpId) async =>
      await _fileProvider.getFileList(attcGrpId);

  final _fileProvider = BaseAttcProvider();
}

final fileRepoProvider = Provider(
  (ref) => FileRepository(),
);
