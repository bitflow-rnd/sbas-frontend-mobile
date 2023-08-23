import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/messages/models/user_contact_list_model.dart';
import 'package:sbas/features/messages/repos/contact_repo.dart';

class ContactListPresenter extends AsyncNotifier<UserContactList> {
  @override
  FutureOr<UserContactList> build() async {
    _contactRepository = ref.read(contactRepoProvider);

    return UserContactList.fromJson(await _contactRepository.getAllUser());
  }

  TextEditingController searchTextController = TextEditingController();

  late final ContactRepository _contactRepository;
}

final contactListProvider = AsyncNotifierProvider<ContactListPresenter, UserContactList>(
  () => ContactListPresenter(),
);
