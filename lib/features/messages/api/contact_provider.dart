import 'package:sbas/common/api/v1_provider.dart';
import 'package:sbas/util.dart';

class ContactProvider {
  Future<Map<String, dynamic>> getAllContacts(Map<String, dynamic> map) async =>
      await _api.getAsyncWithMap('$_privateRoute/users', map);

  Future<Map<String, dynamic>> getContactById(String targetId) async =>
      await _api.getAsync('$_privateRoute/user/$targetId');

  Future<Map<String, dynamic>> getFavoriteContacts() async =>
      await _api.getAsync('$_privateRoute/contact-users');

  Future<Map<String, dynamic>> addFavorite(Map<String, dynamic> map) async =>
      await _api.postAsync('$_privateRoute/reg-favorite', toJson(map));

  Future<Map<String, dynamic>> deleteFavorite(Map<String, dynamic> map) async =>
      await _api.postAsync('$_privateRoute/del-favorite', toJson(map));

  Future<Map<String, dynamic>> doChat(Map<String, dynamic> map) async =>
      await _api.postAsync('$_privateTalkRoute/personal', toJson(map));

  Future<Map<String, dynamic>> getRecentActivity(String userId) async =>
      await _api.getAsync('$_privateRoute/activity-history/$userId');

  Future<Map<String, dynamic>> getAllUser(Map<String, dynamic> map) async =>
      await _api.getAsyncWithMap('$_adminRoute/users', map);

  Future<dynamic> regGroupChatRoom(Map<String, dynamic> map) async =>
      await _api.postAsync('$_privateTalkRoute/group', toJson(map));

  final _privateTalkRoute = 'private/talk';
  final _privateRoute = 'private/user';
  final _adminRoute = 'admin/user';
  final _api = V1Provider();
}
