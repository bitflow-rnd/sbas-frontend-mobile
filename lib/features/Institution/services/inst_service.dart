import 'package:sbas/common/api/v1_provider.dart';
import 'package:sbas/features/Institution/models/info_crew_model.dart';

class InstService {

  Future<List<InfoCrew>> getFiremen(Map<String, String> map) async {
    final response = await _api.getAsyncWithMap('$_baseUrl/firemen', map);
    if (response['items'] is List<dynamic>) {
      return List<InfoCrew>.from(response['items'].map((item) => InfoCrew.fromJson(item as Map<String, dynamic>)));
    } else {
      throw Exception("Invalid response format");
    }
  }

  final String _baseUrl = '/private/organ';
  final _api = V1Provider();
}