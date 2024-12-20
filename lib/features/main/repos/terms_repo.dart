import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sbas/features/main/models/terms_detail_model.dart';
import 'package:sbas/features/main/models/terms_list_model.dart';
import 'package:sbas/features/main/providers/terms_provider.dart';

class TermsRepository {
  Future<List<TermsListModel>> getTermsList(String termsType) async =>
      await _termsProvider.getTermsList(termsType);

  Future<TermsDetailModel> getTermsDetail(String termsType, String termsVersion) async =>
      await _termsProvider.getTermsDetail(termsType, termsVersion);


  final _termsProvider = TermsProvider();
}

final termsRepoProvider = Provider(
  (ref) => TermsRepository(),
);
