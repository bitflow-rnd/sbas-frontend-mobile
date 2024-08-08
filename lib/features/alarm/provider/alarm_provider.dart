import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/alarm/service/alarm_service.dart';

import 'package:sbas/features/alarm/model/alarm_item_model.dart';

final alarmProvider = Provider<AlarmService>((ref) {
  return AlarmService();
});

final alarmsProvider = FutureProvider<AlarmListModel>((ref) async {
  final service = ref.watch(alarmProvider);
  return service.getAlarms();
});
