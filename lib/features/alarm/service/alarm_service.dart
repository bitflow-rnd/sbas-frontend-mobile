import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sbas/features/alarm/model/alarm_item_model.dart';
import 'package:sbas/common/api/v1_provider.dart';

class AlarmService {

  Future<AlarmListModel> getAlarms() async {
    final response = await _api.getAsync('$_baseUrl/alarm-list');
    print(response);

    return AlarmListModel.fromJson(response);
  }

  final String _baseUrl = '/private/user';
  final _api = V1Provider();
}