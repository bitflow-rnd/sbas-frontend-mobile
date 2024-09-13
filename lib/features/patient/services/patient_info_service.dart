import 'package:sbas/features/patient/models/patient_model.dart';
import 'package:sbas/common/api/v1_provider.dart';

class PatientService {

  Future<Patient> getPatient(String? ptId) async {
    final response = await _api.getAsync('$_baseUrl/basicinfo/$ptId');

    return Patient.fromJson(response);
  }


  final String _baseUrl = '/private/patient';
  final _api = V1Provider();

}