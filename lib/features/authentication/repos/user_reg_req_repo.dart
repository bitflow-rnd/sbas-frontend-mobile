import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/common/providers/base_code_provider.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/common/providers/private_image_provider.dart';
import 'package:sbas/features/authentication/models/info_inst_model.dart';
import 'package:sbas/features/authentication/models/user_reg_req_model.dart';
import 'package:sbas/features/authentication/providers/info_inst_provider.dart';
import 'package:sbas/features/authentication/providers/user_reg_provider.dart';

class UserRegRequestRepository {
  Future<int> sendAuthMessage(String phoneNumber) async {
    return await _userRegProvider.sendAuthMessage({
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

  Future<String> findId(String userNm, String telno) async {
    return await _userRegProvider.findId({
      'userNm': userNm,
      'telno': telno,
    });
  }

  Future<String> modifyPw(String id, String pw) async {
    return await _userRegProvider.modifyPw({
      'id': id,
      'modifyPw': pw,
    });
  }

  Future<bool> existId(String? userId) async {
    return await _userRegProvider.existId(userId);
  }

  Future<List<BaseCodeModel>> getBaseCode(String route) async =>
      await _baseCodeProvider.getBaseCode(route);

  Future<String> getBaseCodeNm(String route) async =>
      await _baseCodeProvider.getBaseCodeNm(route);

  Future<List<InfoInstModel>> getOrganCode(
    String? typeCd,
    String? dstr1Cd,
    String? dstr2Cd,
  ) async {
    final Map<String, String?> query = {
      'instTypecd': typeCd,
      'dstr1Cd': dstr1Cd,
      'dstr2Cd': dstr2Cd,
    };
    return await _baseOrganProvider.getOrganCode(query);
  }

  Future<String> uploadImage(List<XFile> files, String? rmk) async {
    List<MultipartFile> multipartFiles = [];

    for(var file in files) {
      multipartFiles.add(
        await MultipartFile.fromFile(
          file.path,
          filename: file.name,
        )
      );
    }

    return await _privateImageProvider.uploadImages(multipartFiles, rmk);
  }
  final _userRegProvider = UserRegProvider();

  final _baseCodeProvider = BaseCodeProvider();

  final _privateImageProvider = PrivateImageProvider();

  final _baseOrganProvider = InfoInstProvider();
}

final userRegReqProvider = Provider(
  (ref) => UserRegRequestRepository(),
);
