import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/api/base_code_provider.dart';
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

  Future<int> reqUserReg(UserRegModel model) async {
    final bytes = utf8.encode(model.pw ?? '');
    model.pw = sha512.convert(bytes).toString();

    return await _userRegProvider.reqUserReg(model.toJson());
  }

  Future<List<BaseCodeModel>> getBaseCode(String route) async =>
      await _baseCodeProvider.getBaseCode(route);

  Future<List<InfoInstModel>> getOrganCode(
    String typeCd,
    String dstrCd2,
  ) async =>
      await _baseOrganProvider.getOrganCode(
        'instTypecd=$typeCd&dstrCd2=$dstrCd2',
      );

  final _userRegProvider = UserRegProvider();

  final _baseCodeProvider = BaseCodeProvider();

  final _baseOrganProvider = InfoInstProvider();
}

final userRegReqProvider = Provider(
  (ref) => UserRegRequestRepository(),
);
