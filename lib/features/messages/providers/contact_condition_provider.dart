import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/messages/models/contact_condition_model.dart';

class ContactConditionNotifier extends StateNotifier<ContactConditionModel> {
  ContactConditionNotifier() : super(ContactConditionModel());

  void setCondition({
    String? search,
    String? myInstTypeCd,
    String? instTypeCd,
    String? dstr1Cd,
    String? dstr2Cd,
    String? instNm,
  }) {
    state = ContactConditionModel(
      search: search,
      myInstTypeCd: myInstTypeCd,
      instTypeCd: instTypeCd,
      dstr1Cd: dstr1Cd,
      dstr2Cd: dstr2Cd,
    );
  }
}

final contactConditionProvider = StateNotifierProvider<ContactConditionNotifier, ContactConditionModel>(
        (ref) => ContactConditionNotifier(),
);