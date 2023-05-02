import 'package:sbas/common/api/v1_provider.dart';
import 'package:sbas/features/lookup/models/patient_info_model.dart';

class PrivatePatientProvider {
  Future<PatientInfoModel> lookupPatientInfo() async =>
      PatientInfoModel.fromJson(await _api.getAsync('$_privateRoute/search'));

  final String _privateRoute = 'private/patient';

  final _api = V1Provider();
}
