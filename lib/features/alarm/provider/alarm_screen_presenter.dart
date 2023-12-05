import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/alarm/model/alarm_item_model.dart';

import '../alarm_item_database_service.dart';

class AlarmScreenPresenter extends AsyncNotifier<List<AlarmItemModel>> {
  @override
  FutureOr<List<AlarmItemModel>> build() {
    return getAlarmItem();
  }

  Future<List<AlarmItemModel>> getAlarmItem() async {
    Future<List<AlarmItemModel>> selectItem = AlarmItemDatabaseService()
        .databaseConfig()
        .then((_) => AlarmItemDatabaseService().selectAllByUserId());
    return selectItem;
  }

}

final alarmScreenProvider = AsyncNotifierProvider<AlarmScreenPresenter, List<AlarmItemModel>>(
    () => AlarmScreenPresenter(),
);
