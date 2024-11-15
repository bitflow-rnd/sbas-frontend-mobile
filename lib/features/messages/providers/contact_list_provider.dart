import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/messages/models/contact_condition_model.dart';
import 'package:sbas/features/messages/models/contact_list_map.dart';
import 'package:sbas/features/messages/models/user_contact_list_model.dart';
import 'package:sbas/features/messages/providers/contact_condition_provider.dart';
import 'package:sbas/features/messages/repos/contact_repo.dart';

class ContactListNotifier extends AsyncNotifier<ContactListMap> {
  ContactListMap contactListMap = ContactListMap(contactListMap: {});

  late final ContactConditionModel contactConditionModel;
  late final ContactRepository _contactRepository;

  @override
  FutureOr<ContactListMap> build() async {
    contactConditionModel = ref.watch(contactConditionProvider);
    _contactRepository = ref.read(contactRepoProvider);

    await _loadContacts();
    return contactListMap;
  }

  Future<void> loadContacts() async {
    await _loadContacts();
  }

  Future<void> _loadContacts() async {
    try {
      final contactList = UserContactList.fromJson(
          await _contactRepository.getAllContacts(contactConditionModel.toMap()));
      final favoriteList = UserContactList.fromJson(
          await _contactRepository.getFavoriteContacts());

      contactListMap = ContactListMap.fromTwoLists(
          contacts: contactList, favorites: favoriteList);

      state = AsyncValue.data(contactListMap);
    } catch (e) {
      print('error: $e');
    }
  }

  TextEditingController searchTextController = TextEditingController();
}

final contactListProvider =
    AsyncNotifierProvider<ContactListNotifier, ContactListMap>(
  () => ContactListNotifier(),
);