import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/common/providers/base_code_provider.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/features/authentication/models/info_inst_model.dart';
import 'package:sbas/features/authentication/models/user_reg_req_model.dart';
import 'package:sbas/features/authentication/providers/info_inst_provider.dart';
import 'package:sbas/features/authentication/providers/user_reg_provider.dart';

class UserRegRequestRepository {
  Future<void> sendAuthMessage(String phoneNumber) async {
    await _userRegProvider.sendAuthMessage({
      'to': phoneNumber,
    });
  }

  Future<int> reqUserReg(UserDetailModel model) async {
    final bytes = utf8.encode(model.pw ?? '');
    model.pw = sha512.convert(bytes).toString();

    return await _userRegProvider.reqUserReg(model.toJson());
  }

  Future<Map<String, dynamic>> confirm(String phoneNumber, String authNumber) async {
    return await _userRegProvider.confirm({
      'phoneNo': phoneNumber,
      'certNo': authNumber,
    });
  }

  Future<List<BaseCodeModel>> getBaseCode(String route) async => await _baseCodeProvider.getBaseCode(route);
  Future<String> getBaseCodeNm(String route) async => await _baseCodeProvider.getBaseCodeNm(route);

  Future<List<InfoInstModel>> getPublicHealthCenter(
    String dstrCd1,
  ) async =>
      await _baseOrganProvider.getOrganCode(
        // 'instTypecd=ORGN0003&dstrCd1=$dstrCd1',
        // ORGN003 으로 안나와서 002로 수정.
        'instTypecd=ORGN0003&dstrCd1=$dstrCd1',
      );
  Future<List<InfoInstModel>> getCodeDstr1OrgnCd(
    String typeCd,
    String dstrCd1,
  ) async =>
      await _baseOrganProvider.getOrganCode(
        'instTypecd=$typeCd&dstrCd1=$dstrCd1',
      );
  Future<List<InfoInstModel>> getOrganCode(
    String typeCd,
    String dstrCd2,
  ) async =>
      await _baseOrganProvider.getOrganCode(
        'instTypecd=$typeCd&dstrCd2=$dstrCd2',
      );

  Future<String> uploadImage(XFile file) async => await _baseCodeProvider.uploadImage(
        await MultipartFile.fromFile(
          file.path,
          filename: file.name,
        ),
      );
  final _userRegProvider = UserRegProvider();

  final _baseCodeProvider = BaseCodeProvider();

  final _baseOrganProvider = InfoInstProvider();
}

final userRegReqProvider = Provider(
  (ref) => UserRegRequestRepository(),
);
