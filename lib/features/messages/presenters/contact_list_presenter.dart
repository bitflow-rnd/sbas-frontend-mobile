import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/messages/models/contact_condition_model.dart';
import 'package:sbas/features/messages/models/contact_list_map.dart';
import 'package:sbas/features/messages/models/user_contact_list_model.dart';
import 'package:sbas/features/messages/presenters/contact_condition_presenter.dart';
import 'package:sbas/features/messages/repos/contact_repo.dart';

class ContactListPresenter extends AsyncNotifier<ContactListMap> {
  ContactListMap contactListMap = ContactListMap(contactListMap: {});

  late final ContactConditionModel contactConditionModel;
  late final ContactRepository _contactRepository;

  @override
  FutureOr<ContactListMap> build() async {
    contactConditionModel = ref.watch(contactConditionPresenter);
    _contactRepository = ref.read(contactRepoProvider);

    await _loadContacts();
    return contactListMap;
  }

  Future<void> loadContacts() async {
    await _loadContacts();
  }

  Future<void> _loadContacts() async {
    try {
      print('map : ${contactConditionModel.toMap()}');
      final contactList = UserContactList.fromJson(
          await _contactRepository.getAllUser(contactConditionModel.toMap()));
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
    AsyncNotifierProvider<ContactListPresenter, ContactListMap>(
  () => ContactListPresenter(),
);