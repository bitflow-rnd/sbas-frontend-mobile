import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/common/models/base_attc_model.dart';

import 'package:sbas/common/providers/base_attc_provider.dart';

class FileRepository {
  Future<List<BaseAttcModel>> getFileList(String attcGrpId) async =>
      await _fileProvider.getFileList(attcGrpId);

  Future<void> downloadPublicImageFile(String attcGrpId, String attcId, String fileNm) async =>
      await _fileProvider.downloadPublicImageFile(attcGrpId, attcId, fileNm);

  Future<void> downloadPublicFile(String attcGrpId, String attcId, String fileNm) async =>
      await _fileProvider.downloadPublicFile(attcGrpId, attcId, fileNm);

  Future<List<dynamic>> uploadPrivateImage(XFile file) async => await _fileProvider.uploadPrivateImage(
    await MultipartFile.fromFile(
      file.path,
      filename: file.name,
    ),
  );

  Future<dynamic> getDiagImage(String attcId) async {
    return await _fileProvider.getDiagImage(attcId);
  }

  final _fileProvider = BaseAttcProvider();
}

final fileRepoProvider = Provider(
  (ref) => FileRepository(),
);
