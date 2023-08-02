import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/assign/model/assign_list_model.dart';
import 'package:sbas/features/assign/repos/assign_repo.dart';

class AssignBedListPresenter extends AsyncNotifier<AssignListModel> {
  @override
  FutureOr<AssignListModel> build() async {
    _patientRepository = ref.read(assignRepoProvider);

    final list = await _patientRepository.lookupPatientInfo();
    final assignCountState = ref.read(assignCountProvider.notifier).state;

    list[0].x = -1;

    for (int i = 0; i < list.length; i++) {
      assignCountState[i] = list[i].count;
    }
    _list = list[0];

    return _list;
  }

  Future<void> reloadPaitents() async {
    final list = await _patientRepository.lookupPatientInfo();
    final assignCountState = ref.read(assignCountProvider.notifier).state;

    list[0].x = -1;

    for (int i = 0; i < list.length; i++) {
      assignCountState[i] = list[i].count;
    }
    _list = list[0];
  }

  Future<bool> approveReq(Map<String, dynamic> map) async {
    String res = await _patientRepository.postReqApprove(map);
    if (res == "승인 성공") return true;
    return false;
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
      _list = list[index];

      return _list;
    });
    if (state.hasError) {}
  }

  List<String>? getTagList(String? ptId) => _list.items.firstWhere((e) => e.ptId == ptId).tagList;

  late AssignListModel _list;
  late final AssignRepository _patientRepository;
}

final assignBedProvider = AsyncNotifierProvider<AssignBedListPresenter, AssignListModel>(
  () => AssignBedListPresenter(),
);
final assignCountProvider = StateProvider((ref) => <int>[0, 0, 0, 0, 0]);
