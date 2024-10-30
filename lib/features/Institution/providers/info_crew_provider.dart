import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/Institution/models/info_crew_model.dart';
import 'package:sbas/features/Institution/services/inst_service.dart';

class InfoCrewNotifier extends AutoDisposeFamilyAsyncNotifier<List<InfoCrew>, String> {
  @override
  FutureOr<List<InfoCrew>> build(String arg) {
    Map<String, String> map = {
      'instId': arg,
    };

    return _instService.getFiremen(map);
  }

  final _instService = InstService();
}

final infoCrewProvider = AsyncNotifierProvider.autoDispose.family<InfoCrewNotifier, List<InfoCrew>, String>(
  InfoCrewNotifier.new,
);