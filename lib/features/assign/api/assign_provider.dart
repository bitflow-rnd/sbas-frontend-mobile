import 'package:sbas/common/api/v1_provider.dart';

class AssignProvider {
  Future<List<dynamic>> lookupPatientInfo() async =>
      await _api.getAsync('$_privateRoute/list');

  final _privateRoute = 'private/bedasgn';
  final _api = V1Provider();
}
