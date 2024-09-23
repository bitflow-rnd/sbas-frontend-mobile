import 'package:sbas/common/api/v1_provider.dart';
import 'package:sbas/features/patient/models/patient_model.dart';

class PatientService {

  Future<Patient> getPatient(String? ptId) async {
    if (ptId == null) {
      throw Exception("Patient ID cannot be null");
    }

    final response = await _api.getAsync('$_baseUrl/basicinfo/$ptId');
    return Patient.fromJson(response);
  }

  final String _baseUrl = '/private/patient';
  final _api = V1Provider();

}