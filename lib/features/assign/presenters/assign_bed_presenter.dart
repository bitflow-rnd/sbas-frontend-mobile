import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/assign/model/assign_item_model.dart';
import 'package:sbas/features/assign/model/assign_list_model.dart';
import 'package:sbas/features/assign/repos/assign_repo.dart';

class AssignBedListPresenter extends AsyncNotifier<AssignListModel> {
  @override
  FutureOr<AssignListModel> build() async {
    _asgnRepo = ref.read(assignRepoProvider);

    final list = await _asgnRepo.lookupPatientInfo();
    final assignCountState = ref.read(assignCountProvider.notifier).state;

    list[0].x = -1;

    for (int i = 0; i < list.length; i++) {
      list[i].items.sort((a, b) => (b.updtDttm ?? "").compareTo(a.updtDttm ?? ""));
      assignCountState[i] = list[i].count;
    }
    _list = list[0];

    return _list;
  }

  reloadPatients() {
    setTopNavItem(ref.read(assignTabXindexProvider.notifier).state);
  }

  Future<dynamic> approveReq(Map<String, dynamic> map) async {
    var res = await _asgnRepo.postReqConfirm(map);
    if (res == "승인 성공" || res == "check push token") {
      return true;
    }
    return false;
  }

  Future<bool> rejectReq(Map<String, dynamic> map) async {
    String res = await _asgnRepo.postReqConfirm(map);
    if (res == "배정 불가 처리 완료") return true;
    return false;
  }

  Future<void> search() async {
    AssignListModel tempList = _list;

    if (searchTextController.text.isEmpty) {
      state = AsyncValue.data(tempList);
      return;
    }

    state = const AsyncValue.loading();

    try {
      AssignListModel filteredItems = AssignListModel(count: 0, x: ref.read(assignTabXindexProvider.notifier).state, items: []);
      for (AssignItemModel item in tempList.items) {
        if ((item.ptNm?.contains(searchTextController.text.toLowerCase()) ?? false)) {
          //::TODO 현재 assign bed item 에 환자의 이름만 있어서 이를 기준으로 검색하게만 구현. dto 변경필요
          filteredItems.items.add(item);
          filteredItems.count++;
        }
      }

      state = AsyncValue.data(filteredItems);
    } catch (error) {
      // state = AsyncValue.error(error);
    }
  }

  Future<void> setTopNavItem(double x) async {
    searchTextController.clear();
    state = await AsyncValue.guard(() async {
      final list = await _asgnRepo.lookupPatientInfo();
      final assignCountState = ref.read(assignCountProvider.notifier).state;
      final index = (x * 2).toInt() + 2;

      list[index].x = x;
      ref.watch(assignTabXindexProvider.notifier).state = x;

      for (int i = 0; i < list.length; i++) {
        list[i].items.sort((a, b) => (b.updtDttm ?? "").compareTo(a.updtDttm ?? ""));

        assignCountState[i] = list[i].count;
      }
      _list = list[index];

      return _list;
    });
    if (state.hasError) {}
  }

  List<String>? getTagList(String? ptId) => _list.items.firstWhere((e) => e.ptId == ptId).tagList;
  TextEditingController searchTextController = TextEditingController();
  late AssignListModel _list;
  late final AssignRepository _asgnRepo;
}

final assignBedProvider = AsyncNotifierProvider<AssignBedListPresenter, AssignListModel>(
  () => AssignBedListPresenter(),
);
final assignCountProvider = StateProvider((ref) => <int>[0, 0, 0, 0, 0]);
final assignTabXindexProvider = StateProvider((ref) => -1.0);
