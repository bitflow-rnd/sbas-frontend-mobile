import 'package:sbas/common/api/v1_provider.dart';
import 'package:sbas/util.dart';

class ContactProvider {
  Future<Map<String, dynamic>> getAllContacts(String params) async => await _api.getAsync('$_privateRoute/users$params');
  Future<Map<String, dynamic>> getContactById(String targetId) async => await _api.getAsync('$_privateRoute/user/$targetId');
  Future<Map<String, dynamic>> getFavoriteContacts() async => await _api.getAsync('$_privateRoute/contact-users');
  Future<Map<String, dynamic>> addFavorite(Map<String, dynamic> map) async => await _api.postAsync('$_privateRoute/reg-favorite', toJson(map));
  Future<Map<String, dynamic>> deleteFavorite(Map<String, dynamic> map) async => await _api.postAsync('$_privateRoute/del-favorite', toJson(map));


  final _privateRoute = 'private/user';
  final _api = V1Provider();
}
