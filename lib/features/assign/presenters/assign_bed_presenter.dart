import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/assign/model/assign_list_model.dart';
import 'package:sbas/features/assign/repos/assign_repo.dart';

class AssignBedPresenter extends AsyncNotifier<AssignListModel> {
  @override
  FutureOr<AssignListModel> build() async {
    _patientRepository = ref.read(assignRepoProvider);

    final list = await _patientRepository.lookupPatientInfo();
    final assignCountState = ref.read(assignCountProvider.notifier).state;

    list[0].x = -1;

    for (int i = 0; i < list.length; i++) {
      assignCountState[i] = list[i].count;
    }
    return list[0];
  }

  Future<void> setTopNavItem(double x) async {
    state = await AsyncValue.guard(() async {
      final list = await _patientRepository.lookupPatientInfo();
      final assignCountState = ref.read(assignCountProvider.notifier).state;
      final index = (x * 2).toInt() + 2;

      list[index].x = x;

      for (int i = 0; i < list.length; i++) {
        assignCountState[i] = list[i].count;
      }
      return list[index];
    });
    if (state.hasError) {}
  }

  late final AssignRepository _patientRepository;
}

final assignBedProvider =
    AsyncNotifierProvider<AssignBedPresenter, AssignListModel>(
  () => AssignBedPresenter(),
);
final assignCountProvider = StateProvider((ref) => <int>[0, 0, 0, 0, 0]);
