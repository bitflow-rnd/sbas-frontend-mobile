import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/messages/models/contact_condition_model.dart';

class ContactConditionPresenter extends StateNotifier<ContactConditionModel> {
  ContactConditionPresenter() : super(ContactConditionModel());

  void setCondition({
    String? telno,
    String? ptTypeCd,
    String? instTypeCd,
    String? dstr1Cd,
    String? dstr2Cd,
    String? instNm,
  }) {
    state = ContactConditionModel(
      telno: telno,
      ptTypeCd: ptTypeCd,
      instTypeCd: instTypeCd,
      dstr1Cd: dstr1Cd,
      dstr2Cd: dstr2Cd,
      instNm: instNm,
    );
    print('state : $state');
  }
}

final contactConditionPresenter = StateNotifierProvider<ContactConditionPresenter, ContactConditionModel>(
        (ref) => ContactConditionPresenter(),
);