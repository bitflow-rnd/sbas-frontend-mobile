import 'package:sbas/common/api/v1_provider.dart';

import '../models/terms_detail_model.dart';
import '../models/terms_list_model.dart';

class TermsProvider {
  Future<List<TermsListModel>> getTermsList(String termsType) async =>
      TermsListModel.listFromJson(await _api.getAsync('$_publicRoute/terms/$termsType'));
  
  Future<TermsDetailModel> getTermsDetail(String termsType, String termsVersion) async =>
      TermsDetailModel.fromJson(await _api.getAsync('$_publicRoute/terms/detail/$termsType/$termsVersion'));

  final String _publicRoute = 'public/common';
  final String _privateRoute = 'private/common';
  
  final _api = V1Provider();
}