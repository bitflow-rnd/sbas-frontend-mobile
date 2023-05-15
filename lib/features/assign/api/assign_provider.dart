import 'package:sbas/common/api/v1_provider.dart';

class AssignProvider {
  Future<dynamic> lookupPatientInfo(String code) async =>
      await _api.getAsync('$_privateRoute/list?q=$code');

  final _privateRoute = 'private/bedasgn';
  final _api = V1Provider();
}
