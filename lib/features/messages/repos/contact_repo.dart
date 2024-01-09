import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/messages/api/contact_provider.dart';
import 'package:sbas/features/messages/models/chat_request_model.dart';
import 'package:sbas/features/messages/models/favorite_request_model.dart';

class ContactRepository {
  Future<Map<String, dynamic>> getAllUser(Map<String, dynamic> map) async => (await _contactProvider.getAllContacts(map));
  Future<Map<String, dynamic>> getContactById(String targetId) async => (await _contactProvider.getContactById(targetId));
  Future<Map<String, dynamic>> getFavoriteContacts() async => await _contactProvider.getFavoriteContacts();
  Future<Map<String, dynamic>> addFavorite(FavoriteRequestModel request) async => await _contactProvider.addFavorite(request.toJson());
  Future<Map<String, dynamic>> deleteFavorite(FavoriteRequestModel request) async => await _contactProvider.deleteFavorite(request.toJson());
  Future<Map<String, dynamic>> doChat(ChatRequestModel request) async => await _contactProvider.doChat(request.toJson());

  final _contactProvider = ContactProvider();
}

final contactRepoProvider = Provider((ref) => ContactRepository());
