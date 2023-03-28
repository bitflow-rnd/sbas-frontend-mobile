import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/authentication/providers/user_reg_provider.dart';

class UserRegRequestRepository {
  Future<void> sendAuthMessage(String phoneNumber) async {
    await _userRegProvider.sendAuthMessage({
      'to': phoneNumber,
    });
  }

  final _userRegProvider = UserRegProvider();
}

final userRegReqProvider = Provider(
  (ref) => UserRegRequestRepository(),
);
