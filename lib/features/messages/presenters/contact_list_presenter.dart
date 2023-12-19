import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/authentication/blocs/user_detail_presenter.dart';
import 'package:sbas/features/messages/models/contact_list_map.dart';
import 'package:sbas/features/messages/models/user_contact_list_model.dart';
import 'package:sbas/features/messages/repos/contact_repo.dart';

class ContactListPresenter extends AsyncNotifier<ContactListMap> {
  ContactListMap contactListMap = ContactListMap(contactListMap: {});

  late final String? myInstTypeCd;

  @override
  FutureOr<ContactListMap> build() async {
    _contactRepository = ref.read(contactRepoProvider);

    final userDetailBloc = ref.read(userDetailProvider.notifier);
    final userDetail = userDetailBloc.state.value;
    if (userDetail != null) {
      myInstTypeCd = userDetail.instTypeCd;
    } else {
      throw StateError('User detail not available');
    }

    final contactList = UserContactList.fromJson(await _contactRepository.getAllUser("?myInstTypeCd=$myInstTypeCd"));
    final favoriteList = UserContactList.fromJson(await _contactRepository.getFavoriteContacts());

    contactListMap = ContactListMap.fromTwoLists(contacts: contactList, favorites: favoriteList);

    state = AsyncValue.data(contactListMap);

    return contactListMap;
  }

  Future<void> loadContacts(String queryParams) async {
    final contactList = UserContactList.fromJson(await _contactRepository.getAllUser("?myInstTypeCd=$myInstTypeCd$queryParams"));
    final favoriteList = UserContactList.fromJson(await _contactRepository.getFavoriteContacts());

    contactListMap = ContactListMap.fromTwoLists(contacts: contactList, favorites: favoriteList);

    state = AsyncValue.data(contactListMap);
  }

  TextEditingController searchTextController = TextEditingController();

  late final ContactRepository _contactRepository;
}

final contactListProvider =
    AsyncNotifierProvider<ContactListPresenter, ContactListMap>(
  () => ContactListPresenter(),
);