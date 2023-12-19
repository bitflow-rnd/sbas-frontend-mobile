import 'package:sbas/common/api/v1_provider.dart';

class ContactProvider {
  Future<Map<String, dynamic>> getAllContacts(String params) async => await _api.getAsync('$_privateRoute/users$params');
  Future<Map<String, dynamic>> getContactById(String targetId) async => await _api.getAsync('$_privateRoute/user/$targetId');
  Future<Map<String, dynamic>> getFavoriteContacts() async => await _api.getAsync('$_privateRoute/contact-users');

  final _privateRoute = 'private/user';
  final _api = V1Provider();
}
