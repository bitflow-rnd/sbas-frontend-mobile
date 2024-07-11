import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/main/repos/terms_repo.dart';

import 'package:sbas/features/main/models/terms_detail_model.dart';
import 'package:sbas/features/main/models/terms_list_model.dart';

class TermsPresenter extends AsyncNotifier{
  late final TermsRepository _repository;

  @override
  FutureOr build() {
    _repository = ref.read(termsRepoProvider);
  }

  Future<List<TermsListModel>> getTermsList(String termsType) async {
    return await _repository.getTermsList(termsType);
  }

  Future<TermsDetailModel> getTermsDetail(String termsType, String termsVersion) async {
    return await _repository.getTermsDetail(termsType, termsVersion);
  }

}

final termsPresenter = AsyncNotifierProvider<TermsPresenter, void> (() => TermsPresenter());