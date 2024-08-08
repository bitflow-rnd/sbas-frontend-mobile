import 'package:sbas/common/api/v1_provider.dart';
import 'package:sbas/features/alarm/model/alarm_item_model.dart';
import 'package:sbas/util.dart';

class AlarmService {

  Future<AlarmListModel> getAlarms() async {
    final response = await _api.getAsync('$_baseUrl/alarm-list');
    readAlarms();

    return AlarmListModel.fromJson(response);
  }

  Future<void> readAlarms() async {
    final response = await _api.postAsync('$_baseUrl/read-alarms', '');

    showToast(response);
  }

  final String _baseUrl = '/private/user';
  final _api = V1Provider();
}