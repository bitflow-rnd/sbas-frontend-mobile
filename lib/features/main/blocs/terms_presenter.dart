import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/main/repos/terms_repo.dart';

import '../models/terms_detail_model.dart';
import '../models/terms_list_model.dart';

class TermsPresenter extends AsyncNotifier{
  late final TermsRepository _repository;

  @override
  FutureOr build() {
    _repository = ref.read(termsRepoProvider);
  }

  Future<void> getTermsList(String termsType) async {
    ref.read(termsListProvider.notifier).state = await _repository.getTermsList(termsType);
  }

  Future<void> getTermsDetail(String termsType, String termsVersion) async {
    ref.read(termsDetailProvider.notifier).state = await _repository.getTermsDetail(termsType, termsVersion);
  }

  List<String> getDropdownList() {
    final termsList = ref.read(termsListProvider.notifier).state;
    final List<String> resultList = [];
    for(var item in termsList!){
      resultList.add(item.id.effectiveDt);
    }
    return resultList;
  }

}

final termsPresenter = AsyncNotifierProvider<TermsPresenter, void> (() => TermsPresenter());

final termsListProvider = StateProvider<List<TermsListModel>?>((ref) => null);
final termsDetailProvider = StateProvider<TermsDetailModel?>((ref) => null);