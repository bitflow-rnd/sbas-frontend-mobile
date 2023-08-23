import 'package:sbas/common/api/v1_provider.dart';

class ContactProvider {
  Future<Map<String, dynamic>> getAllContacts() async => await _api.getAsync('$_privateRoute/all-users');

  final _privateRoute = 'private/user';
  final _api = V1Provider();
}
