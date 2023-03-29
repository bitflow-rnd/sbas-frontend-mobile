import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/api/base_code_provider.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/features/authentication/providers/user_reg_provider.dart';

class UserRegRequestRepository {
  Future<void> sendAuthMessage(String phoneNumber) async {
    await _userRegProvider.sendAuthMessage({
      'to': phoneNumber,
    });
  }

  Future<List<BaseCodeModel>> getBaseCode(String route) async =>
      await _baseCodeProvider.getBaseCode(route);

  final _userRegProvider = UserRegProvider();

  final _baseCodeProvider = BaseCodeProvider();
}

final userRegReqProvider = Provider(
  (ref) => UserRegRequestRepository(),
);
