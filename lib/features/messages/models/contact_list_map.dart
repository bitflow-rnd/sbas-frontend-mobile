import 'package:sbas/features/messages/models/user_contact_list_model.dart';

class ContactListMap {
  Map<String, UserContactList> contactListMap;

  ContactListMap({
    required this.contactListMap
  });

  ContactListMap.fromTwoLists({
    required UserContactList contacts,
    required UserContactList favorites,
  }) : contactListMap = {
    'contacts': contacts,
    'favorites': favorites,
  };
}
