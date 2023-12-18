import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/messages/models/contact_list_map.dart';
import 'package:sbas/features/messages/models/user_contact_list_model.dart';
import 'package:sbas/features/messages/repos/contact_repo.dart';

class ContactListPresenter extends AsyncNotifier<ContactListMap> {
  late final ContactListMap contactListMap;

  @override
  FutureOr<ContactListMap> build() async {
    _contactRepository = ref.read(contactRepoProvider);

    final contactList = UserContactList.fromJson(await _contactRepository.getAllUser());
    final favoriteList = UserContactList.fromJson(await _contactRepository.getFavoriteContacts());

    contactListMap = ContactListMap.fromTwoLists(contacts: contactList, favorites: favoriteList);

    return contactListMap;
  }

  TextEditingController searchTextController = TextEditingController();

  late final ContactRepository _contactRepository;
}

final contactListProvider = AsyncNotifierProvider<ContactListPresenter, ContactListMap>(
  () => ContactListPresenter(),
);
