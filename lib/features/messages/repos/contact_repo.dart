import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/messages/api/contact_provider.dart';

class ContactRepository {
  Future<Map<String, dynamic>> getAllUser() async => (await _contactProvider.getAllContacts());
  Future<Map<String, dynamic>> getContactById(String targetId) async => (await _contactProvider.getContactById(targetId));
  Future<Map<String, dynamic>> getFavoriteContacts() async => await _contactProvider.getFavoriteContacts();

  final _contactProvider = ContactProvider();
}

final contactRepoProvider = Provider((ref) => ContactRepository());
